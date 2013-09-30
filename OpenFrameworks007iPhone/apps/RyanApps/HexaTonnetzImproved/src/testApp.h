#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include <stdio.h>
#include <stdlib.h>


class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();

	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);

    void rescale();
    
    void relocate();
    
    void center();
    
    void audioRequested( float * output, int bufferSize, int nChannels );

    
private:   
    
    
    int		sampleRate;
    float 	volume;
    int initialBufferSize;
    
    float 	* lAudio;
    float   * rAudio;
    
    
    double SIDELENGTH;    
    int BIGGERNUMHOR;    
    int BIGGERNUMVERT;    
    int TOUCHLIMIT;    
    int SIDESHIFT;    
    int TOPSHIFT;    
    int NUMNOTES;    
    int BOTTOMSCREENCUTOFF;
    
    
    double sizeFactorCore;
     
    double pinchCenterX;
    double pinchCenterY;
    

    bool resizing;
    
    
    int centerX;    
    int centerY;
    
    
    int sideShiftCoreX;    
    int sideShiftCoreY;
    

    int numFingersTouching;
    

    int baseColor;
    

    double fingerFrequencies[10];
    double fingerPhaseAdder[10];
    double fingerPhaseAdderTarget[10];
    double fingerPhase[10];
    int fingerTouching[10];
    
    
    string colorTitles[12];
    
    
    double sizeFactor;
    
    
    bool switchFingerTouching;
    
    
    bool pinching;
    
    
    ofPoint drag1;
    ofPoint drag2;
    
    ofPoint drag1current;
    ofPoint drag2current;
    
    bool drag1valid;
    bool drag2valid;
    
    
};
