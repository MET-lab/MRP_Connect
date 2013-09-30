#include "ShapeFill.h"


ShapeFill::ShapeFill(void)
{
	//Set defaults
	fillStyle = ShapeFill::FILL_STYLE::SOLIDCOLOR;
	r = 0;
	g = 0;
	b = 0;
	a = 0;
	hasBorder = false;
	rBorder = 0;
	gBorder = 0;
	bBorder = 0;
	aBorder = 0;
	imageFilePath = "";
	borderThickness = 5;
	borderThicknessScales = false;
}


ShapeFill::~ShapeFill(void)
{
}

string ShapeFill::getImageFilePath()
{
	return imageFilePath;
}
void ShapeFill::setImageFilePath(string path)
{
	imageFilePath = path;
	img.loadImage(path);
}