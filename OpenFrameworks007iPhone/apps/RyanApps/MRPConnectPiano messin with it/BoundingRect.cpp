#include "BoundingRect.h"

using namespace std;

BoundingRect::BoundingRect()
{
	x1 = 0;
	x2 = 0;
	y1 =0;
	y2 =0;
}

BoundingRect::BoundingRect(ofPoint from, float width, float height)
{
	x1 = from.x;
	x2 = from.x + width;
	y1 = from.y;
	y2 = from.y + height;
}

BoundingRect::BoundingRect(ofPoint p1, ofPoint p2)
{
	x1 = p1.x;
	x2 = p2.x;
	y1 = p1.y;
	y2 = p2.y;
}

ofPoint BoundingRect::getCenterPoint()
{
	ofPoint rV;
	rV.x = (x1 + x2)/2.0;
	rV.y = (y1 + y2)/2.0;
	return rV;
}

vector<ofPoint> BoundingRect::getVertices()
{
	vertices.clear();
	vertices.push_back(ofPoint(x1,y1));
	vertices.push_back(ofPoint(x2,y1));
	vertices.push_back(ofPoint(x2,y2));
	vertices.push_back(ofPoint(x1,y2));
	return vertices;
}

vector<ofPoint> * BoundingRect::getVerticesPtr()
{
	vertices.clear();
	vertices.push_back(ofPoint(x1,y1));
	vertices.push_back(ofPoint(x2,y1));
	vertices.push_back(ofPoint(x2,y2));
	vertices.push_back(ofPoint(x1,y2));
	return &vertices;
}




BoundingRect::~BoundingRect(void)
{
}


ofPoint BoundingRect::getTopLeftPoint()
{
	float minY = 0;
	if(y1<=y2)
	{
		minY = y1;
	}
	else
	{
		minY = y2;
	}
	float minX = 0;
	if(x1<=x2)
	{
		minX = x1;
	}
	else
	{
		minX = x2;
	}

	return ofPoint(minX,minY);
}


ofPoint BoundingRect::getBottomRightPoint()
{
	float maxY = 0;
	if(y1>=y2)
	{
		maxY = y1;
	}
	else
	{
		maxY = y2;
	}
	float maxX = 0;
	if(x1>=x2)
	{
		maxX = x1;
	}
	else
	{
		maxX = x2;
	}

	return ofPoint(maxX,maxY);
}
