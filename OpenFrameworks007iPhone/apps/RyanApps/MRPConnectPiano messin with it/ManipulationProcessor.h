#pragma once
class TouchableObject;

#include <vector>
#include <map>
#include "ofPoint.h"
#include "src\ofxTuioClient.h"
#include "TouchableObject.h"

using namespace std;

class ManipulationProcessor
{
public:
	void addTouch(ofTouchEventArgs touch);
	void updateTouch(ofTouchEventArgs touch);
	bool removeTouch(ofTouchEventArgs touch);

	void setOwner(TouchableObject* ownerObject);
	TouchableObject* getOwner();

	ManipulationProcessor(void);
	~ManipulationProcessor(void);

	int getNumTouches();

	void touchesUpdated();

private:
	map<int,ofTouchEventArgs> touchIDToPreviousTouch;
	map<int,ofTouchEventArgs> touchIDToCurrentTouch;
	TouchableObject * owner;
	BoundingRect getBoundingRectFromPoints(vector<ofPoint> pointList);
	vector<ofTouchEventArgs> getTouchListFromMap(map<int,ofTouchEventArgs> theMap);
	vector<ofPoint> getScreenPointListFromTouchList(vector<ofTouchEventArgs> touchList);

	
};

