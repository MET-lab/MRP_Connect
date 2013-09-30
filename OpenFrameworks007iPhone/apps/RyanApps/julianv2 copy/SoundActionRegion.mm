#include "SoundActionRegion.h"


SoundActionRegion::SoundActionRegion(void)
{
	useStaticSoundActions = true;
	useDynamicSoundActions = false;
	//Default to blank
	//Must be populate dusing 'new' in instruface creation
	dynamicSoundFromFileTemplate = NULL;
	dynamicSoundFromSynthTemplate  = NULL;
	//Default to only use synth template
	templateToUse = SoundActionRegion::TEMPLATE_TO_USE::FROM_SYNTH;
	textSizeProportionalToSARSize = false;
	firstDrawCall = true;
	autoGenerateTextAsNoteName = true;

	//Construct initial text
	updateText();
}

SoundActionRegion::~SoundActionRegion(void)
{
}

void SoundActionRegion::updateText()
{
	if(autoGenerateTextAsNoteName)
	{
		int numSynth = soundsFromSynth.size();
		text.content = "";
		for(int i = 0; i < numSynth; i++)
		{
			text.content += ( soundsFromSynth[i].getNoteNameFromFreq(soundsFromSynth[i].getFrequency()) + " ");
		}
	}
}

void SoundActionRegion::updateColors()
{
	//Touch has changed - change color?
	int numTouches = getManipulationProcessorPtr()->getNumTouches();

	if(numTouches > 0)
	{
		//Touches are down - keep pressed
		useAlternateFill = true;
	}
	else
	{
		//Touches aren't down - change back to default
		useAlternateFill = false;
	}
}

void SoundActionRegion::draw()
{
	//update text only once when the entire SAR has been initialized and is first drawn
	//Annoying but...?
	if(firstDrawCall)
	{
		updateText();
		firstDrawCall = false;
	}

	//Draw normally
	Shape::draw();
	
	ofSetColor(text.textColorR,text.textColorG,text.textColorB,text.textColorA);
	ofFill();
	ofPoint sarCenter =  getBoundingRectPtr()->getCenterPoint();

	ofRectangle boundingRect = text.font.getStringBoundingBox(text.content,0,0);

	//Fix this
	text.font.drawString(text.content, sarCenter.x - .5*boundingRect.width,sarCenter.y + .5*boundingRect.height);
}

bool SoundActionRegion::needsAudioRequest()
{
	//Try looping through SAs? and asking if they need audio?

	//If touches are within the shape - sound needs to be produced
	//Fix evetually to include sounds that play without touch (after touch released)
	if(getManipulationProcessorPtr()->getNumTouches() > 0)
	{
		return true;
	}
	return false;
}



vector<SoundAction*> SoundActionRegion::getSoundActionPtrs()
{
	//Contruct a vector of pointers to the real stored locations
	vector<SoundAction*> rV;

	for(int i = 0; i < soundsFromFile.size() ; i++)
	{
		rV.push_back(&soundsFromFile[i]);
	}

	for(int j = 0; j < soundsFromSynth.size() ; j++)
	{
		rV.push_back(&soundsFromSynth[j]);
	}
	return rV;
}


void SoundActionRegion::touchDown(ofTouchEventArgs & touch)
{
	if(useStaticSoundActions)
	{
		//Create a dynamic action for this touch?
		bool createDynamic = false;

		vector<SoundAction*> soundActionPtrs = getSoundActionPtrs();

		//Loop through static actions
		for(int i = 0; i < soundActionPtrs.size(); i++)
		{
			if(soundActionPtrs[i]->isPlaying() && !useDynamicSoundActions)
			{
				//Playing and not using dynamic - end action
				soundActionPtrs[i]->end();
			}
			else if(!soundActionPtrs[i]->isPlaying() && !useDynamicSoundActions)
			{
				//Not playing and not using dynamic - start normally
				soundActionPtrs[i]->start(touch.id);
			}
			else if(soundActionPtrs[i]->isPlaying() && useDynamicSoundActions)
			{
				//Playing and using dynamic - end normally and add dynamic action
				soundActionPtrs[i]->end();

				createDynamic = true;
			}
			else if(!soundActionPtrs[i]->isPlaying() && useDynamicSoundActions)
			{
				//Not playing and using dynamic - start normally and add dynamic action
				soundActionPtrs[i]->start(touch.id);
				
				createDynamic = true;
			}
		}
		if(createDynamic)
		{
			//Add dynamic action and start
			addDynamicSoundAction(touch.id)->start(touch.id);
		}
	}
	else
	{
		if(useDynamicSoundActions)
		{
			//Not using static sounds
			//Just create dynamic sound and start
			SoundAction * newAction =  addDynamicSoundAction(touch.id);
			//Check that newAction is started correctly?
			if(newAction->associatedTouchID>-1)
			{
				newAction->start(touch.id);
			}
		}
	}

	//Freq changed? 
	updateText();

	//Update colors
	updateColors();
}

SoundAction * SoundActionRegion::addDynamicSoundAction(int touchID)
{
	//Create actions for each template used
	if(templateToUse == SoundActionRegion::TEMPLATE_TO_USE::FROM_SYNTH)
	{
		if(dynamicSoundFromSynthTemplate != NULL)
		{
			return addDynamicFromSynthSoundAction(touchID);
		}
	}
	else if(templateToUse == SoundActionRegion::TEMPLATE_TO_USE::FROM_FILE)
	{
		if(dynamicSoundFromFileTemplate != NULL)
		{
			return addDynamicFromFileSoundAction(touchID);
		}
	}
	else if(templateToUse == SoundActionRegion::TEMPLATE_TO_USE::BOTH)
	{
		if( (dynamicSoundFromSynthTemplate != NULL) && (dynamicSoundFromFileTemplate != NULL) )
		{
			addDynamicFromFileSoundAction(touchID);
			addDynamicFromSynthSoundAction(touchID);
			return NULL; //Figure out what to do?
		}
	}
	else
	{
		//Do not create action from any template
	}
	return NULL;
}

SoundAction * SoundActionRegion::addDynamicFromFileSoundAction(int touchID)
{
	//Get from template
	SoundFromFile sff = getSoundFromFileFromTemplate();
	sff.associatedTouchID = touchID;
	//Add to vector
	soundsFromFile.push_back(sff);
	//Return pointer to spot in vector - risky...
	return &soundsFromFile.back();
}

SoundAction * SoundActionRegion::addDynamicFromSynthSoundAction(int touchID)
{
	//Get from template
	SoundFromSynth sfs = getSoundFromSynthFromTemplate();
	sfs.associatedTouchID = touchID;
	//Add to vector
	soundsFromSynth.push_back(sfs);
	//Return pointer to spot in vector - risky...
	return &soundsFromSynth.back();
}


SoundFromFile SoundActionRegion::getSoundFromFileFromTemplate()
{
	SoundFromFile rV;
	rV = *(dynamicSoundFromFileTemplate);
	return rV;
}
SoundFromSynth SoundActionRegion::getSoundFromSynthFromTemplate()
{
	SoundFromSynth rV;
	rV = *(dynamicSoundFromSynthTemplate);
	return rV;
}

void SoundActionRegion::removeDynamicSoundAction(int touchID)
{
	//Loop through both lists of SAs
	//vector<SoundFromFile> soundsFromFile;
	//vector<SoundFromSynth> soundsFromSynth;

	//Loop through actions
	int size = soundsFromFile.size();
	vector<SoundFromFile>::iterator iter;
	for(iter = soundsFromFile.begin(); iter != soundsFromFile.end(); iter++)
	{
		if( iter->associatedTouchID == touchID)
		{
			//Stop playing sound befor erasing
			iter->end();
			soundsFromFile.erase(iter);
			//Break to increase speed?
			break;
		}
	}

	//Loop through actions
	size = soundsFromSynth.size();
	vector<SoundFromSynth>::iterator iter2;
	for(iter2 = soundsFromSynth.begin(); iter2 != soundsFromSynth.end(); iter2++)
	{
		if( iter2->associatedTouchID == touchID)
		{
			iter2->end();
			soundsFromSynth.erase(iter2);
			//Break to increase speed?
			break;
		}
	}
}

void SoundActionRegion::touchUp(ofTouchEventArgs & touch)
{
	vector<SoundAction*> soundActionPtrs = getSoundActionPtrs();

	//If using static, end all sound actions
	if(useStaticSoundActions)
	{
		for(int i = 0; i < soundActionPtrs.size(); i++)
		{
			soundActionPtrs[i]->end();
		}
	}

	//if using dynamic, remove the action for this touch
	if(useDynamicSoundActions)
	{
		//Remove the associated tone
		removeDynamicSoundAction(touch.id);
	}
	//Freq changed? 
	updateText();

	//Update colors
	updateColors();
}

void SoundActionRegion::touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	vector<SoundAction*> soundActionPtrs = getSoundActionPtrs();

	if(useStaticSoundActions)
	{
		//Create a dynamic action for this touch?
		bool createDynamic = false;

		//Loop through static actions
		for(int i = 0; i < soundActionPtrs.size(); i++)
		{
			if(soundActionPtrs[i]->isPlaying() && !useDynamicSoundActions)
			{
				//Playing and not using dynamic - end action
				soundActionPtrs[i]->end();
			}
			else if(!soundActionPtrs[i]->isPlaying() && !useDynamicSoundActions)
			{
				//Not playing and not using dynamic - start normally
				soundActionPtrs[i]->start(touchNow.id);
			}
			else if(soundActionPtrs[i]->isPlaying() && useDynamicSoundActions)
			{
				//Playing and using dynamic - end normally and add dynamic action
				soundActionPtrs[i]->end();

				createDynamic = true;
			}
			else if(!soundActionPtrs[i]->isPlaying() && useDynamicSoundActions)
			{
				//Not playing and using dynamic - start normally and add dynamic action
				soundActionPtrs[i]->start(touchNow.id);
				
				createDynamic = true;
			}
		}
		if(createDynamic)
		{
			//Add dynamic action and start
			addDynamicSoundAction(touchNow.id)->start(touchNow.id);
		}
	}
	else
	{
		if(useDynamicSoundActions)
		{
			//Not using static sounds
			//Just create dynamic sound and start
			addDynamicSoundAction(touchNow.id)->start(touchNow.id);
		}
	}
	//Freq changed? 
	updateText();

	//Update colors
	updateColors();
}
void SoundActionRegion::touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	/*Old code
	for(int i = 0; i < soundActionPtrs.size(); i++)
	{
		soundActionPtrs[i]->end();
	}
	*/

	vector<SoundAction*> soundActionPtrs = getSoundActionPtrs();

	//If using static, end all sound actions
	if(useStaticSoundActions)
	{
		for(int i = 0; i < soundActionPtrs.size(); i++)
		{
			soundActionPtrs[i]->end();
		}
	}

	//if using dynamic, remove the action for this touch
	if(useDynamicSoundActions)
	{
		//Remove the associated tone
		removeDynamicSoundAction(touchNow.id);
	}
	//Freq changed? 
	updateText();

	//Update colors
	updateColors();
}
void SoundActionRegion::touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	//No manipulation actions done here.
	//Only sound actions are modified here

	vector<SoundAction*> soundActionPtrs = getSoundActionPtrs();

	//Get the bounding rectangle for this region
	BoundingRect r = getBoundingRect();
	float width = r.getBottomRightPoint().x - r.getTopLeftPoint().x;
	float height = r.getBottomRightPoint().y - r.getTopLeftPoint().y;

	float x = touchNow.x * ScreenObject::SCREEN_WIDTH;
	float y = touchNow.y * ScreenObject::SCREEN_HEIGHT;

	//Get touch percent x and y position 
	float percentX = (x - r.getTopLeftPoint().x) / width;
	float percentY = (y - r.getTopLeftPoint().y) / height;

	//cout << "perx: " << percentX << " pery: " << percentY << endl;

	for(int i = 0; i < soundActionPtrs.size(); i++)
	{
		if(useDynamicSoundActions)
		{
			//Make sur ot modify only SA related to the touch being moved
			if(soundActionPtrs[i]->associatedTouchID == touchNow.id)
			{
				soundActionPtrs[i]->modify(percentX,percentY);
			}
		}
		
		if(useStaticSoundActions)
		{
			soundActionPtrs[i]->modify(percentX,percentY);
		}
	}
	//Freq changed? 
	updateText();
}


void SoundActionRegion::touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY)
{
	//No default behaviour for multitouch actions within sound action regions
}
void SoundActionRegion::touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees)
{
	//No default behaviour for multitouch actions within sound action regions
}
void SoundActionRegion::touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY)
{
	//No default behaviour for multitouch actions within sound action regions
}

void SoundActionRegion::setTextString(string txt)
{
	text.content = txt;
}
string SoundActionRegion::getTextString()
{
	return text.content;
}