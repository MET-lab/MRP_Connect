#pragma once
//Resolve mutual dependencies
class SoundHandler;
class DrawHandler;

#include "TouchableObject.h"
#include <vector>
#include "SoundHandler.h"
#include "DrawHandler.h"

using namespace std;

class TouchHandler
{
public:
	TouchHandler(void);

	void addTouchableObjectToHandle(TouchableObject* touchObject);

	void touchDown(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchMoved(ofTouchEventArgs & touch);

	//Keep track of last known positions
	map<int,ofTouchEventArgs> lastTouches;

	vector<TouchableObject*> getObjectsThatContain(ofTouchEventArgs & touch);

	TouchableObject* getTopObjectFromTouch(ofTouchEventArgs & touch);

	~TouchHandler(void);

	//Link to other handlers
	SoundHandler * soundHandler;
	DrawHandler * drawHandler;

private:
	vector<TouchableObject*> ptrTouchObjectsToHandle;
	void recursiveGetObjectsThatContain(TouchableObject* touchObjectParent, ofTouchEventArgs & touch,vector<TouchableObject*> & container);
	void recursiveTouchUp(TouchableObject* parent, ofTouchEventArgs & touch);
};

