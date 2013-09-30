#pragma message ("\tAttempting to open DrawHandler Header...")
#pragma once
#pragma message ("\tOpened DrawHandler Header.")
//Resolve mutual dependencies
class TouchHandler;
class SoundHandler;

#include <vector>
#include "ScreenObject.h"
#include "TouchableObject.h"
#include "ofPoint.h"
#include "TouchHandler.h"
#include "SoundHandler.h"

using namespace std;


	
class DrawHandler
{
public:
	DrawHandler(void);
	~DrawHandler(void);

	void draw();

	void addScreenObjectToHandle(ScreenObject* screenObject);
	void recursiveDraw(ScreenObject * parentObject);

	ScreenObject * getTopObjectFromPoint(ofPoint p);
	ScreenObject * getTopObjectFromTouch(ofTouchEventArgs & touch);
	void recursiveGetTopObjectFromPoint(ScreenObject * parentObject, ofPoint p, ScreenObject * &rV);

	unsigned int getZIndex(ScreenObject * so);
	void setZIndex(ScreenObject * so);

	//Link to other handlers
	TouchHandler * touchHandler;
	SoundHandler * soundHandler;

private:
	vector<ScreenObject*> ptrScreenObjectsToDraw;
};
