#pragma message ("\tAttempting to open ScreenObject Header...")
#pragma once
#pragma message ("\tOpened ScreenObject Header.")
#include "ofPoint.h"
#include "BoundingRect.h"
#include <string>

//This is an abstract class to classify everything that appears on screen
// =0; signifies abstract (no implimentation)

class ScreenObject
{
public:
	ScreenObject(void);
	~ScreenObject(void);
	static const int SCREEN_WIDTH = 1024;
	static const int SCREEN_HEIGHT = 768;
	virtual void draw() =0;
	bool isVisible;
	virtual BoundingRect getBoundingRect() = 0;
	virtual BoundingRect * getBoundingRectPtr() = 0;
	virtual bool isPointWithin(ofPoint point) = 0;
	bool canRotate;
	bool canMove;
	bool canScale;
	virtual void rotateClockWise(float degrees) =0;
	virtual void moveBy(float dx, float dy) = 0;
	virtual void moveTopLeftCornerTo(float x, float y) = 0;
	virtual void moveCenterTo(float x, float y) = 0;
	virtual void scale(float scaleFactorX,float scaleFactorY) = 0;
	//virtual string toString() =0;

	//Parent child relation
	void setScreenParent(ScreenObject* parentObject);
	ScreenObject * getScreenParent();
	void addScreenChild(ScreenObject * child);
	vector<ScreenObject*> getScreenChildrenPtrs();
	vector<ScreenObject*> * getScreenChildrenPtrsPtr();

	//Translate shows no noticable performance increases
	//float translateX;
	//float translateY;
	//Do not use ofScale  - causes too many problems
	//float scaleX;
	//float scaleY;

protected:
	BoundingRect boundingRect;
	vector<ScreenObject*> childrenScreenPtrs;
	

private:
	ScreenObject * parentScreenPtr;
	
};

