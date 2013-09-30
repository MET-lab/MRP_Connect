#include "Instruface.h"
#include <vector>

using namespace std;

Instruface::Instruface(void)
{
	return; //Do nothing for now//////////////////////////////////////////////////////////////////////////

	//Initialize background shape default values;
	name = "";

	backgroundBorderLeft = 50;
	backgroundBorderRight = 50;
	backgroundBorderTop = 50;
	backgroundBorderBottom = 50;
	backgroundFill.fillStyle = backgroundFill.SOLIDCOLOR;
	backgroundFill.r = 0;
	backgroundFill.g = 0;
	backgroundFill.b = 0;
	backgroundFill.a = 255/2;

	//As test manually create objects here rather than loading from file
	//create440Square();
	//createGridtar();
	//createPolytheremin();
	//create440Hexagon();

	
	//Try to load from file (directory, really)
	if(tmpSelection == 0)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\SimplePiano");
	}
	else if(tmpSelection == 1)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\Polytheremin");
	}
	else if(tmpSelection == 2)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\PictureTheremin");
	}
	
	

	//Only call once
	addBackgroundShape();

	//Always do last
	finalizeTouchableObjects();
}

Instruface::Instruface(int tmpSelector)
{
	//Clear old info?
	shapes.clear();
	soundActionRegions.clear();

	tmpSelection = tmpSelector;
	//Initialize background shape default values;
	name = "";
	backgroundBorderLeft = 50;
	backgroundBorderRight = 50;
	backgroundBorderTop = 50;
	backgroundBorderBottom = 50;
	backgroundFill.fillStyle = backgroundFill.SOLIDCOLOR;
	backgroundFill.r = 0;
	backgroundFill.g = 0;
	backgroundFill.b = 0;
	backgroundFill.a = 255/2;

	//As test manually create objects here rather than loading from file
	//create440Square();
	//createGridtar();
	//createPolytheremin();
	//create440Hexagon();

	//Try to load from file (directory, really)
	if(tmpSelection == 0)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\SimplePiano");
	}
	else if(tmpSelection == 1)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\Polytheremin");
	}
	else if(tmpSelection == 2)
	{
		loadFromFile("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\Instrufaces\\PictureTheremin");
	}

	//Only call once once loaded
	addBackgroundShape();

	//Always do last
	finalizeTouchableObjects();
}

void Instruface::touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY)
{
	//Try to get parent to handle it (not likely for an instruface)
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->moveBy(delX,delY);
	}
	else
	{
		//Default behavior do it your self
		moveBy(delX,delY);
	}
}
void Instruface::touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees)
{
	//Try to get parent to handle it (not likely for an instruface)
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->rotateClockWise(rotationDegrees);
	}
	else
	{
		//Default behavior do it your self
		rotateClockWise(rotationDegrees);
	}
}
void Instruface::touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY)
{
	//cout << "Instruface Scaled: " << scaleFactorX << endl;
	//Try to get parent to handle it (not likely for an instruface)
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->touchesScaled(touches, scaleFactorX, scaleFactorY);
	}
	else
	{
		//Default behavior do it your self
		scale(scaleFactorX, scaleFactorY);
	}
}

void Instruface::finalizeTouchableObjects()
{
	//Loop through shapes and sound action regions
	//And add pointers to those objects
	//This is dangerous and the vectors of shapes and sound action regions
	//Must not be modified after this
	//Add sound actions regions last because they are drawn last
	//And hence they are drawn on top (come up with a better way of organizing this)
	
	//Clear out vectors incase this is called twice by accident or by need?
	childrenTouchPtrs.clear();
	childrenScreenPtrs.clear();

	for(int i = 0; i < shapes.size(); i++)
	{
		addTouchChild(&shapes[i]);
		addScreenChild(&shapes[i]);	
	}

	for(int i = 0; i < soundActionRegions.size(); i++)
	{
		addTouchChild(&soundActionRegions[i]);
		addScreenChild(&soundActionRegions[i]);
	}
}


void Instruface::addShape(Shape s)
{
	//Receive a copy of a shape s
	//Store parent as this instruface
	//Nevermind - this is done in the finalizeTouchableObjects function
	//s.setTouchParent(this);
	//s.setScreenParent(this);

	//Store copy of this shape permanently
	shapes.push_back(s);
}
void Instruface::addSoundActionRegion(SoundActionRegion sar)
{	
	//Receive a copy of a SAR
	//Store parent as this instruface
	//Nevermind - this is done in the finalizeTouchableObjects function
	//sar.setTouchParent(this);
	//sar.setScreenParent(this);

	//Store copy this shape permanently
	soundActionRegions.push_back(sar);
}
vector<Shape*> Instruface::getShapePtrs()
{
	//Contruct a vector of pointers to the real stored locations
	vector<Shape*> rV;

	for(int i = 0; i < shapes.size() ; i++)
	{
		rV.push_back(&shapes[i]);
	}

	return rV;
}
vector<SoundActionRegion*> Instruface::getSoundActionRegionPtrs()
{
	//Contruct a vector of pointers to the real stored locations
	vector<SoundActionRegion*> rV;

	for(int i = 0; i < soundActionRegions.size() ; i++)
	{
		rV.push_back(&soundActionRegions[i]);
	}

	return rV;
}




Instruface::~Instruface(void)
{
}

bool Instruface::fileExists(string fullFilePath)
{
  ifstream ifile(fullFilePath.c_str());
  return ifile;
  //The file is automatically closed at the end of the function scope.
}

string Instruface::readEntireFile(string fullFilePath)
{
	string file;
	string line;
	ifstream myfile(fullFilePath);
	if (myfile.is_open())
	{
		while ( myfile.good() )
		{
			getline(myfile,line);
			file += line;
		}
		myfile.close();
	}
	return file;
}

string Instruface::stripTagsReturnTextWithin(string xmlTagName,string & workingText)
{
	//Strips surrounding tags and returns text within those tags

	//Find first instance of tag
	string openTag = "<" + xmlTagName + ">";
	string closeTag = "</" + xmlTagName + ">";

	int openTagPos = workingText.find(openTag);
	int closeTagPos = workingText.find(closeTag);
	bool returnNothing = false;
	if(openTagPos < 0 || closeTagPos < 0)
	{
		//Tag not found
		//Return nothing
		returnNothing = true;
	}
	if(openTagPos >= closeTagPos)
	{
		//Tags corrupted
		return "";
	}

	string textWithTags = workingText.substr(openTagPos, (closeTagPos - openTagPos) + closeTag.length());

	openTagPos = textWithTags.find(openTag);
	closeTagPos = textWithTags.find(closeTag);
	
	string textNoOpenTag = textWithTags.substr(openTagPos + openTag.length(), textWithTags.length() - openTag.length());
	
	openTagPos = textNoOpenTag.find(openTag);
	closeTagPos = textNoOpenTag.find(closeTag);

	string textNoOpenCloseTag = textNoOpenTag.substr(0,closeTagPos);

	//Remove tag and text from working text
	openTagPos = workingText.find(openTag);
	closeTagPos = workingText.find(closeTag);
	string textBeforeOpenTag = workingText.substr(0,openTagPos);
	string textAfterCloseTag = workingText.substr(closeTagPos + closeTag.length(), workingText.length() - ( closeTagPos + closeTag.length()));
	//New working text is text before + text after
	workingText = textBeforeOpenTag + textAfterCloseTag;

	if(!returnNothing)
	{
		return textNoOpenCloseTag;
	}
	else
	{
		return "";
	}
}

string Instruface::instFileFullPath(string formattedDirectoryPath, string instName)
{
	return formattedDirectoryPath + instName + ".inst";
}

string Instruface::addTrailingSlashIfNeeded(string path)
{
	if(path[path.length() - 1] != '\\')
	{
		path += '\\';
	}
	return path;
}



void Instruface::loadFromFile(string directoryPath)
{
	//Get the correct full file path to inst directory
	string tmpDirPath = ofToDataPath(directoryPath,false);
	fullDirectoryPath = addTrailingSlashIfNeeded(tmpDirPath);
	
	//Get the instrument name from the directoryPath
	name = instNameFromFormattedDirectoryPath(fullDirectoryPath);

	//Get the name of .inst file that should exist
	fullInstFilePath = instFileFullPath(fullDirectoryPath,name);

	//Check to see that an inst file exits with the 
	bool exists = fileExists(fullInstFilePath);

	//If inst file exists
	if(exists)
	{
		//Read in the entire inst file
		string entireInstFile = readEntireFile(fullInstFilePath);

		//Strip out instruface tag and get text within
		string instrufaceText = stripTagsReturnTextWithin("Instruface",entireInstFile);
		string nameFromInsideFile = stripTagsReturnTextWithin("Name", instrufaceText);
		if(nameFromInsideFile != name)
		{
			cout << "Warning: Name from file read as " << nameFromInsideFile << " while name from directory is " << name << endl;
		}
		backgroundBorderTop = toFloat(stripTagsReturnTextWithin("BackgroundBorderTop", instrufaceText));
		backgroundBorderLeft = toFloat(stripTagsReturnTextWithin("BackgroundBorderLeft", instrufaceText));
		backgroundBorderBottom = toFloat(stripTagsReturnTextWithin("BackgroundBorderBottom", instrufaceText));
		backgroundBorderRight = toFloat(stripTagsReturnTextWithin("BackgroundBorderRight", instrufaceText));

		string shapesText = stripTagsReturnTextWithin("Shapes",instrufaceText);
		getAndAddShapes(shapesText);
		string soundActionRegionsText = stripTagsReturnTextWithin("SoundActionRegions",instrufaceText);
		getAndAddSoundActionRegions(soundActionRegionsText);
	}
	else
	{
		cout << "Error: Inst file " << name << ".inst does not exist in " << fullDirectoryPath << endl;
	}
}

void Instruface::getAndAddSoundActionRegions(string soundActionRegionsXMLText)
{
	if(soundActionRegionsXMLText != "")
	{
		string sarText = stripTagsReturnTextWithin("SoundActionRegion",soundActionRegionsXMLText);
		while(sarText != "")
		{
			SoundActionRegion newSAR = getSoundActionRegionFromXML(sarText);
			addSoundActionRegion(newSAR);
			sarText = stripTagsReturnTextWithin("SoundActionRegion",soundActionRegionsXMLText);
		}
	}
}
SoundActionRegion Instruface::getSoundActionRegionFromXML(string sarXML)
{
	SoundActionRegion sarRV;
	getAndAddSoundsFromFile(stripTagsReturnTextWithin("SoundsFromFile",sarXML),sarRV);
	getAndAddSoundsFromSynth(stripTagsReturnTextWithin("SoundsFromSynth",sarXML),sarRV);
	sarRV.useStaticSoundActions = toBool(stripTagsReturnTextWithin("UseStaticSoundActions",sarXML));
	sarRV.useDynamicSoundActions = toBool(stripTagsReturnTextWithin("UseDynamicSoundActions",sarXML));
	sarRV.templateToUse = (SoundActionRegion::TEMPLATE_TO_USE)getTemplateToUseFromXML(stripTagsReturnTextWithin("TemplateToUse",sarXML));
	sarRV.dynamicSoundFromSynthTemplate = new SoundFromSynth();
	*sarRV.dynamicSoundFromSynthTemplate = getDynamicSoundFromSynthTemplateFromXML(stripTagsReturnTextWithin("DynamicSoundFromSynthTemplate",sarXML));
	sarRV.dynamicSoundFromFileTemplate = new SoundFromFile();
	*sarRV.dynamicSoundFromFileTemplate = getDynamicSoundFromFileTemplateFromXML(stripTagsReturnTextWithin("DynamicSoundFromFileTemplate",sarXML));
	sarRV.text = getSoundActionRegionTextFromXML(stripTagsReturnTextWithin("SoundActionRegionText",sarXML));
	sarRV.textSizeProportionalToSARSize = toBool(stripTagsReturnTextWithin("ScaleTextSize",sarXML));
	sarRV.autoGenerateTextAsNoteName = toBool(stripTagsReturnTextWithin("AutoGenerateTextAsNoteNames",sarXML));
	Shape shapeInfo = getShapeFromXML(stripTagsReturnTextWithin("ShapeInfo",sarXML));
	applyShapeInfoToSoundActionRegion(shapeInfo,sarRV);
	return sarRV;
}

SoundActionRegionText Instruface::getSoundActionRegionTextFromXML(string soundActionRegionTextXML)
{
	return SoundActionRegionText();
}

void Instruface::getAndAddShapes(string shapesXMLText)
{
	if(shapesXMLText != "")
	{
		string shapeText = stripTagsReturnTextWithin("Shape",shapesXMLText);
		while(shapeText != "")
		{
			Shape newShape = getShapeFromXML(shapeText);
			addShape(newShape);
			shapeText = stripTagsReturnTextWithin("Shape",shapesXMLText);
		}
	}
}

ShapeFill Instruface::getShapeFillFromXML(string shapeFillXML)
{
	ShapeFill rV;
	rV.fillStyle = (ShapeFill::FILL_STYLE)getShapeFillStyleFromXML(stripTagsReturnTextWithin("FillStyle",shapeFillXML));
	rV.r = toFloat(stripTagsReturnTextWithin("FillR",shapeFillXML));
	rV.g = toFloat(stripTagsReturnTextWithin("FillG",shapeFillXML));
	rV.b = toFloat(stripTagsReturnTextWithin("FillB",shapeFillXML));
	rV.a = toFloat(stripTagsReturnTextWithin("FillA",shapeFillXML));
	rV.hasBorder = toBool(stripTagsReturnTextWithin("HasBorder",shapeFillXML));
	if(rV.hasBorder)
	{
		rV.borderThickness = toFloat(stripTagsReturnTextWithin("BorderThickness",shapeFillXML));
		rV.borderThicknessScales = toBool(stripTagsReturnTextWithin("BorderThicknessScales",shapeFillXML));
		rV.rBorder = toFloat(stripTagsReturnTextWithin("BorderFillR",shapeFillXML));
		rV.gBorder = toFloat(stripTagsReturnTextWithin("BorderFillG",shapeFillXML));
		rV.bBorder = toFloat(stripTagsReturnTextWithin("BorderFillB",shapeFillXML));
		rV.aBorder = toFloat(stripTagsReturnTextWithin("BorderFillA",shapeFillXML));
	}
	rV.setImageFilePath(stripTagsReturnTextWithin("ImageFilePath",shapeFillXML));
	return rV;
}

int Instruface::getShapeFillStyleFromXML(string shapeFillStyleXML)
{
	if(shapeFillStyleXML == "SOLIDCOLOR")
	{
		return (int)ShapeFill::FILL_STYLE::SOLIDCOLOR;
	}
	else if(shapeFillStyleXML == "IMAGE")
	{
		return (int)ShapeFill::FILL_STYLE::IMAGE;
	}
	else
	{
		return (int)ShapeFill::FILL_STYLE::SOLIDCOLOR;
	}
}

vector<ofPoint> Instruface::getVerticesFromVerticesXML(string verticesXML)
{
	vector<ofPoint> rV;
	if(verticesXML != "")
	{
		string vertexText = stripTagsReturnTextWithin("Vertex",verticesXML);
		while(vertexText != "")
		{
			ofPoint newVertex = getVertexFromVertexXML(vertexText);
			rV.push_back(newVertex);
			vertexText = stripTagsReturnTextWithin("Vertex",verticesXML);
		}
	}
	return rV;
}

ofPoint Instruface::getVertexFromVertexXML(string vertexXML)
{
	ofPoint rV;
	int commaPos = vertexXML.find(',');
	if(commaPos < 0 )
	{
		cout << "Error: Cannot parse vertex " << vertexXML << endl;
		return ofPoint();
	}

	string strX = vertexXML.substr(0, commaPos);
	string strY = vertexXML.substr(commaPos+1, vertexXML.length() - commaPos);

	rV.x = toFloat(strX);
	rV.y = toFloat(strY);
	return rV;
}

Shape Instruface::getShapeFromXML(string shapeXML)
{
	Shape shapeRV;
	shapeRV.autoGenerateAlternateFill = toBool(stripTagsReturnTextWithin("AutoGenerateAlternateFill",shapeXML));
	shapeRV.setFill(getShapeFillFromXML(stripTagsReturnTextWithin("DefaultShapeFill",shapeXML)));
	if(!shapeRV.autoGenerateAlternateFill)
	{
		shapeRV.setAlternateFill(getShapeFillFromXML(stripTagsReturnTextWithin("AlternateShapeFill",shapeXML)));
	}
	shapeRV.vertices = getVerticesFromVerticesXML(stripTagsReturnTextWithin("VerticesFrom00",shapeXML));
	return shapeRV;
}

float Instruface::toFloat(string floatString)
{
	//Fix this for error detections later
	return atof(floatString.c_str());
}

string Instruface::instNameFromFormattedDirectoryPath(string formattedDirectoryPath)
{
	//Remove last char - should be a slash
	if(formattedDirectoryPath[formattedDirectoryPath.length() - 1] == '\\')
	{
		formattedDirectoryPath.erase(formattedDirectoryPath.length()-1);
	}
	else
	{
		cout << "Error: Trialing slash not found when attempting to strip Instruface name from directory " << formattedDirectoryPath << endl;
	}

	//R find the next slash
	int slashPos =  formattedDirectoryPath.rfind('\\');

	//Get substring from there to end
	return formattedDirectoryPath.substr(slashPos+1, formattedDirectoryPath.length() - slashPos);
}


void Instruface::getAndAddSoundsFromFile(string soundsFromFileXMLText, SoundActionRegion & sar)
{
	if(soundsFromFileXMLText != "")
	{
		string sffText = stripTagsReturnTextWithin("SoundFromFile",soundsFromFileXMLText);
		while(sffText != "")
		{
			SoundFromFile newSff = getSoundFromFileFromXML(sffText);
			sar.soundsFromFile.push_back(newSff);
			sffText = stripTagsReturnTextWithin("SoundFromFile",soundsFromFileXMLText);
		}
	}
}
SoundFromFile Instruface::getSoundFromFileFromXML(string soundFromFileXML)
{
	SoundFromFile sffRV;
	sffRV.fileName = stripTagsReturnTextWithin("FileName",soundFromFileXML);
	sffRV.loadAsAStream = toBool(stripTagsReturnTextWithin("IsStreamed",soundFromFileXML));
	if(fileExists(sffRV.fileName))
	{
		sffRV.loadSound(sffRV.fileName,sffRV.loadAsAStream);
	}
	else
	{
		cout << "Sound file " << sffRV.fileName << " cannot be opened!" << endl;
	}
	sffRV.setVolume(toFloat(stripTagsReturnTextWithin("Volume",soundFromFileXML)));
	sffRV.setPan(toFloat(stripTagsReturnTextWithin("Pan",soundFromFileXML)));
	sffRV.setSpeed(toFloat(stripTagsReturnTextWithin("Speed",soundFromFileXML)));
	sffRV.setLoop(toBool(stripTagsReturnTextWithin("LoopedPlay",soundFromFileXML)));
	sffRV.setMultiPlay(toBool(stripTagsReturnTextWithin("AllowMultiPlay",soundFromFileXML)));
	return sffRV;
}
void Instruface::getAndAddSoundsFromSynth(string soundsFromSynthXMLText, SoundActionRegion & sar)
{
	if(soundsFromSynthXMLText != "")
	{
		string sfsText = stripTagsReturnTextWithin("SoundFromSynth",soundsFromSynthXMLText);
		while(sfsText != "")
		{
			SoundFromSynth newSfs = getSoundFromSynthFromXML(sfsText);
			sar.soundsFromSynth.push_back(newSfs);
			sfsText = stripTagsReturnTextWithin("SoundFromSynth",soundsFromSynthXMLText);
		}
	}
}
SoundFromSynth Instruface::getSoundFromSynthFromXML(string soundFromSynthXML)
{
	SoundFromSynth rV;
	rV.setDuration(toFloat(stripTagsReturnTextWithin("DurationMS",soundFromSynthXML)));
	rV.setFrequency(toFloat(stripTagsReturnTextWithin("Frequency",soundFromSynthXML)));
	rV.waveShape = (SoundFromSynth::WAVE_SHAPE)getWaveShapeFromXML(stripTagsReturnTextWithin("WaveShape",soundFromSynthXML));
	rV.setVolume(toFloat(stripTagsReturnTextWithin("Volume",soundFromSynthXML)));
	rV.setNumAdditiveSynthWaves(toFloat(stripTagsReturnTextWithin("NumAdditiveSynthWaves",soundFromSynthXML)));
	rV.additiveSynthWeightType = (SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE)getSynthWeightingFromXML(stripTagsReturnTextWithin("AdditiveSynthWeighting",soundFromSynthXML));
	rV.additiveSynthFreqSelection = (SoundFromSynth::ADDITIVE_SYNTH_FREQ_SELECTION)getFreqSelectionFromXML(stripTagsReturnTextWithin("AdditiveFreqSelection",soundFromSynthXML));
	rV.touchPostionChangesProperties = toBool(stripTagsReturnTextWithin("TouchPositionChangesProperties",soundFromSynthXML));
	rV.xAxisControlParam = (SoundFromSynth::CONTROL_PARAM)getControlParamFromXML(stripTagsReturnTextWithin("XAxisControl",soundFromSynthXML));
	rV.yAxisControlParam = (SoundFromSynth::CONTROL_PARAM)getControlParamFromXML(stripTagsReturnTextWithin("YAxisControl",soundFromSynthXML));
	rV.xAxisTaylorSeries = getFloatVector(stripTagsReturnTextWithin("XAxisTaylorSeries",soundFromSynthXML));
	rV.yAxisTaylorSeries = getFloatVector(stripTagsReturnTextWithin("YAxisTaylorSeries",soundFromSynthXML));
	return rV;
}


int Instruface::getWaveShapeFromXML(string waveShapeXML)
{
	if(waveShapeXML == "SINE")
	{
		return (int)SoundFromSynth::WAVE_SHAPE::SINE;
	}
	else if(waveShapeXML == "SQUARE")
	{
		return (int)SoundFromSynth::WAVE_SHAPE::SQUARE;
	}
	else if(waveShapeXML == "TRIANGLE")
	{
		return (int)SoundFromSynth::WAVE_SHAPE::TRIANGLE;
	}
	else if(waveShapeXML == "SAW")
	{
		return (int)SoundFromSynth::WAVE_SHAPE::SAW;
	}
	else
	{
		return (int)SoundFromSynth::WAVE_SHAPE::SINE;
	}
}

int Instruface::getSynthWeightingFromXML(string XML)
{
	if(XML == "DECREASING_HARMONIC_SERIES")
	{
		return (int)SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE::DECREASING_HARMONIC_SERIES;
	}
	else if(XML == "INCREASING_HARMONIC_SERIES")
	{
		return (int)SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE::INCREASING_HARMONIC_SERIES;
	}
	else if(XML == "EQUAL_WEIGHTS")
	{
		return (int)SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE::EQUAL_WEIGHTS;
	}
	else
	{
		return 0;
	}
}
int Instruface::getFreqSelectionFromXML(string XML)
{
	if(XML == "OCTAVES")
	{
		return (int)SoundFromSynth::ADDITIVE_SYNTH_FREQ_SELECTION::OCTAVES;
	}
	else if(XML == "HARMONICS")
	{
		return (int)SoundFromSynth::ADDITIVE_SYNTH_FREQ_SELECTION::HARMONICS;
	}
	else
	{
		return 0;
	}
}
int Instruface::getControlParamFromXML(string XML)
{
	if(XML == "VOLUME")
	{
		return (int)SoundFromSynth::CONTROL_PARAM::VOLUME;
	}
	else if(XML == "DURATION")
	{
		return (int)SoundFromSynth::CONTROL_PARAM::DURATION;
	}
	else if(XML == "FREQUENCY")
	{
		return (int)SoundFromSynth::CONTROL_PARAM::FREQUENCY;
	}
	else if(XML == "NUM_WAVES")
	{
		return (int)SoundFromSynth::CONTROL_PARAM::NUM_WAVES;
	}
	else
	{
		return 0;
	}
}
vector<float> Instruface::getFloatVector(string commaSeperatedValues)
{
	vector<float> rV;
	vector<string> tokens = split(commaSeperatedValues.c_str(),',');
	
	int numToks = tokens.size();
	for(int i=0; i< numToks; i++)
	{
		rV.push_back(toFloat(tokens[i]));
	}
	return rV;
}

vector<string> Instruface::split(const char *str, char c)
{
	//Taken form stack overflow because of laziness
    vector<string> result;

    while(1)
    {
        const char *begin = str;

        while(*str != c && *str)
                str++;

        result.push_back(string(begin, str));

        if(0 == *str++)
                break;
    }

    return result;
}

int Instruface::getTemplateToUseFromXML(string templateToUseXML)
{
	if(templateToUseXML == "NONE")
	{
		
	}
	else if(templateToUseXML == "FROM_FILE")
	{
		return (int)SoundActionRegion::TEMPLATE_TO_USE::FROM_FILE;
	}
	else if(templateToUseXML == "FROM_SYNTH")
	{
		return (int)SoundActionRegion::TEMPLATE_TO_USE::FROM_SYNTH;
	}
	else if(templateToUseXML == "BOTH")
	{
		return (int)SoundActionRegion::TEMPLATE_TO_USE::BOTH;
	}
	else
	{
		return (int)SoundActionRegion::TEMPLATE_TO_USE::NONE;
	}
	
}
SoundFromFile Instruface::getDynamicSoundFromFileTemplateFromXML(string soundFromFileXML)
{
	return getSoundFromFileFromXML(soundFromFileXML);
}
bool Instruface::toBool(string boolString)
{
	if(boolString == "true" || boolString == "True" || boolString == "TRUE")
	{
		return true;
	}
	return false;
}
SoundFromSynth Instruface::getDynamicSoundFromSynthTemplateFromXML(string soundFromSynthXML)
{
	return getSoundFromSynthFromXML(soundFromSynthXML);
}
void Instruface::applyShapeInfoToSoundActionRegion(Shape s, SoundActionRegion & sar)
{
	sar.autoGenerateAlternateFill = s.autoGenerateAlternateFill;
	sar.setAlternateFill(s.getAlternateFill());
	sar.setFill(s.getFill());
	sar.vertices = s.vertices;
}


void Instruface::loadFromOpenDrawFile(string filePath)
{
	//Load from open draw file
	//Convert to 'custom' xml
	//Load from that file using loadfromfile
}

void Instruface::draw()
{
	if(isVisible)
	{
		for(int i = 0; i < shapes.size(); i++)
		{
			if(shapes[i].isVisible)
			{
				shapes[i].draw();
			}
		}

		for(int i = 0; i < soundActionRegions.size(); i++)
		{
			if(soundActionRegions[i].isVisible)
			{
				soundActionRegions[i].draw();
			}
		}
	}
}


void Instruface::touchDown(ofTouchEventArgs & touch)
{
	lastTouch = touch;
}
void Instruface::touchUp(ofTouchEventArgs & touch)
{
	lastTouch = touch;
}

void Instruface::touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	lastTouch = touchNow;
}
void Instruface::touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	lastTouch = touchNow;
}
void Instruface::touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	//Only record touch info - no manipulation actions done here.
	lastTouch = touchNow;
}
bool Instruface::isTouchWithin(ofTouchEventArgs & touch)
{
	//Better than checking bounding rectangle?
	for(int i = 0; i < getTouchChildrenPtrs().size(); i++)
	{
		if(getTouchChildrenPtrs()[i]->isTouchWithin(touch))
		{
			return true;
		}
	}
	return false;
}

void Instruface::moveBy(float dx, float dy)
{
	int numShapes = shapes.size();
	for(int i = 0; i < numShapes; i++)
	{
			shapes[i].moveBy(dx,dy);
	}

	int numSAR = soundActionRegions.size();
	for(int i = 0; i < numSAR ; i++)
	{
			soundActionRegions[i].moveBy(dx,dy);
	}
}


void Instruface::moveCenterTo(float x, float y)
{
	//Get current position
	ofPoint currentCenter = getBoundingRectPtr()->getCenterPoint();

	//Find the difference
	float dx = x - currentCenter.x;
	float dy = y - currentCenter.y;

	//Move by that much
	moveBy(dx,dy);
}

BoundingRect Instruface::getBoundingRect()
{
	float minX = 99999;
	float minY = 99999;
	float maxX = -99999;
	float maxY = -99999;

	for(int i = 0; i < shapes.size() ; i++)
	{
		for(int j = 0; j < shapes[i].vertices.size() ; j++)
		{
			if(shapes[i].vertices[j].x < minX)
			{
				minX = shapes[i].vertices[j].x;
			}
			
			if(shapes[i].vertices[j].y < minY)
			{
				minY = shapes[i].vertices[j].y;
			}

			if(shapes[i].vertices[j].x > maxX)
			{
				maxX = shapes[i].vertices[j].x;
			}

			if(shapes[i].vertices[j].y > maxY)
			{
				maxY = shapes[i].vertices[j].y;
			}
		}
	}

	for(int i = 0; i < soundActionRegions.size() ; i++)
	{
		for(int j = 0; j < soundActionRegions[i].vertices.size() ; j++)
		{
			if(soundActionRegions[i].vertices[j].x < minX)
			{
				minX = soundActionRegions[i].vertices[j].x;
			}
			
			if(soundActionRegions[i].vertices[j].y < minY)
			{
				minY = soundActionRegions[i].vertices[j].y;
			}

			if(soundActionRegions[i].vertices[j].x > maxX)
			{
				maxX = soundActionRegions[i].vertices[j].x;
			}

			if(soundActionRegions[i].vertices[j].y > maxY)
			{
				maxY = soundActionRegions[i].vertices[j].y;
			}
		}
	}

	boundingRect.x1 = minX;
	boundingRect.y1 =minY;
	boundingRect.x2 =maxX;
	boundingRect.y2 =maxY;
	return boundingRect;
}

BoundingRect * Instruface::getBoundingRectPtr()
{
	float minX = 99999;
	float minY = 99999;
	float maxX = -99999;
	float maxY = -99999;

	for(int i = 0; i < shapes.size() ; i++)
	{
		for(int j = 0; j < shapes[i].vertices.size() ; j++)
		{
			if(shapes[i].vertices[j].x < minX)
			{
				minX = shapes[i].vertices[j].x;
			}
			
			if(shapes[i].vertices[j].y < minY)
			{
				minY = shapes[i].vertices[j].y;
			}

			if(shapes[i].vertices[j].x > maxX)
			{
				maxX = shapes[i].vertices[j].x;
			}

			if(shapes[i].vertices[j].y > maxY)
			{
				maxY = shapes[i].vertices[j].y;
			}
		}
	}

	for(int i = 0; i < soundActionRegions.size() ; i++)
	{
		for(int j = 0; j < soundActionRegions[i].vertices.size() ; j++)
		{
			if(soundActionRegions[i].vertices[j].x < minX)
			{
				minX = soundActionRegions[i].vertices[j].x;
			}
			
			if(soundActionRegions[i].vertices[j].y < minY)
			{
				minY = soundActionRegions[i].vertices[j].y;
			}

			if(soundActionRegions[i].vertices[j].x > maxX)
			{
				maxX = soundActionRegions[i].vertices[j].x;
			}

			if(soundActionRegions[i].vertices[j].y > maxY)
			{
				maxY = soundActionRegions[i].vertices[j].y;
			}
		}
	}

	boundingRect.x1 = minX;
	boundingRect.y1 =minY;
	boundingRect.x2 =maxX;
	boundingRect.y2 =maxY;
	return &boundingRect;
}


void Instruface::moveTopLeftCornerTo(float x, float y)
{
	//Find out how far to move the bounding rectangle
	//Then moveBy that far
	ofPoint topLeft = getBoundingRectPtr()->getTopLeftPoint();
	float diffX = x - topLeft.x;
	float diffY = y - topLeft.y;
	moveBy(diffX,diffY);
}

void Instruface::addBackgroundShape()
{
	//Get bounding rectangle
	//Note: bounding rectangle will change once the background shape is added
	//So only call this function after the instruface has been finalized
	ofPoint topLeft = getBoundingRectPtr()->getTopLeftPoint();
	ofPoint bottomRight = getBoundingRectPtr()->getBottomRightPoint();

	//Top Left
	backgroundShape.vertices.push_back(ofPoint(topLeft.x -backgroundBorderLeft , topLeft.y - backgroundBorderTop ));
	//Bottom Left
	backgroundShape.vertices.push_back(ofPoint(topLeft.x -backgroundBorderLeft,bottomRight.y + backgroundBorderBottom  ));
	//Bottom Right
	backgroundShape.vertices.push_back(ofPoint(bottomRight.x + backgroundBorderRight ,bottomRight.y + backgroundBorderBottom ));
	//Top Right
	backgroundShape.vertices.push_back(ofPoint(bottomRight.x + backgroundBorderRight ,topLeft.y - backgroundBorderTop ));

	//Define color
	backgroundShape.setFill(backgroundFill);
	addShape(backgroundShape);
}

bool Instruface::isPointWithin(ofPoint point)
{
	//Fix this
	return false;
}

void Instruface::rotateClockWise(float degrees)
{
	return; //Do this later
	//Get shape center
	ofPoint instrufaceCenter = getBoundingRectPtr()->getCenterPoint();

	//For each child scale and reposition
	//Use pointers to increase speed
	vector<ScreenObject*> * screenChildrenPtrsPtr = getScreenChildrenPtrsPtr();
	int numChildren = screenChildrenPtrsPtr->size();

	for(int i = 0; i < numChildren; i++)
	{
		//Get current postion
		ofPoint currentPos = (*screenChildrenPtrsPtr)[i]->getBoundingRectPtr()->getCenterPoint();

		//Scale each shape
		(*screenChildrenPtrsPtr)[i]->rotateClockWise(degrees);

		//Move to the correct new position
		//Find postion relative to instruface center
		float x = currentPos.x - instrufaceCenter.x;
		float y = currentPos.y - instrufaceCenter.y;

		//Get current angle
		float absX = abs(x);
		float absY = abs(y);

		float angleRad = atan(absY/absX);
		if(absY ==0  && absX == 0)
		{
			angleRad = 0;
		}
		float angleDeg = (angleRad * 180.0 )/ PI;

		//Rotate
		//Since angle is from x axis and value passed is clockwise - subtract angle
		angleDeg -= degrees;

		//Get distance from center
		float dist = sqrt(pow(absX,2) + pow(absY,2));

		int signX =  x/absX;
		int signY = y/absY;
		//Prevent divide by 0 errors
		if(x==0)
		{
			signX =1;	
		}
		if(y==0)
		{
			signY = 1;
		}
		

		float newX = signX * dist * cos( (angleDeg/360.0)*(2*PI));
		float newY = signY * dist * sin( (angleDeg/360.0)*(2*PI));

		//Move center of shape
		(*screenChildrenPtrsPtr)[i]->moveCenterTo(newX + instrufaceCenter.x, newY + instrufaceCenter.y);
	}
}

void Instruface::scale(float scaleFactorX,float scaleFactorY)
{	
	//Get shape center
	ofPoint instrufaceCenter = getBoundingRectPtr()->getCenterPoint();

	//For each child scale and reposition
	//Use pointers to increase speed
	vector<ScreenObject*> * screenChildrenPtrsPtr = getScreenChildrenPtrsPtr();
	int numChildren = screenChildrenPtrsPtr->size();

	for(int i = 0; i < numChildren; i++)
	{
		//Get current postion
		ofPoint currentPos = (*screenChildrenPtrsPtr)[i]->getBoundingRectPtr()->getCenterPoint();

		//Scale each shape
		(*screenChildrenPtrsPtr)[i]->scale(scaleFactorX,scaleFactorY);

		//Move to the correct new position
		//Find postion relative to instruface center
		float x = currentPos.x - instrufaceCenter.x;
		float y = currentPos.y - instrufaceCenter.y;

		//Scale postion
		x = x * scaleFactorX;
		y = y * scaleFactorY;

		//Move center of shape
		(*screenChildrenPtrsPtr)[i]->moveCenterTo(x + instrufaceCenter.x, y + instrufaceCenter.y);
	}
}

void Instruface::create440Hexagon()
{
	//Build from top left corner (0,0)
	
	//Build a 1 region instruface
	SoundActionRegion region1;
	//SoundActionRegion region1; //Moved to h file
	//Define shape and position
	region1.formHexagon(0,0,100);
	//Define color
	ShapeFill fill;
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = 100;
	fill.g = 100;
	fill.b = 100;
	fill.a = 255;
	region1.setFill(fill);
	//Define sound (440 hz for 1 second)
	SoundFromSynth soundFromSynth;
	soundFromSynth.setDuration(1000);
	soundFromSynth.setFrequency(440);
	soundFromSynth.setVolume(1);
	region1.soundsFromSynth.push_back(soundFromSynth);

	//Finally add sound action region to list of sound action regions
	soundActionRegions.push_back(region1);
}

void Instruface::create440Square()
{
	//Build from top left corner (0,0)
	
	//Build a 1 region instruface
	SoundActionRegion region1;
	//SoundActionRegion region1; //Moved to h file
	//Define shape and position
	region1.vertices.push_back(ofPoint(0,0));
	region1.vertices.push_back(ofPoint(0,100));
	region1.vertices.push_back(ofPoint(100,100));
	region1.vertices.push_back(ofPoint(100,0));
	//Define color
	ShapeFill fill;
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = 100;
	fill.g = 100;
	fill.b = 100;
	fill.a = 255;
	region1.setFill(fill);
	//Define sound (440 hz for 1 second)
	SoundFromSynth soundFromSynth;
	soundFromSynth.setDuration(1000);
	soundFromSynth.setFrequency(440);
	soundFromSynth.setVolume(1);
	region1.soundsFromSynth.push_back(soundFromSynth);

	//Finally add sound action region to list of sound action regions
	soundActionRegions.push_back(region1);
}



void Instruface::createGridtar()
{
	//6 rows for the 6 guitar frets (1st is open)
	//Loop through rows first

	float buttonWidth = 50;
	float buttonHeight = 50;

	vector<SoundActionRegion> regions;

	for(int X = 0; X < 6*buttonWidth; X+= buttonWidth)
	{
		for(int Y = 0; Y < 6*buttonHeight; Y+= buttonHeight)
		{
			//Add region to vector and allocate space at same time (seems dangerous)
			regions.push_back(*(new SoundActionRegion()));
			//regions.push_back(SoundActionRegion()); //Does not work?????? - Bug?

			//regions.back() to access item just added?

			//Define shape and position
			regions.back().vertices.push_back(ofPoint(X,Y));
			regions.back().vertices.push_back(ofPoint(X,Y + buttonHeight));
			regions.back().vertices.push_back(ofPoint(X + buttonWidth,Y + buttonHeight));
			regions.back().vertices.push_back(ofPoint(X + buttonWidth,Y));
		}
	}

	//Regions go
	// 0 -> open, 6th string

	//regions[0] open, 6th string
	//Define color
	ShapeFill fill;
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[0].setFill(fill);
	//Define soudn action
	SoundFromSynth soundFromSynth;
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["E3"]);

	soundFromSynth.setVolume(1);
	regions[0].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[0]);

	//regions[1] 1st, 6th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[1].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F3"]);
	soundFromSynth.setVolume(1);
	regions[1].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[1]);

	//regions[2] 2, 6th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[2].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F#3"]);
	soundFromSynth.setVolume(1);
	regions[2].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[2]);

	//regions[3] 3, 6th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[3].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G3"]);
	soundFromSynth.setVolume(1);
	regions[3].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[3]);

	//regions[4] 4, 6th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[4].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G#3"]);
	soundFromSynth.setVolume(1);
	regions[4].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[4]);

	//regions[5] 5, 6th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[5].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A3"]);
	soundFromSynth.setVolume(1);
	regions[5].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[5]);

	//regions[6] open, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[6].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A3"]);
	soundFromSynth.setVolume(1);
	regions[6].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[6]);

	//regions[7] 1, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[7].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A#3"]);
	soundFromSynth.setVolume(1);
	regions[7].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[7]);

	//regions[8] 2, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[8].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["B3"]);
	soundFromSynth.setVolume(1);
	regions[8].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[8]);

	//regions[9] 3, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[9].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["C4"]);
	soundFromSynth.setVolume(1);
	regions[9].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[9]);


	//regions[10] 4, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[10].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["C#4"]);
	soundFromSynth.setVolume(1);
	regions[10].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[10]);

	//regions[11] 5, 5th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[11].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["D4"]);
	soundFromSynth.setVolume(1);
	regions[11].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[11]);

	//regions[12] open , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[12].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["D4"]);
	soundFromSynth.setVolume(1);
	regions[12].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[12]);

	//regions[13] 1 , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[13].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["D#4"]);
	soundFromSynth.setVolume(1);
	regions[13].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[13]);

	//regions[14] 2 , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[14].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["E4"]);
	soundFromSynth.setVolume(1);
	regions[14].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[14]);

	//regions[15] 3 , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[15].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F4"]);
	soundFromSynth.setVolume(1);
	regions[15].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[15]);

	//regions[16] 4 , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[16].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F#4"]);
	soundFromSynth.setVolume(1);
	regions[16].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[16]);

	//regions[17] 5 , 4th string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[17].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G4"]);
	soundFromSynth.setVolume(1);
	regions[17].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[17]);

	//regions[18] open , 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[18].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G4"]);
	soundFromSynth.setVolume(1);
	regions[18].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[18]);

	//regions[19] 1, 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[19].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G#4"]);
	soundFromSynth.setVolume(1);
	regions[19].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[19]);

	//regions[20] 2, 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[20].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A4"]);
	soundFromSynth.setVolume(1);
	regions[20].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[20]);

	//regions[21] 3, 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[21].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A#4"]);
	soundFromSynth.setVolume(1);
	regions[21].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[21]);

	//regions[22] 4, 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[22].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["B4"]);
	soundFromSynth.setVolume(1);
	regions[22].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[22]);

	//regions[23] 5, 3rd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[23].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["C5"]);
	soundFromSynth.setVolume(1);
	regions[23].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[23]);

	//regions[24] open, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[24].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["B4"]);
	soundFromSynth.setVolume(1);
	regions[24].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[24]);

	//regions[25] 1, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[25].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["C5"]);
	soundFromSynth.setVolume(1);
	regions[25].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[25]);

	//regions[26] 2, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[26].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["C#5"]);
	soundFromSynth.setVolume(1);
	regions[26].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[26]);

	//regions[27] 3, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[27].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["D5"]);
	soundFromSynth.setVolume(1);
	regions[27].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[27]);

	//regions[28] 4, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[28].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["D#5"]);
	soundFromSynth.setVolume(1);
	regions[28].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[28]);

	//regions[29] 5, 2nd string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[29].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["E5"]);
	soundFromSynth.setVolume(1);
	regions[29].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[29]);

	//regions[30] open, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[30].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["E5"]);
	soundFromSynth.setVolume(1);
	regions[30].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[30]);

	//regions[31] 1, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[31].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F5"]);
	soundFromSynth.setVolume(1);
	regions[31].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[31]);

	//regions[32] 2, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[32].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["F#5"]);
	soundFromSynth.setVolume(1);
	regions[32].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[32]);

	//regions[33] 3, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[33].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G5"]);
	soundFromSynth.setVolume(1);
	regions[33].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[33]);

	//regions[34] 4, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[34].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["G#5"]);
	soundFromSynth.setVolume(1);
	regions[34].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[34]);

	//regions[35] 5, 1st string
	//Define color
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = ofRandom(0,255);
	fill.g = ofRandom(0,255);
	fill.b = ofRandom(0,255);
	fill.a = 255;
	regions[35].setFill(fill);
	//Define soudn action
	
	
	soundFromSynth.setFrequency(soundFromSynth.noteNameToFrequency["A5"]);
	soundFromSynth.setVolume(1);
	regions[35].soundsFromSynth.push_back(soundFromSynth);
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(regions[35]);

}

void Instruface::createPolytheremin()
{
	//Build from top left corner (0,0)
	
	//Build a 1 region instruface
	SoundActionRegion region1;

	//Define shape and position
	region1.vertices.push_back(ofPoint(0,0));
	region1.vertices.push_back(ofPoint(0,200));
	region1.vertices.push_back(ofPoint(500,200));
	region1.vertices.push_back(ofPoint(500,0));
	//Define color
	ShapeFill fill;
	fill.fillStyle = fill.SOLIDCOLOR;
	fill.r = 255;
	fill.g = 0;
	fill.b = 0;
	fill.a = 255;
	region1.setFill(fill);
	//No static tones, only create dynamic ones
	//Templates are blank so creat new ones
	region1.dynamicSoundFromSynthTemplate = new SoundFromSynth();
	region1.dynamicSoundFromSynthTemplate->waveShape = SoundFromSynth::WAVE_SHAPE::SINE;
	region1.dynamicSoundFromSynthTemplate->touchPostionChangesProperties = true;
	region1.dynamicSoundFromSynthTemplate->additiveSynthFreqSelection = SoundFromSynth::ADDITIVE_SYNTH_FREQ_SELECTION::OCTAVES;
	region1.dynamicSoundFromSynthTemplate->additiveSynthWeightType = SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE::DECREASING_HARMONIC_SERIES;
	region1.dynamicSoundFromSynthTemplate->setNumAdditiveSynthWaves(10);
	region1.useDynamicSoundActions = true;
	region1.useStaticSoundActions = false;
	//Finally add sound action region to list of sound action regions
	addSoundActionRegion(region1);
}