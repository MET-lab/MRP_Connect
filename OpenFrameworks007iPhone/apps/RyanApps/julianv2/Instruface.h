#pragma message ("\tAttempting to open Intruface Header...")
#pragma once
#pragma message ("\tOpened Intruface Header.")
//Resolve mutual dependencies
class SoundActionRegion;
class SoundActionRegionText;
class SoundFromFile;
class SoundFromSynth;

#include "TouchableObject.h"
#include <vector>
#include "ofPoint.h"
#include "ShapeFill.h"
#include "SoundActionRegion.h"
#include "Shape.h"

using namespace std;

class Instruface : public TouchableObject
{
public:
	//XML Loaded Information
	string name;
	float backgroundBorderLeft;
	float backgroundBorderRight;
	float backgroundBorderTop;
	float backgroundBorderBottom;

	ShapeFill backgroundFill;
	//Shapes
	//SoundActionRegions



	Instruface(void);
	Instruface(int tmpSelector);
	int tmpSelection;
	string toString();
	void loadFromFile(string directoryPath);
	void loadFromOpenDrawFile(string filePath);
	void draw();
	~Instruface(void);

	void finalizeTouchableObjects();
	void addShape(Shape s);
	void addSoundActionRegion(SoundActionRegion sar);
	vector<Shape*> getShapePtrs();
	vector<SoundActionRegion*> getSoundActionRegionPtrs();
	

	//Touch events
	void touchDown(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY);
	void touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees);
	void touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY);
	bool isTouchWithin(ofTouchEventArgs & touch);

	//Move methods
	void moveBy(float dx, float dy);
	void moveTopLeftCornerTo(float x, float y);
	void moveCenterTo(float x, float y);
	void rotateClockWise(float degrees);
	void scale(float scaleFactorX,float scaleFactorY);

	//Info
	BoundingRect getBoundingRect();
	BoundingRect * getBoundingRectPtr();
	ofTouchEventArgs lastTouch;
	bool isPointWithin(ofPoint point);


	//Bs Methods to produce instrufaces before coding the load from file
	void create440Square();
	void createGridtar();
	void createPolytheremin();
	void create440Hexagon();


private:
	//Add background shape
	void addBackgroundShape();
	Shape backgroundShape;

	//Shapes and sound action regions need to be seperate because the sound handler needs to specifically handle
	//only objects that have a soundActions property
	//In addition, the vector is of object not pointers because the 'permanent' 
	//memory location of the object is within the vector
	//Other things should point to spots within these vectors
	vector<Shape> shapes;
	vector<SoundActionRegion> soundActionRegions;



	//Loading helpers
	string fullDirectoryPath;
	string fullInstFilePath;
	bool fileExists(string fullFilePath);
	string instNameFromFormattedDirectoryPath(string formattedDirectoryPath);
	string instFileFullPath(string formattedDirectoryPath, string instName);
	string readEntireFile(string fullFilePath);
	string stripTagsReturnTextWithin(string xmlTagName,string & workingText);
	string addTrailingSlashIfNeeded(string path);
	float toFloat(string floatString);
	bool toBool(string boolString);
	void getAndAddShapes(string shapesXMLText);
	Shape getShapeFromXML(string shapeXML);
	void getAndAddSoundActionRegions(string soundActionRegionsXMLText);
	SoundActionRegion getSoundActionRegionFromXML(string sarXML);
	void getAndAddSoundsFromFile(string soundsFromFileXMLText, SoundActionRegion & sar);
	SoundFromFile getSoundFromFileFromXML(string soundFromFileXML);
	void getAndAddSoundsFromSynth(string soundsFromSynthXMLText, SoundActionRegion & sar);
	SoundFromSynth getSoundFromSynthFromXML(string soundFromSynthXML);
	int getTemplateToUseFromXML(string templateToUseXML); //Return enum type is anonying - just return int and cast
	SoundFromFile getDynamicSoundFromFileTemplateFromXML(string soundFromFileXML);
	SoundFromSynth getDynamicSoundFromSynthTemplateFromXML(string soundFromSynthXML);
	void applyShapeInfoToSoundActionRegion(Shape s, SoundActionRegion & sar);

	ShapeFill getShapeFillFromXML(string shapeFillXML);
	vector<ofPoint> getVerticesFromVerticesXML(string verticesXML);
	ofPoint getVertexFromVertexXML(string vertexXML);
	int getShapeFillStyleFromXML(string shapeFillStyleXML);

	SoundActionRegionText getSoundActionRegionTextFromXML(string soundActionRegionTextXML);
	int getWaveShapeFromXML(string waveShapeXML);
	int getSynthWeightingFromXML(string XML);
	int getFreqSelectionFromXML(string XML);

	int getControlParamFromXML(string XML);
	vector<float> getFloatVector(string commaSeperatedValues);
	vector<string> split(const char *str, char c);

};