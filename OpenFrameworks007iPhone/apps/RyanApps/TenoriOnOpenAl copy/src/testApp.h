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
    
    ofxOpenALSoundPlayer synth[16]; //load in 10 instances so that they can be played multiple times (sort of). Right now ofxALSoundPlayer doesn't work with multiPlay
    int lastSoundPlayed; //counter to keep track of which sound we're playing
    
    ofPoint audioLoc[5]; // one for each possible touch ID
    int audioSize[5];
    
    
    
    ofxOpenALSoundPlayer newNote;

    
    
    
    void audioRequested( float * output, int bufferSize, int nChannels );

    
    
    float 	pan;
    int		sampleRate;
    bool 	bNoise;
    float 	volume;
    
    float 	* lAudio;
    float   * rAudio;
    
    //------------------- for the simple sine wave synthesis
    float 	targetFrequency;
    float 	phase;
    float 	phaseAdder;
    float 	phaseAdderTarget;
    int		initialBufferSize;
	
};
