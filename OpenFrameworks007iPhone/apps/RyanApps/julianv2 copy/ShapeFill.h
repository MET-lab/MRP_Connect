#pragma message ("\tAttempting to open ShapeFill Header...")
#pragma once
#pragma message ("\tOpened ShapeFill Header.")
#include <string>
#include "ofImage.h"

using namespace std;

class ShapeFill
{
	//Filled with image or solid color
public:
	ShapeFill(void);
	enum FILL_STYLE { SOLIDCOLOR, IMAGE };
	FILL_STYLE fillStyle;
	unsigned int r, g ,b, a;
	bool hasBorder;
	unsigned int borderThickness;
	bool borderThicknessScales;
	unsigned int rBorder, gBorder, bBorder, aBorder;
	string getImageFilePath();
	void setImageFilePath(string path);
	~ShapeFill(void);

	//Drawing images
	ofImage img;
	vector<float> texCoords;

private:
	string imageFilePath;
	
};

