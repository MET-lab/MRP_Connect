#pragma message ("\tAttempting to open BoundingRect Header...")
#pragma once
#pragma message ("\tOpened BoundingRect Header.")
#include "ofPoint.h"
#include <vector>

using namespace std;

class BoundingRect
{
public:
  BoundingRect (ofPoint from, float width, float height);
  BoundingRect (ofPoint p1, ofPoint p2);
  BoundingRect ();

  ofPoint getTopLeftPoint();
  ofPoint getBottomRightPoint();
  ofPoint getCenterPoint();
  vector<ofPoint> getVertices();
  vector<ofPoint> * getVerticesPtr();
  ~BoundingRect();

  float x1;
  float x2;
  float y1;
  float y2;
  float height;
  float width;

private:
	vector<ofPoint> vertices;
};