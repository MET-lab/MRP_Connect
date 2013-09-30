#include "SoundActionRegionText.h"


SoundActionRegionText::SoundActionRegionText(void)
{
	//Defaults
	////Relative path doesn't work? - Try .\ ?
	fontSize =12;
	font.loadFont("C:\\Users\\TekAdmin\\Dropbox\\Julian\\SurfaceMusicApp\\OpenFrameworksApp-NoTranslate-WithPtr\\apps\\examples\\SampleApp\\bin\\data\\vag.ttf",fontSize);
	offsetFromCenterPercentX = 0;
	offsetFromCenterPercentX = 0;
	textColorR = 255;
	textColorG = 255;
	textColorB = 255;
	textColorA = 255;
}


SoundActionRegionText::~SoundActionRegionText(void)
{
}
