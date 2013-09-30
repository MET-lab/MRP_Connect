#include "Shape.h"


Shape::Shape()
{
	useAlternateFill = false;
	autoGenerateAlternateFill = true;
	rgbaAutoAlternateFillDecrement = 20;
}

Shape::~Shape(void)
{
}

void Shape::setFill(ShapeFill f)
{
	defaultFill = f;
	if(autoGenerateAlternateFill)
	{
		if((alternateFill.r - rgbaAutoAlternateFillDecrement < 0) || (alternateFill.g - rgbaAutoAlternateFillDecrement < 0) || (alternateFill.b - rgbaAutoAlternateFillDecrement < 0) || (alternateFill.a - rgbaAutoAlternateFillDecrement < 0) )
		{
			//Decrement will be too small - increment instead
			//Default alternate fill to slightly lighter shade
			alternateFill = defaultFill;
			alternateFill.r += rgbaAutoAlternateFillDecrement;
			alternateFill.g += rgbaAutoAlternateFillDecrement;
			alternateFill.b += rgbaAutoAlternateFillDecrement;
			alternateFill.a += rgbaAutoAlternateFillDecrement;
			alternateFill.rBorder += rgbaAutoAlternateFillDecrement;
			alternateFill.gBorder += rgbaAutoAlternateFillDecrement;
			alternateFill.bBorder += rgbaAutoAlternateFillDecrement;
			alternateFill.aBorder += rgbaAutoAlternateFillDecrement;
		}
		else
		{
			//Default alternate fill to slightly darker shade
			alternateFill = defaultFill;
			alternateFill.r -= rgbaAutoAlternateFillDecrement;
			alternateFill.g -= rgbaAutoAlternateFillDecrement;
			alternateFill.b -= rgbaAutoAlternateFillDecrement;
			alternateFill.a -= rgbaAutoAlternateFillDecrement;
			alternateFill.rBorder -= rgbaAutoAlternateFillDecrement;
			alternateFill.gBorder -= rgbaAutoAlternateFillDecrement;
			alternateFill.bBorder -= rgbaAutoAlternateFillDecrement;
			alternateFill.aBorder -= rgbaAutoAlternateFillDecrement;
		}
	}
}
ShapeFill Shape::getFill()
{
	return defaultFill;
}
void Shape::setAlternateFill(ShapeFill f)
{
	alternateFill = f;
}
ShapeFill Shape::getAlternateFill()
{
	return alternateFill;
}

BoundingRect Shape::getBoundingRect(void)
{
	float minX = 99999;
	float minY = 99999;
	float maxX = -99999;
	float maxY = -99999;

	for(int j = 0; j < vertices.size() ; j++)
	{
		if(vertices[j].x < minX)
		{
			minX = vertices[j].x;
		}
			
		if(vertices[j].y < minY)
		{
			minY = vertices[j].y;
		}

		if(vertices[j].x > maxX)
		{
			maxX = vertices[j].x;
		}

		if(vertices[j].y > maxY)
		{
			maxY = vertices[j].y;
		}
	}
	
	boundingRect.x1 = minX;
	boundingRect.y1 =minY;
	boundingRect.x2 =maxX;
	boundingRect.y2 =maxY;
	return boundingRect;
}

BoundingRect * Shape::getBoundingRectPtr(void)
{
	float minX = 99999;
	float minY = 99999;
	float maxX = -99999;
	float maxY = -99999;

	for(int j = 0; j < vertices.size() ; j++)
	{
		if(vertices[j].x < minX)
		{
			minX = vertices[j].x;
		}
			
		if(vertices[j].y < minY)
		{
			minY = vertices[j].y;
		}

		if(vertices[j].x > maxX)
		{
			maxX = vertices[j].x;
		}

		if(vertices[j].y > maxY)
		{
			maxY = vertices[j].y;
		}
	}
	
	boundingRect.x1 = minX;
	boundingRect.y1 =minY;
	boundingRect.x2 =maxX;
	boundingRect.y2 =maxY;
	return &boundingRect;
}


void Shape::rotateClockWise(float degrees)
{
	//Get center point of shape
	ofPoint centerPoint = getBoundingRectPtr()->getCenterPoint();

	//For each vertex
	for(int i = 0; i< vertices.size(); i ++)
	{
		//Get x and y coords relative ot center
		float x = vertices[i].x - centerPoint.x;
		float y = vertices[i].y - centerPoint.y;

		//Get current angle
		float absX = abs(x);
		float absY = abs(y);

		float angleRad = atan(absY/absX);
		if(absY ==0  && absX == 0)
		{
			angleRad = 0;
		}
		float angleDeg = (angleRad * 180.0 )/ PI;

		//Rotate
		//Since angle is from x axis and value passed is clockwise - subtract angle
		angleDeg -= degrees;

		//Get distance from center
		float dist = sqrt(pow(absX,2) + pow(absY,2));

		int signX =  x/absX;
		int signY = y/absY;
		//Prevent divide by 0 errors
		if(x==0)
		{
			signX =1;	
		}
		if(y==0)
		{
			signY = 1;
		}

		float newX = signX * dist * cos( (angleDeg/360.0)*(2*PI));
		float newY = signY * dist * sin( (angleDeg/360.0)*(2*PI));

		//Reapply those values
		vertices[i].x = newX;
		vertices[i].y = newY;
	}
}


bool Shape::isTouchWithin(ofTouchEventArgs & touch)
{
	//cout << "Touch Inside? " << this << " Point: " << touch.x * 1024 << ","<<touch.y * 768<< '\t' <<  ofInsidePoly(ofPoint(touch.x * 1024,touch.y * 768),vertices) << endl; 
	
	//if(ofInsidePoly(ofPoint(touch.x*SCREEN_WIDTH,touch.y*SCREEN_HEIGHT),vertices))
	//{
	//	cout << "Break" << endl;
	//}
	
	return ofInsidePoly(ofPoint(touch.x*SCREEN_WIDTH,touch.y*SCREEN_HEIGHT),vertices);
}

bool Shape::isPointWithin(ofPoint point)
{
	//Account for moveby shifting - subtract translate
	//Nevermind on translate
	//Do not use ofScale  - causes too many problems
	return ofInsidePoly(point,vertices);
}

void Shape::touchDown(ofTouchEventArgs & touch)
{
}
void Shape::touchUp(ofTouchEventArgs & touch)
{
}
void Shape::touchDraggedInto(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
}
void Shape::touchDraggedWithin(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
	//No manipulation actions done here.
}
void Shape::touchDraggedOutOf(ofTouchEventArgs & touchBefore, ofTouchEventArgs & touchNow)
{
}

void Shape::touchesMoved(vector<ofTouchEventArgs> touches, float delX, float delY)
{
	//Try to get parent to handle it
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->touchesMoved(touches,delX,delY);
	}
	else
	{
		//Default shape behavior with no parent is to move
		//Just move the shape by itself
		moveBy(delX,delY);
	}
}
void Shape::touchesRotated(vector<ofTouchEventArgs> touches, float rotationDegrees)
{
	//Try to get parent to handle it
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->touchesRotated(touches, rotationDegrees);
	}
	else
	{
		//Default shape behavior do it your self
		rotateClockWise(rotationDegrees);
	}

}
void Shape::touchesScaled(vector<ofTouchEventArgs> touches, float scaleFactorX, float scaleFactorY)
{
	//cout << "Scaled: " << scaleFactorX << endl;
	//Try to get parent to handle it
	if(getTouchParent() != NULL)
	{
		//Ask the parent to handle it
		getTouchParent()->touchesScaled(touches, scaleFactorX, scaleFactorY);
	}
	else
	{
		//Default shape behavior do it your self
		scale(scaleFactorX, scaleFactorY);
	}
}




void Shape::moveBy(float dx,float dy)
{
	newVertices = vertices;
	int numVertices = newVertices.size();

	for(int j = 0; j < numVertices; j++)
	{
		newVertices[j].x += dx;
		newVertices[j].y += dy;
	}
	vertices = newVertices;
}

void Shape::moveTopLeftCornerTo(float x, float y)
{
	//Find out how far to move the bounding rectangle
	//Then moveBy that far
	ofPoint topLeft = getBoundingRectPtr()->getTopLeftPoint();
	float diffX = x - topLeft.x;
	float diffY = y - topLeft.y;
	moveBy(diffX,diffY);
}

void Shape::moveCenterTo(float x, float y)
{
	//Get current position
	ofPoint currentCenter = getBoundingRectPtr()->getCenterPoint();

	//Find the difference
	float dx = x - currentCenter.x;
	float dy = y - currentCenter.y;

	//Move by that much
	moveBy(dx,dy);
}

void Shape::scale(float scaleFactorX,float scaleFactorY)
{
	//Get center point of shape
	ofPoint centerPoint = getBoundingRectPtr()->getCenterPoint();

	//For each vertex
	for(int i = 0; i< vertices.size(); i ++)
	{
		//Get x and y coords relative ot center
		float x = vertices[i].x - centerPoint.x;
		float y = vertices[i].y - centerPoint.y;

		//Scale those values
		x = scaleFactorX *x;
		y = scaleFactorY *y;

		//Reapply those values
		vertices[i].x = x + centerPoint.x;
		vertices[i].y = y + centerPoint.y;
	}
}


void Shape::draw()
{
	//Switch between color fills
	ShapeFill currentFill;
	if(useAlternateFill)
	{
		currentFill = alternateFill;
	}
	else
	{
		currentFill = defaultFill;
	}

	//Only if vertices exist
	if(vertices.size() >0)
	{
		if(currentFill.fillStyle == currentFill.SOLIDCOLOR)
		{
			ofSetColor(currentFill.r,currentFill.g,currentFill.b,currentFill.a);
			ofFill();
			ofBeginShape();
			for(int i = 0; i < vertices.size() ; i++)
			{
				ofVertex(vertices[i]);
			}
			ofEndShape();
		}
		else if(currentFill.fillStyle == currentFill.IMAGE)
		{
			//FIX!

			//currentFill.img.draw(50,50);
			
			/*
			//FIX THIS!

			//SETUP
			currentFill.texCoords.clear();
			for(int i=0; i<vertices.size(); i++)
			{  
				currentFill.texCoords.push_back(currentFill.img.getTextureReference().getCoordFromPoint(vertices[i].x,vertices[i].y).x);  
				currentFill.texCoords.push_back(currentFill.img.getTextureReference().getCoordFromPoint(vertices[i].x,vertices[i].y).y);  
			}  

			//DRAW
			currentFill.img.getTextureReference().bind();  
			glEnableClientState( GL_TEXTURE_COORD_ARRAY );  
			glTexCoordPointer(2, GL_FLOAT, 0, &currentFill.texCoords[0] );  
			glEnableClientState(GL_VERTEX_ARRAY);  
			glVertexPointer(2, GL_FLOAT, 0, &vertices[0] );  
			glDrawArrays( GL_TRIANGLE_FAN, 0, vertices.size() );  
			glDisableClientState( GL_TEXTURE_COORD_ARRAY );  
			currentFill.img.getTextureReference().unbind();  */
		}


		if(currentFill.hasBorder)
		{
			ofSetColor(currentFill.rBorder,currentFill.gBorder,currentFill.bBorder,currentFill.aBorder);
			ofNoFill();
			ofSetLineWidth(currentFill.borderThickness);
			ofBeginShape();
			for(int i = 0; i < vertices.size() ; i++)
			{
				ofVertex(vertices[i]);
			}
			ofEndShape();
		}
	}
}


void Shape::formHexagon(float topLeftX, float topLeftY, float sideLength)
{
	//Taken from Ryan's Code
	//x and y and left most point
	//Knowing
	//topLeftX = x
	//And topLeftY = y - ((sideLength*sqrt(3.0)) / 2)
	//Then
	float x = topLeftX;
	float y = topLeftY + ((sideLength*sqrt(3.0)) / 2);
	
	//Create list of ofPoints to replace verticies
	vector<ofPoint> newVertices;
	//leftmost point
    newVertices.push_back(ofPoint( x, y ));
        
    //upperleftmost point
    newVertices.push_back(ofPoint( x + (sideLength/2), y - ((sideLength*sqrt(3.0)) / 2) ));
        
    //upperrightmost point
    newVertices.push_back(ofPoint( x  + (sideLength/2) + sideLength, y - ((sideLength*sqrt(3.0)) / 2) ));
        
    //rightmost point
    newVertices.push_back(ofPoint( x + sideLength + sideLength, y ));
        
    //bottomrightmost point
    newVertices.push_back(ofPoint( x + (sideLength/2) + sideLength, y + ((sideLength*sqrt(3.0)) / 2) ));
        
    //bottomleftmost point
    newVertices.push_back(ofPoint( x + (sideLength/2), y + ((sideLength*sqrt(3.0)) / 2) ));
        
    //leftmost point
    newVertices.push_back(ofPoint( x, y ));

	//Change shape of shape
	vertices = newVertices;
}
