#pragma once
#include "ofTrueTypeFont.h"
#include <string>

class SoundActionRegionText
{
public:
	SoundActionRegionText(void);
	ofTrueTypeFont font;
	unsigned int fontSize;
	float offsetFromCenterPercentX;
	float offsetFromCenterPercentY;
	int textColorR;
	int textColorG;
	int textColorB;
	int textColorA;
	string content;
	~SoundActionRegionText(void);
};

