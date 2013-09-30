#pragma message ("\tAttempting to open SAR Header...")
#pragma once
#pragma message ("\tOpened SAR Header.")
#include "shape.h"
#include <vector>
#include "SoundHandler.h"
#include "SoundAction.h"
#include "SoundFromFile.h"
#include "SoundFromSynth.h"
#include <string>
#include "SoundActionRegionText.h"


//class SoundFromFile;
//class SoundFromSynth;


using namespace std;

class SoundActionRegion : public Shape
{
public:
	string toString();
	void draw();
	vector<SoundFromFile> soundsFromFile;
	vector<SoundFromSynth> soundsFromSynth;
	vector<SoundAction*> getSoundActionPtrs();
	void touchDown(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY);
	void touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees);
	void touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY);

	bool useStaticSoundActions;
	bool useDynamicSoundActions;
	bool needsAudioRequest();

	//Templates for creating sounds
	SoundFromFile * dynamicSoundFromFileTemplate;
	SoundFromSynth * dynamicSoundFromSynthTemplate;

	//Choose which templates to use
	enum TEMPLATE_TO_USE { 
		FROM_FILE,
		FROM_SYNTH,
		BOTH,
		NONE
	};
	TEMPLATE_TO_USE templateToUse;


	//Be able to access the handler
	//SoundHandler * associatedSoundHandlerPtr;

	SoundAction * addDynamicSoundAction(int touchID);
	void removeDynamicSoundAction(int touchID);

	SoundActionRegion(void);
	~SoundActionRegion(void);

	//Enable text within SARs - good for note labels
	void setTextString(string txt);
	string getTextString();
	//Make getters and setters for rest of text properties
	SoundActionRegionText text;

	
	bool textSizeProportionalToSARSize;
	bool autoGenerateTextAsNoteName;


private:
	SoundFromFile getSoundFromFileFromTemplate();
	SoundFromSynth getSoundFromSynthFromTemplate();
	SoundAction * addDynamicFromFileSoundAction(int touchID);
	SoundAction * addDynamicFromSynthSoundAction(int touchID);
	void updateText();
	void updateColors();
	bool firstDrawCall;
};




