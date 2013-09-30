#pragma once
#include "shape.h"
class SolidColorShape : public Shape
{
public:
	int colorR, colorG, colorB, colorA;
	SolidColorShape(string shapeName);
	~SolidColorShape(void);
};

