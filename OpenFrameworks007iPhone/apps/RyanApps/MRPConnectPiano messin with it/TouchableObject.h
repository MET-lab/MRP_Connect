#pragma message ("\tAttempting to open TouchableObject Header...")
#pragma once
#pragma message ("\tOpened TouchableObject Header.")
//Resolve dependency
class ManipulationProcessor;

#include "screenobject.h"
#include "src\ofxTuioClient.h"
#include <vector>
#include "ManipulationProcessor.h"
#include <string>

using namespace std;

//This is an abstract class to classify everything that can be touched
// =0; signifies abstract (no implimentation)

class TouchableObject : public ScreenObject
{
public:
	//Raw touch events
	virtual void touchDown(ofTouchEventArgs & touch) =0;
	virtual void touchUp(ofTouchEventArgs & touch) =0;
	virtual void touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow) =0;
	virtual void touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)=0;
	virtual void touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow) =0;

	//Manipulation events
	ManipulationProcessor * getManipulationProcessorPtr();
	virtual void touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY) =0;
	virtual void touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees) =0;
	virtual void touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY)=0;

	virtual bool isTouchWithin(ofTouchEventArgs & touch) =0;

	//Parent child relation?
	void setTouchParent(TouchableObject* parentObject);
	TouchableObject* getTouchParent();
	void addTouchChild(TouchableObject * child);
	vector<TouchableObject*> getTouchChildrenPtrs();

	TouchableObject(void);
	~TouchableObject(void);

protected:
	TouchableObject* parentTouchPtr;
	vector<TouchableObject*> childrenTouchPtrs;
	ManipulationProcessor * manipulationProcessor;
};

