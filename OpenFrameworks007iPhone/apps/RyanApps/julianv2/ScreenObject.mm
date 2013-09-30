#include "ScreenObject.h"


ScreenObject::ScreenObject(void)
{
	//Nevermind for translate
	//translateX = 0;
	//translateY = 0;

	isVisible = true;

	cout << "ScreenObject " << this << "\tcreated" << endl;

	//No parent default
	parentScreenPtr = NULL;
}

ScreenObject::~ScreenObject(void)
{
}

void ScreenObject::setScreenParent(ScreenObject* parentObject)
{
	parentScreenPtr = parentObject;
}

ScreenObject* ScreenObject::getScreenParent()
{
	return parentScreenPtr;
}

void ScreenObject::addScreenChild(ScreenObject * child)
{
	//Debug
	cout << "Setting " << this << " as screen parent to " << child << endl;

	childrenScreenPtrs.push_back(child);
	//Child's parent should be set to self
	child->setScreenParent(this);
}

vector<ScreenObject*> ScreenObject::getScreenChildrenPtrs()
{
	return childrenScreenPtrs;
}

vector<ScreenObject*> * ScreenObject::getScreenChildrenPtrsPtr()
{
	return &childrenScreenPtrs;
}