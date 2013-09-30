#pragma message ("\tAttempting to open Shape Header...")
#pragma once
#pragma message ("\tOpened Shape Header.")
#include "TouchableObject.h"
#include <vector>
#include "ofPoint.h"
#include "ofGraphics.h"
#include "ShapeFill.h"

using namespace std;

class Shape : public TouchableObject
{
public:
	static const int VERTEX_MAX_X = 10000;
	static const int VERTEX_MAX_Y = 10000;
	Shape();
	string toString();
	void setFill(ShapeFill f);
	ShapeFill getFill();
	void setAlternateFill(ShapeFill f);
	ShapeFill getAlternateFill();
	bool useAlternateFill;
	bool autoGenerateAlternateFill;
	int rgbaAutoAlternateFillDecrement;
	void draw();
	bool isTouchWithin(ofTouchEventArgs & touch); //Overidden the method from the touchable object class
	bool isPointWithin(ofPoint point); //overridden in from screen object

	//Touches dragged within shape move the shape and it's parent if possible
	void touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	//Raw touch events
	void touchDown(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);
	void touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow);

	//Manipulation events
	void touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY);
	void touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees);
	void touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY);

	BoundingRect getBoundingRect(void);
	BoundingRect * getBoundingRectPtr();

	void rotateClockWise(float);
	void moveBy(float dx,float dy);
	void moveTopLeftCornerTo(float x, float y);
	void moveCenterTo(float x, float y);
	void scale(float scaleFactorX,float scaleFactorY);

	//Quick shape defaults
	void formHexagon(float topLeftX, float topLeftY, float sideLength);

	vector<ofPoint> vertices;
	
	~Shape(void);

private:
	vector<ofPoint> newVertices; //Do not create new object everytime to change position
	ShapeFill defaultFill;
	ShapeFill alternateFill;
};

