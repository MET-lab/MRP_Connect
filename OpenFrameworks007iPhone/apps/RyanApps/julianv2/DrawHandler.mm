#include "DrawHandler.h"


DrawHandler::DrawHandler(void)
{

}


DrawHandler::~DrawHandler(void)
{
}

void DrawHandler::addScreenObjectToHandle(ScreenObject* screenObject)
{
	//When adding a screen object directly to the handler its parent is the handler
	//Thus there is no need for a pointer to a parent object
	//Set pointer to null
	screenObject->setScreenParent(NULL);
	ptrScreenObjectsToDraw.push_back(screenObject);
}

unsigned int DrawHandler::getZIndex(ScreenObject * so)
{
	//TODO
	return 0;
}

void DrawHandler::setZIndex(ScreenObject * so)
{
	//TODO
}

void DrawHandler::draw()
{
	//Draw visible screen objects
	//Go through ptrScreenObjectsToDraw and their children
	//Draw everything
	for(int i = 0; i< ptrScreenObjectsToDraw.size() ; i++)
	{
		if(ptrScreenObjectsToDraw[i]->isVisible)
		{
			//Recursively draw
			recursiveDraw(ptrScreenObjectsToDraw[i]);
		}
	}
}

void DrawHandler::recursiveDraw(ScreenObject * parentObject)
{
	//Use pointers to increase speed
	vector<ScreenObject*> * screenChildrenPtrsPtr = parentObject->getScreenChildrenPtrsPtr();
	int numChildren = screenChildrenPtrsPtr->size();
	
	//Draw children?
	if(numChildren >0)
	{
		//Has children
		//Loop through all children
		for(int i = 0; i< numChildren ; i++)
		{
			if((*screenChildrenPtrsPtr)[i]->isVisible)
			{
				//Recursively draw
				recursiveDraw((*screenChildrenPtrsPtr)[i]);
			}
		}
	}

	//Try to update touch info for this shape in sync (before) with drawing//////////////////////
	//TouchableObject * toBeUpdated;
	/*
	dynamic_cast should do the trick

	TYPE& dynamic_cast<TYPE&> (object);
	TYPE* dynamic_cast<TYPE*> (object);
	The dynamic_cast keyword casts a datum from one pointer or reference type to another, performing a 
	runtime check to ensure the validity of the cast.

	If you attempt to cast to pointer to a type that is not a type of actual object, the result of 
	the cast will be NULL. If you attempt to cast to reference to a type that is not a type of actual 
	object, the cast will throw a bad_cast exception.

	Make sure there is at least one virtual function in Base class to make dynamic_cast work.
	*/

	//Try to cast object as touchable object
	// = dynamic_cast<TouchableObject*>(parentObject);

	//if(toBeUpdated !=NULL)
	//{
	//	toBeUpdated->getManipulationProcessorPtr()->touchesUpdated();
	//}
	/////////////////////////////////////////////////////////////////////////////////////////

	//Draw parent last as parent is assumed to be drawn with children on top
	parentObject->draw();
}



ScreenObject * DrawHandler::getTopObjectFromPoint(ofPoint p)
{
	ScreenObject * rV = NULL;
	//Loop through all the object to draw and return the last one
	//That contains the point
	//Assumes last item drawn is on top
	for(int i = 0; i< ptrScreenObjectsToDraw.size() ; i++)
	{
		//Recurse through object and children
		//rV is modified through reference pass
		recursiveGetTopObjectFromPoint(ptrScreenObjectsToDraw[i],p,rV);
	}
	return rV;
}

void DrawHandler::recursiveGetTopObjectFromPoint(ScreenObject * parentObject, ofPoint p, ScreenObject * &rV)
{
	//First check that the point is in the bounding rect
	//If not in bounding rect then assumed not in any children

	if(ofInsidePoly(p,parentObject->getBoundingRectPtr()->getVertices()))
	{
		//Pass pointer to return value by reference so it can be modified
		if(parentObject->getScreenChildrenPtrs().size() != 0 )
		{
			//Has children
			//Loop through children
			//Use pointers to increase speed
			vector<ScreenObject*> * screenChildrenPtrsPtr = parentObject->getScreenChildrenPtrsPtr();
			int numChildren = screenChildrenPtrsPtr->size();
			for(int i = 0; i< numChildren ; i++)
			{
				//Recurse through object and children
				//rV is modified through reference pass
				recursiveGetTopObjectFromPoint((*screenChildrenPtrsPtr)[i],p,rV);
			}
		}
		else
		{
			//No children
			//Check if this object has touch in it
			if(parentObject->isPointWithin(p))
			{
				rV = parentObject;
			}
		}
	}
	//Not within bounding rect
}



ScreenObject * DrawHandler::getTopObjectFromTouch(ofTouchEventArgs & touch)
{
	return getTopObjectFromPoint(ofPoint(touch.x * ScreenObject::SCREEN_WIDTH, touch.y*ScreenObject::SCREEN_HEIGHT));
}
