#include "TouchableObject.h"


TouchableObject::TouchableObject(void)
{
	//No parent default
	parentTouchPtr = NULL;

	//Allocate memory for manip processor
	//This needs to be done because only a pointer in currently stored
	//Only a pointer is stored because of a mutual dependencies issue
	manipulationProcessor = new ManipulationProcessor();

	//Set manipulation process parent as self
	manipulationProcessor->setOwner(this);
}

TouchableObject::~TouchableObject(void)
{
}

ManipulationProcessor * TouchableObject::getManipulationProcessorPtr()
{
	//Somewhere the manip processor for touchable objects
	//Begins to point at the wrong object
	//This ensures that it always has the correct owner
	//This is a bug to be solved later  - Bug?
	if(manipulationProcessor->getOwner() != this)
	{
		cout << "ERROR: MANIP PROC NOT OWNED PROPERLY!" << endl;
		manipulationProcessor->setOwner(this);
	}
	return manipulationProcessor;
}

bool TouchableObject::isTouchWithin(ofTouchEventArgs & touch)
{
	return isPointWithin(ofPoint(touch.x*SCREEN_WIDTH,touch.y*SCREEN_HEIGHT));
}

void TouchableObject::setTouchParent(TouchableObject* parentObject)
{
	parentTouchPtr = parentObject;
}

TouchableObject* TouchableObject::getTouchParent()
{
	return parentTouchPtr;
}

void TouchableObject::addTouchChild(TouchableObject * child)
{
	childrenTouchPtrs.push_back(child);
	//Child's parent should be set to self
	child->setTouchParent(this);
}

vector<TouchableObject*> TouchableObject::getTouchChildrenPtrs()
{
	return childrenTouchPtrs;
}