#include "TouchHandler.h"

using namespace std;

TouchHandler::TouchHandler(void)
{
	//Touch handler serves as main parent for all touchable objects on screen
	//Touch position seems slightly off?
}

TouchHandler::~TouchHandler(void)
{
}

void TouchHandler::addTouchableObjectToHandle(TouchableObject* touchObject)
{
	//When adding a touch object directly to the handler its parent is the handler
	//Thus there is no need for a pointer to a parent object
	//Set pointer to null
	touchObject->setTouchParent(NULL);
	ptrTouchObjectsToHandle.push_back(touchObject);
}

void TouchHandler::touchDown(ofTouchEventArgs & touch)
{	
	//New method
	//Get the object that this touch should go to
	TouchableObject * touchedObject = getTopObjectFromTouch(touch);

	//Debug
	//if(touchedObject!=NULL)
	//{
	//	cout << "Touched object: " << touchedObject << " ScreenParent: " << touchedObject->getScreenParent() << " TouchParent: " << touchedObject->getTouchParent() << endl;
	//}

	//If there was an object touched
	if(touchedObject != NULL)
	{
		//Add touch to manipulation processor
		touchedObject->getManipulationProcessorPtr()->addTouch(touch);
		//Send touchdown event
		touchedObject->touchDown(touch);
	}
	
	//Keep track of positions
	//Check to see if a previous position exists for this touch
	map<int,ofTouchEventArgs>::iterator iter = lastTouches.find(touch.id);
	if( iter == lastTouches.end() ) 
	{
		//Previous touch was not found
		//Insert new info
		lastTouches.insert(make_pair(touch.id,touch));
	}
	else
	{
		//Previous touch was found - change info
		iter->second = touch;
	}
}

void TouchHandler::recursiveTouchUp(TouchableObject* parent, ofTouchEventArgs & touch)
{
	//If the parent has children
	if( parent->getTouchChildrenPtrs().size() > 0)
	{
		//Loop through each child
		for(int i = 0; i < parent->getTouchChildrenPtrs().size(); i++)
		{
			recursiveTouchUp(parent->getTouchChildrenPtrs()[i], touch);
		}
	}
	else
	{
		//No children
		//(Attempt to) Remove this touch
		//removeTouch returns true if touch was found and removed
		if(parent->getManipulationProcessorPtr()->removeTouch(touch))
		{
			//Also run touch up event if found
			parent->touchUp(touch);
		}
	}
}

void TouchHandler::touchUp(ofTouchEventArgs & touch)
{
	//Loop through all touchable objects (and their children recursively)
	for(int i = 0; i < ptrTouchObjectsToHandle.size(); i++)
	{
		recursiveTouchUp(ptrTouchObjectsToHandle[i],touch);
	}


	//Old code
	/*

	//Run touch up event for only object that was up touched
	//Get the object that this current touch should go to
	TouchableObject * touchedObject = getTopObjectFromTouch(touch);
	//If there was an object touched
	if(touchedObject != NULL)
	{
		//Send touchdown event
		touchedObject->touchUp(touch);
		//Then remove (redundant?)
		touchedObject->getManipulationProcessorPtr()->removeTouch(touch);
	}
	*/


		/*
	//Check current and previous touch to do remove events for specific objects
	//Check to see if a previous position exists for this touch
	map<int,ofTouchEventArgs>::iterator prevIter = lastTouches.find(touch.id);
	bool prevFound = false;
	ofTouchEventArgs previousTouch;
	if( prevIter != lastTouches.end() ) 
	{
		//Previous touch was found
		prevFound = true;
		previousTouch = prevIter->second;
	}

	if(prevFound)
	{
		//Get the object that this previous touch should go to
		TouchableObject * prevTouchedObject = getTopObjectFromTouch(previousTouch);
		//If there was an object touched
		if(prevTouchedObject  != NULL)
		{
			//Do not do touchedObject->touchUp for this touch because it is in the previous position
			//Then remove touch from manip proc
			prevTouchedObject->getManipulationProcessorPtr()->removeTouch(previousTouch);
		}	
	}
	*/

	//Keep track of positions
	//Check to see if a previous position exists for this touch
	map<int,ofTouchEventArgs>::iterator iter = lastTouches.find(touch.id);
	if( iter == lastTouches.end() ) 
	{
		//Previous touch was not found
		//Strange but ...ok?
	}
	else
	{
		//Previous touch was found - erase info
		lastTouches.erase(iter);
	}
	
}

void TouchHandler::touchMoved(ofTouchEventArgs & touch)
{
	ofTouchEventArgs previousTouch;

	//Check to see if a previous position exists for this touch
	map<int,ofTouchEventArgs>::iterator iter = lastTouches.find(touch.id);
	if( iter == lastTouches.end() ) 
	{
		//Previous touch was not found
		//Insert new info
		lastTouches.insert(make_pair(touch.id,touch));
	}
	else
	{
		//Previous touch was found
		//Get previous touch info
		previousTouch = iter->second;

		//New method
		//Get the object that current touch should go to
		TouchableObject * currentTouchedObject = getTopObjectFromTouch(touch);
		TouchableObject * previousTouchedObject = getTopObjectFromTouch(previousTouch);
		
		if(previousTouchedObject == NULL && currentTouchedObject == NULL)
		{
			//Dragged in free space - irrelevant
		}
		else if(previousTouchedObject == NULL && currentTouchedObject != NULL)
		{
			//Dragged from nowhere into current object
			currentTouchedObject->touchDraggedInto(previousTouch,touch);
			//Include touch in manipulation
			currentTouchedObject->getManipulationProcessorPtr()->addTouch(touch);
		}
		else if(previousTouchedObject != NULL && currentTouchedObject == NULL)
		{
			//Dragged out of previous object into nowhere
			previousTouchedObject->touchDraggedOutOf(previousTouch,touch);
			//Include touch in manipulation
			previousTouchedObject->getManipulationProcessorPtr()->removeTouch(touch);
		}
		else if(previousTouchedObject != NULL && currentTouchedObject != NULL)
		{
			//Dragged from previous object into current object
			//Are they the same?
			if(previousTouchedObject == currentTouchedObject)
			{
				//Dragged within the same object
				currentTouchedObject->touchDraggedWithin(previousTouch,touch);
				//Include touch in manipulation
				currentTouchedObject->getManipulationProcessorPtr()->updateTouch(touch);
			}
			else
			{
				//Dragged between two different objects
				//Out of previous one
				previousTouchedObject->touchDraggedOutOf(previousTouch,touch);
				//Include touch in manipulation
				previousTouchedObject->getManipulationProcessorPtr()->removeTouch(touch);
				//Into current one
				currentTouchedObject->touchDraggedInto(previousTouch,touch);
				//Include touch in manipulation
				currentTouchedObject->getManipulationProcessorPtr()->addTouch(touch);
			}
		}

		//Set previous touch info
		iter->second = touch;
	}
}


vector<TouchableObject*> TouchHandler::getObjectsThatContain(ofTouchEventArgs & touch)
{
	vector<TouchableObject*> rV;

	//Recurse through list and get how many objects contain the touch
	//For each child run touch moved
	for(int i = 0; i< ptrTouchObjectsToHandle.size() ; i++)
	{
		//Only objects with zero children (assumed to be at the bottom of
		//Parent child heirarchy are counted
		recursiveGetObjectsThatContain(ptrTouchObjectsToHandle[i],touch,rV);
	}
	return rV;
}


void TouchHandler::recursiveGetObjectsThatContain(TouchableObject* touchObjectParent, ofTouchEventArgs & touch, vector<TouchableObject*> & container)
{
	//Container passed by reference so can be modifed throughout recursion

	//End case - no children
	if(touchObjectParent->getTouchChildrenPtrs().size() == 0)
	{
		//Include in list?
		if(touchObjectParent->isTouchWithin(touch))
		{
			container.push_back(touchObjectParent);
		}
	}
	else
	{
		//Children exist
		//For each child of this object
		for(int i = 0; i< touchObjectParent->getTouchChildrenPtrs().size() ; i++)
		{
			recursiveGetObjectsThatContain(touchObjectParent->getTouchChildrenPtrs()[i],touch,container);
		}
	}
}

TouchableObject * TouchHandler::getTopObjectFromTouch(ofTouchEventArgs & touch)
{
	TouchableObject * rV;

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

	//Get the screen object
	ScreenObject * screenObject =  drawHandler->getTopObjectFromTouch(touch);

	//Try to cast object as touchable object
	rV = dynamic_cast<TouchableObject*>(screenObject);
	return rV;
}
