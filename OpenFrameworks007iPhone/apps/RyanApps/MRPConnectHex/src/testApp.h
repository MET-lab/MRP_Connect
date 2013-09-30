#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxOsc.h"



class testApp : public ofxiPhoneApp {
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    void touchCancelled(ofTouchEventArgs &touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    
    void rescale();
    
    void relocate();
    
    void center();
    
    void audioRequested( float * output, int bufferSize, int nChannels );
    
    
    void removeLeadZero();
    
    void addLeadZero();
    
private:    
    
    
    ofTrueTypeFont	verdana30;
    
    double sizeFactorCore;
    
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
    
    ofxOscSender sender;
    
    string hostName;
    int portName;
    
    
    

};

