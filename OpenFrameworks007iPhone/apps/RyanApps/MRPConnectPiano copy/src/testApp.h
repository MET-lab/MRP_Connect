#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxOsc.h"




#define NUM_MSG_STRINGS 20








class testApp : public ofxiPhoneApp {
    
    
    
private:
    
    void redrawCalibrateBar();
    
    void redrawTopBar();
        
    void redrawBottomBar();


    
    
    bool mustRedraw;

    
    
    //all of these things are related to recieving OSC messages
private:
    
    ofxOscReceiver	receiver;
    
    int				current_msg_string;
    string			msg_strings[NUM_MSG_STRINGS];
    float			timers[NUM_MSG_STRINGS];
    
    
    int portNameListen;
    
    
    //these are the functions
public:
    
    
    typedef struct {
        double leftX, rightX, bottomY, topY;
    } keyDimensions;
    
    
    
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
    
    
    
    
    int detectKey(int x, int y);
    void rescale();
    
    bool detectWhiteKey(int touchX, int touchY, float x, float y, int shape, bool first, bool last, string title);
	bool detectBlackKey(int touchX, int touchY, float x, float y, string title);
    
    bool detectSpecificKey(int x, int y, int keyTest);
    
    
    void removeLeadZero();
    
    void addLeadZero();
    
    void touchWithinKey(int keyCompare);
    
    void dimWhiteKey (keyDimensions & keyDim, float x, float y, int shape, bool first, bool last); 
    
    void dimBlackKey(keyDimensions & keyDim, float x, float y); 
    
    void getDimensions(int keyCompare, keyDimensions & dimCompare);
    
    void center();
    
    void changeSos();
    void changeDamp();
    
    
    
    
private:
    
    
    //image files
    ofImage messageWindow;
    ofImage globalVolume;
    ofImage twoWayCom;
    ofImage patchSymbol;
    ofImage rowNum;
    ofImage pedalUnpushedSymbol;
    ofImage pedalPushedSymbol;
    ofImage barBottom;
    ofImage changeIpButton;    
    
    //osc information
    ofxOscSender sender;
    
    string hostName;
    int portName;
    
    
    
    float sizeFactor;
    
    ofTrueTypeFont	verdana30;
    
    
    
    
    // Display dimensions, normalized to the width of one white key
    
    float kWhiteKeyFrontWidthCore;
    float kBlackKeyWidthCore;
    float kWhiteKeyFrontLengthCore;
    float kWhiteKeyBackLengthCore;
    float kBlackKeyLengthCore;
    float kInterKeySpacingCore;
    
    // Individual geometry for C, D, E, F, G, A, B, c'
    
    float kWhiteKeyBackOffsetsCore[9];
    float kWhiteKeyBackWidthsCore[9];
    
    // Display margins
    
    float kDisplaySideMarginCore;
    float kDisplayBottomMarginCore;
    float kDisplayTopMarginCore;
    
    
    
    // Display dimensions, normalized to the width of one white key
    //These values are the values used when drawing.  Normally, these values are the core value * the size multiplier.
    
    float kWhiteKeyFrontWidth;
    float kBlackKeyWidth;
    float kWhiteKeyFrontLength;
    float kWhiteKeyBackLength;
    float kBlackKeyLength;
    float kInterKeySpacing;
    
    // Individual geometry for C, D, E, F, G, A, B, c'
    
    float kWhiteKeyBackOffsets[9];
    float kWhiteKeyBackWidths[9];
    
    // Display margins
    
    float kDisplaySideMargin;
    float kDisplayBottomMargin;
    float kDisplayTopMargin;
    
    
    
    
    //this stuff is currently unscaled, but me may change that
    
    
    // Key shape constants
    
    int kShapeForNote[12];
    int kWhiteToChromatic[7];
    float kWhiteKeyFrontBackCutoff; 
    
    // Touch constants
    float kDisplayMaxTouchSize;
    
    
    
    
    
    //variables for dragging, moving, and drawing
private:
    double translateX;
    
    double translateY;
    
    double translateXCore;
    
    double translateYCore;
    
    //information for touch data on a key
private:
	typedef struct {
		float locH;
		float locV1;
		float locV2;
		float locV3;
		float size1;
		float size2;
		float size3;
        
        
        int count;
        
        
	} TouchInfo;
	
	typedef struct {
		float x;
		float y;
	} Point;
	
public:
	//KeyboardDisplay();
	
	// Setup methods for display size and keyboard range
	void setKeyboardRange(int lowest, int highest);
	
	// Drawing methods
	void render();
    void renderSpecific(int keyDraw);

	
private:
	void drawWhiteKey(float x, float y, int shape, bool first, bool last, int highlighted, string title, float pressure);
	void drawBlackKey(float x, float y, int highlighted, string title, float pressure);
	
	void drawWhiteTouch(float x, float y, int shape, float touchLocH, float touchLocV, float touchSize);
	void drawBlackTouch(float x, float y, float touchLocV, float touchSize);
	
	// Indicate the shape of the given MIDI note.  0-6 for white keys C-B, -1 for black keys.
	// We handle unusual shaped keys at the top or bottom of the keyboard separately.
	
	int keyShape(int key);
	
    string getTitle(int keyCompare);
    
    
    
private:
	
	int lowestMidiNote_, highestMidiNote_;			// Which keys should be displayed (use MIDI note numbers)	
	
    
    vector<TouchInfo> currentTouches;
    
    
    string kKeyTitle[12];
    
    
    //the "span" of the keyboard is designated by the first and last key
    int key1;
    int key2;
    
    
    int playMode;
    
    //0 play
    //1 move
    //2 observe
    //3 calibrate
    
    
    int numFingersTouching;
    
    
    int sideShiftCoreX;
    
    //these all relate to dragging and pinching
    int centerX;
    int centerY;
    bool drag1valid;
    bool drag2valid;
    ofPoint drag1;
    ofPoint drag2;
    ofPoint drag1current;
    ofPoint drag2current;
    bool pinching;
    int pinchCenterX;
    int pinchCenterY;
    double coreSizeFactor;
    double difX;
    
    
    //if you tap a button or anything, dont do anything else with that finger unless you pick it up first
    bool switchFingerTouching;
    
    
    //information about the pedals
    bool damperPushed;
    bool sosPushed;
    int fingerDamp;
    int fingerSos;
    
    
    //for changing ip information
    int numOnHost;
    int numOnPort;
    bool changingIP;
    int numOnPortListen;
    
    
    //tracks which keys are currently being pressed on the ipad
    vector<bool>keyLit;
    
    
    //information about touches and their locations
    int fingerTouching[20];
    int fingerX[20];
    int fingerY[20];
    int TOUCHLIMIT;
    
    //related to which key is being calibrated and its calibration values
    int calibrateKeyHighlighted;
    string calibrateKeyTitle;
    vector<int> sliderVal1;
    vector<int> sliderVal2;
    int slider1Top;
    int slider2Top;
    int fingerSlide1Touching;
    int fingerSlide2Touching;
    int barSideShift;
    
    
    //information about the difference in a keys array location and its midi number
    int keyShift;
    
    //information to control and alter the piano
    int globalVol;
    int patchNum;
    int volumeBarShift;
    int volumeBarTop;
    bool displayIncoming;
    int patchLimit;
    int fingerVolumeTouching;
    
    
    //used for if two lines of keys are being drawn
    int keyNewLine;
    bool twoRows;
    
    //information about how hard the keys are being pressed on the piano
    vector <float> keyPressure;
    
    
};

