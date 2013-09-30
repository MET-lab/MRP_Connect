#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

#include "ofxOpenALSoundPlayer.h"

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
    
    
    vector<ofxOpenALSoundPlayer> notes;
    
    ofxOpenALSoundPlayer synth[16]; 
    
    ofPoint audioLoc[5]; // one for each possible touch ID
    int audioSize[5];
    
    
    
    ofxOpenALSoundPlayer newNote;

    

    
    
    int SIDEMARGIN;
    int BOXSIZE;
    int SPACESIZE;
    double STARTINGVOLUME;
    
    
    bool activeType[5];
    
    
    int columnPlay;
    
    
    int lastMilli;
    int milliDif;
    int currentMilli;
    
    
    int rippleLastMilli;
    int rippleMilliDif;
    int rippleCurrentMilli;
    
    
    
    
    int bpm;
    
    
    bool movingBPM;
    
    bool changingSquares;
    
    int movingDif;
    
    int basis;
	
};
