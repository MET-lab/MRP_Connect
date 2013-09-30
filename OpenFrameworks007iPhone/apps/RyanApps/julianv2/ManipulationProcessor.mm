#include "ManipulationProcessor.h"


ManipulationProcessor::ManipulationProcessor(void)
{
}


ManipulationProcessor::~ManipulationProcessor(void)
{
}

int ManipulationProcessor::getNumTouches()
{
	//cout << "Attempting to get num touches for manip proc: " << this << endl;

	//cout << "Num touches: ";
	//cout << touchIDToCurrentTouch.size() << endl;

	return touchIDToCurrentTouch.size();
}


void ManipulationProcessor::addTouch(ofTouchEventArgs touch)
{
	//Think of it as 3 states, previous, current, and new
	//Previous and current are used for processing manipulations
	//Here is where 'new' touches are incorporated into those lists
	//Then the processing method is called when appropriate

	//Get touch info if available
	map<int,ofTouchEventArgs>::iterator iterPrev = touchIDToPreviousTouch.find(touch.id);
	map<int,ofTouchEventArgs>::iterator iterCurr = touchIDToCurrentTouch.find(touch.id);

	//Check for previous
	if( iterPrev == touchIDToPreviousTouch.end() ) 
	{
		//Previous touch was not found
		//Insert new info for past touch
		touchIDToPreviousTouch.insert(make_pair(touch.id,touch));
	}
	else
	{
		//Previous touch was found - strange? - change info for past
		iterPrev->second = touch;
	}

	//Check for current
	if( iterCurr == touchIDToCurrentTouch.end() ) 
	{
		//Current touch was not found
		//Insert new info current touch
		touchIDToCurrentTouch.insert(make_pair(touch.id,touch));
	}
	else
	{
		//Current touch was found - strange? - change info for current
		iterCurr->second = touch;
	}
}
void ManipulationProcessor::updateTouch(ofTouchEventArgs touch)
{
	//Think of it as 3 states, previous, current, and new
	//Previous and current are used for processing manipulations
	//Here is where 'new' touches are incorporated into those lists
	//Then the processing method is called when appropriate

	//Get touch info if available
	map<int,ofTouchEventArgs>::iterator iterPrev = touchIDToPreviousTouch.find(touch.id);
	map<int,ofTouchEventArgs>::iterator iterCurr = touchIDToCurrentTouch.find(touch.id);

	bool pastFound = false;
	bool currentFound = false;

	//Check for previous
	if( iterPrev == touchIDToPreviousTouch.end() ) 
	{
		//Previous touch was not found
		pastFound = false;
	}
	else
	{
		//Previous touch was found - good
		pastFound = true;
	}

	//Check for current
	if( iterCurr == touchIDToCurrentTouch.end() ) 
	{
		//Current touch was not found
		currentFound = false;
	}
	else
	{
		//Current touch was found
		currentFound = true;
	}


	//Decide what to do
	if(pastFound && currentFound)
	{
		//Both sets of info were found
		//Change past info to current info
		iterPrev->second = iterCurr->second;
		//Set current info to new info
		iterCurr->second = touch;
		//Run update
		touchesUpdated();
	}
	else if( pastFound && !currentFound )
	{
		//Past found and current not
		//Set current info to new info
		//Insert new info current touch
		touchIDToCurrentTouch.insert(make_pair(touch.id,touch));
		//Set past info to new info as well
		iterPrev->second = touch;
	}
	else if( !pastFound && currentFound )
	{
		//Past not found, current found
		//Set past info to current info
		//Insert new info for past touch
		touchIDToPreviousTouch.insert(make_pair(touch.id,iterCurr->second));
		//Set current info to new info
		iterCurr->second = touch;
		//Run update
		touchesUpdated();
	}
	else if( !pastFound && !currentFound )
	{
		//Insert current and past as the new info
		touchIDToCurrentTouch.insert(make_pair(touch.id,touch));
		touchIDToPreviousTouch.insert(make_pair(touch.id,touch));
	}
}
bool ManipulationProcessor::removeTouch(ofTouchEventArgs touch)
{
	//Returns true if touch was found and removed

	//Think of it as 3 states, previous, current, and new
	//Previous and current are used for processing manipulations
	//Here is where 'new' touches are incorporated into those lists
	//Then the processing method is called when appropriate

	//Get touch info if available
	map<int,ofTouchEventArgs>::iterator iterPrev = touchIDToPreviousTouch.find(touch.id);
	map<int,ofTouchEventArgs>::iterator iterCurr = touchIDToCurrentTouch.find(touch.id);

	//Check for previous
	if( iterPrev == touchIDToPreviousTouch.end() ) 
	{
		//Previous touch was not found
		//Ok
	}
	else
	{
		//Previous touch was found
		touchIDToPreviousTouch.erase(iterPrev);
	}

	//Check for current
	if( iterCurr == touchIDToCurrentTouch.end() ) 
	{
		//Current touch was not found
		//Ok
	}
	else
	{
		//Current touch was found
		touchIDToCurrentTouch.erase(iterCurr);
		return true;
	}
	return false;
}

void ManipulationProcessor::setOwner(TouchableObject* ownerObject)
{
	cout << "Manip Proc " << this << " Owner stored as: " << ownerObject << endl;
	owner = ownerObject;
}
TouchableObject* ManipulationProcessor::getOwner()
{
	return owner;
}

void ManipulationProcessor::touchesUpdated()
{
	//Get the two touch lists
	vector<ofTouchEventArgs> previousTouchList = getTouchListFromMap(touchIDToPreviousTouch);
	vector<ofTouchEventArgs> currentTouchList = getTouchListFromMap(touchIDToCurrentTouch);

	//Two touch lists into lists of screen points
	vector<ofPoint> previousPointList = getScreenPointListFromTouchList(previousTouchList);
	vector<ofPoint> currentPointList = getScreenPointListFromTouchList(currentTouchList);

	//Get the two center points
	ofPoint previousCenterPoint = getBoundingRectFromPoints(previousPointList).getCenterPoint();
	ofPoint currentCenterPoint = getBoundingRectFromPoints(currentPointList).getCenterPoint();

	//Calculate the movement
	///GAH! When calling from draw instead of from touch updates, the number of touches can be zero!
	int listSize = currentPointList.size();
	if(listSize == 0)
	{
		listSize = 1;
	}
	float dx = (currentCenterPoint.x - previousCenterPoint.x)/listSize;
	float dy = (currentCenterPoint.y - previousCenterPoint.y)/listSize;

	if(dx != 0 || dy !=0 )
	{
		//Do movement event
		//Debug
		//cout << "Touches moved for " << getOwner() << endl;
		getOwner()->touchesMoved(currentTouchList,dx,dy);
	}
	
	//Cannot scale or rotate with only one point
	if(currentPointList.size() > 1)
	{
		//Calculate total rotation
		//Create point (vector) representing horozontal to right (positive x)
		ofPoint horizontal = ofPoint(1,0);
		//Get angle for each point before
		vector<float> beforeAngles;
		//Calculate scaling
		//Calculate the average distance from center before
		float totalDistanceBefore = 0;
		float averageDistanceBefore = 0;
		for(int i = 0; i < previousPointList.size() ; i++)
		{
			//Make vector representing touch point from center point
			ofPoint toTouch = ofPoint(previousPointList[i].x - previousCenterPoint.x, previousPointList[i].y - previousCenterPoint.y);
			beforeAngles.push_back(horizontal.angle(toTouch));
			totalDistanceBefore += previousCenterPoint.distance(ofPoint(previousPointList[i].x,previousPointList[i].y));
		}
		averageDistanceBefore = totalDistanceBefore/ previousPointList.size();
		//Calculate the average distance from center now
		float totalDistanceNow = 0;
		float averageDistanceNow = 0;
		//Get angle for each point before
		vector<float> currentAngles;
		for(int i = 0; i < currentPointList.size() ; i++)
		{
			//Make vector representing touch point from center point
			ofPoint toTouch = ofPoint(currentPointList[i].x - currentCenterPoint.x, currentPointList[i].y - currentCenterPoint.y);
			currentAngles.push_back(horizontal.angle(toTouch));
			totalDistanceNow += currentCenterPoint.distance(ofPoint(currentPointList[i].x,currentPointList[i].y));
		}
		averageDistanceNow = totalDistanceNow/ currentPointList.size();
		//Calculate scale
		float scale =  totalDistanceNow/totalDistanceBefore;
		//Can't scale with one point
		if(scale !=0 && currentTouchList.size() > 1)
		{
			//For now, scale is same x and y
			//Do scale event
			getOwner()->touchesScaled(currentTouchList,scale,scale);
		}
		//Sum the differences (current - past)
		float totalRotation = 0;
		//Both vectors should be same size
		for(int i = 0; i < currentAngles.size() ; i++)
		{
			totalRotation += abs(currentAngles[i] - beforeAngles[i]);
		}
		//Can't rotate with one point
		if(totalRotation != 0 && currentTouchList.size() > 1)
		{
			//Do rotation event
			//Need to check for clockwise? This is probably wrong
			getOwner()->touchesRotated(currentTouchList,totalRotation);
		}
	}
}

vector<ofPoint> ManipulationProcessor::getScreenPointListFromTouchList(vector<ofTouchEventArgs> touchList)
{
	vector<ofPoint> rV;
	for(int i = 0; i < touchList.size() ; i++)
	{
		rV.push_back(ofPoint(touchList[i].x * ScreenObject::SCREEN_WIDTH, touchList[i].y * ScreenObject::SCREEN_HEIGHT));
	}
	return rV;
}


vector<ofTouchEventArgs> ManipulationProcessor::getTouchListFromMap(map<int,ofTouchEventArgs> theMap)
{
	vector<ofTouchEventArgs> rV;
	for ( map<int,ofTouchEventArgs>::iterator iter = theMap.begin(); iter != theMap.end(); iter++ )
	{
		rV.push_back(iter->second);
	}
	return rV;
}


BoundingRect ManipulationProcessor::getBoundingRectFromPoints(vector<ofPoint> pointList)
{
	float minX = 99999;
	float minY = 99999;
	float maxX = -99999;
	float maxY = -99999;

	for(int j = 0; j < pointList.size() ; j++)
	{
		if(pointList[j].x < minX)
		{
			minX = pointList[j].x;
		}
			
		if(pointList[j].y < minY)
		{
			minY = pointList[j].y;
		}

		if(pointList[j].x > maxX)
		{
			maxX = pointList[j].x;
		}

		if(pointList[j].y > maxY)
		{
			maxY = pointList[j].y;
		}
	}

	BoundingRect rV = BoundingRect(ofPoint(minX,minY),ofPoint(maxX,maxY));
	return rV;
}