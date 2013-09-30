#include "testApp.h"






//my apologies in advance, I didn't delete some of the original code's comments so the comments from the original keyboardTouchCocoa may not be relevant, and the whitespace can be a bit inconsistent

//its really messy and I'm working on cleaning it, feel free to alter comments and whitespace as you see fit


//For the sake of a smoother user interface, a lot of the functions such as pinching, dragging, changing modes, etc limit multitouch (for example, if you are dragging, you may not be allowed to do anything else)


//IMPORTANT:  To the best of my knowledge, everything in this program works, with the possible exception of sending and recieving keytouch information, because it hasn't been extensively tested.
//Any other errors that are found, please let Ryan Daugherty know at rmd77@drexel.edu

//how touchevents work:  you can access touch.x and touch.y which are position.  touch.id is an identifier used based on the other of fingers touched.  first touched is 0, second is 1, third is 2, etc.  Say you removed the second finger while keeping the first and third on, and then placed another finger, that would be 1, not 3.






//--------------------------------------------------------------
void testApp::setup()
{
    
    mustRedraw = true;
    
    ofSetBackgroundAuto(false);
    
    TOUCHLIMIT = 10;
    
    //information about the port the ipad is listening on for osc messages
    numOnPortListen = 0;
    portNameListen = 12345;    
    receiver.setup( portNameListen );
    current_msg_string = 0;
    
    displayIncoming = true;
    
    //this is for formatting multiple rows of keys
    keyNewLine = 53;
    twoRows = false;
    
    fingerVolumeTouching = -1;
    volumeBarShift = 20;
    volumeBarTop = 70;
    globalVol = 120;
    
    patchLimit = 127;
    patchNum = 0;
    
    for (int i = 0; i < TOUCHLIMIT + 10; i++)
    {
        fingerTouching[i] = -1;
        fingerX[i] = -1;
        fingerY[i] = -1;
    }
    
    //this is the difference between the midi value of a key, and its location in the array of keys
    keyShift = 12;
    
    fingerDamp = -1;
    fingerSos = -1;
    
    fingerSlide1Touching = -1;
    fingerSlide2Touching = -1;
    
    slider1Top = 100;
    slider2Top = 160;
    barSideShift = 111;
    
    calibrateKeyHighlighted = -1;
    
    numOnHost = 0;
    numOnPort = 0;
    hostName = "10.0.1.144";
    portName = 12345;
	// open an outgoing connection to HOST:PORT
	sender.setup( hostName, portName);
    
    calibrateKeyTitle = "Please touch a key to calibrate.";
    
    ofTrueTypeFont::setGlobalDpi(72);
	verdana30.loadFont("verdana.ttf", 30, true, true);
	verdana30.setLineHeight(34.0f);
	verdana30.setLetterSpacing(1.035);
    
    globalVolume.loadImage("globalVolume.png");
    messageWindow.loadImage("messageWindow.png");
    patchSymbol.loadImage("patchSymbol.png");
    twoWayCom.loadImage("twoWayCom.png");
    pedalUnpushedSymbol.loadImage("pedalbutton.png");
    pedalPushedSymbol.loadImage("pedalbuttonpushed.png");
    rowNum.loadImage("rowNum.png");
    barBottom.loadImage("barBottom.png");
    changeIpButton.loadImage("changeIpButton.png");
    
    
    changingIP = false;
    
    playMode = 0;
    
    damperPushed = false;
    sosPushed = false;
    
    drag1valid = false;
    drag2valid = false;
    pinching = false;
    
    numFingersTouching = 0;
    
    key1 = 9;
    key2 = 96;
    
    
    //yes technically it would save space to start i at key1, but starting at 0 just makes formatting and calling keys in the array a lot easier
    for (int i = 0; i <= key2; i++)
    {
        
        keyLit.push_back(false);
        sliderVal1.push_back(0);
        sliderVal2.push_back(400);
        keyPressure.push_back(0);
        
        TouchInfo t;
        t.count = 0;
        currentTouches.push_back(t);
        
    }
    setKeyboardRange(key1, key2);
    
    
    
    centerX = 0;
    centerY = 0;
    
    
    sideShiftCoreX = 0;
    
    
	ofSetOrientation(OF_ORIENTATION_90_RIGHT);
    ofSetFrameRate(60);
	ofBackground( 80, 80, 80 );
    
    
    
    kKeyTitle[0] = "C";
    kKeyTitle[1] = "Db";
    kKeyTitle[2] = "D";
    kKeyTitle[3] = "Eb";
    kKeyTitle[4] = "E";
    kKeyTitle[5] = "F";
    kKeyTitle[6] = "Gb";
    kKeyTitle[7] = "G";
    kKeyTitle[8] = "Ab";
    kKeyTitle[9] = "A";
    kKeyTitle[10] = "Bb";
    kKeyTitle[11] = "B";
    
    
    
    // Display dimensions, normalized to the width of one white key
    //these are the "base" dimensions, the actual draw sizes are all based on these proportions
    kWhiteKeyFrontWidthCore = 1.0;
    kBlackKeyWidthCore = 0.5;
    kWhiteKeyFrontLengthCore = 2.3;
    kWhiteKeyBackLengthCore = 4.1;
    kBlackKeyLengthCore = 4.0;
    kInterKeySpacingCore = 0.1;
    
    
    // Individual geometry for C, D, E, F, G, A, B, c'
    
    kWhiteKeyBackOffsetsCore[0] = 0;
    kWhiteKeyBackOffsetsCore[1] =0.22;
    kWhiteKeyBackOffsetsCore[2] = 0.42;
    kWhiteKeyBackOffsetsCore[3] =0;
    kWhiteKeyBackOffsetsCore[4] =0.14;
    kWhiteKeyBackOffsetsCore[5] =0.3;
    kWhiteKeyBackOffsetsCore[6] =0.44;
    kWhiteKeyBackOffsetsCore[7] =0.22;
    kWhiteKeyBackOffsetsCore[8] =0;
    
    kWhiteKeyBackWidthsCore[0] = 0.6;
    kWhiteKeyBackWidthsCore[1] = 0.58;
    kWhiteKeyBackWidthsCore[2] = 0.58;
    kWhiteKeyBackWidthsCore[3] = 0.56;
    kWhiteKeyBackWidthsCore[4] = 0.56;
    kWhiteKeyBackWidthsCore[5] = 0.56;
    kWhiteKeyBackWidthsCore[6] = 0.56;
    kWhiteKeyBackWidthsCore[7] = 0.58;
    kWhiteKeyBackWidthsCore[8] = 1.0;
    
    // Display margins
    
    kDisplaySideMarginCore = 0.4;
    kDisplayBottomMarginCore = 0.8;
    kDisplayTopMarginCore = 0.8;
    
    // Key shape constants
    
    kShapeForNote[0] = 0;
    kShapeForNote[1] = -1;
    kShapeForNote[2] = 1;
    kShapeForNote[3] = -1;
    kShapeForNote[4] = 2;
    kShapeForNote[5] = 3;
    kShapeForNote[6] = -1;
    kShapeForNote[7] = 4;
    kShapeForNote[8] = -1;
    kShapeForNote[9] = 5;
    kShapeForNote[10] = -1;
    kShapeForNote[11] = 6;
    
    
    kWhiteToChromatic[0] = 0;
    kWhiteToChromatic[1] = 2;
    kWhiteToChromatic[2] = 4;
    kWhiteToChromatic[3] = 5;
    kWhiteToChromatic[4] = 7;
    kWhiteToChromatic[5] = 9;
    kWhiteToChromatic[6] = 11;
    kWhiteKeyFrontBackCutoff = (6.5 / 19.0); 
    
    
    
    //size factor basically refers to how many pixel wide the front of white key will be, all other sizes are based on the preexisting ratios
    sizeFactor = 60;
    
    
    
    // these are the ones based on the resized values
    // when actually drawing the keys, you use these values, when resizing, you determine the new size based on the Core values
    
    kWhiteKeyFrontWidth = kWhiteKeyFrontWidthCore*sizeFactor;
    kBlackKeyWidth = kBlackKeyWidthCore*sizeFactor;
    kWhiteKeyFrontLength = kWhiteKeyFrontLengthCore*sizeFactor;
    kWhiteKeyBackLength = kWhiteKeyBackLengthCore*sizeFactor;
    kBlackKeyLength = kBlackKeyLengthCore*sizeFactor;
    kInterKeySpacing = kInterKeySpacingCore*sizeFactor;
    
    
    for (int i = 0; i < 9; i++)
    {
        kWhiteKeyBackOffsets[i] = kWhiteKeyBackOffsetsCore[i]*sizeFactor;
        kWhiteKeyBackWidths[i] = kWhiteKeyBackWidthsCore[i]*sizeFactor;
    }
    
    
    kDisplaySideMargin = kDisplaySideMarginCore * sizeFactor;
    kDisplayBottomMargin = kDisplayBottomMarginCore * sizeFactor;
    kDisplayTopMargin = kDisplayTopMarginCore * sizeFactor;
    
    
    
    //translateXCore and translateYCore refer to the lower left point of the first key, when drawing, all positions are defined relative to this 
    translateXCore = 50;
    translateYCore = 700;
    
    
    
    center();
    
    
    
}

//--------------------------------------------------------------
void testApp::update()
{
	//we do a heartbeat on iOS as the phone will shut down the network connection to save power
	//this keeps the network alive as it thinks it is being used. 
	if( ofGetFrameNum() % 120 == 0 ){
        ofxOscMessage m;
        m.setAddress( "/misc/heartbeat" );
        m.addIntArg( ofGetFrameNum() );
        sender.sendMessage( m );
        
	}
    
    
    
	
	// hide old messages
	for( int i=0; i<NUM_MSG_STRINGS; i++ ){
		if( timers[i] < ofGetElapsedTimef() )
			msg_strings[i] = "";
	}
    
	// check for waiting messages
	while( receiver.hasWaitingMessages() )
    {
        mustRedraw = true;
		// get the next message
		ofxOscMessage m;
		receiver.getNextMessage( &m );
        
		// check for mouse moved message
        
        
        
        //patch being changed
		if( m.getAddress() == "/mrp/ui/patch/number" )
        {
            
            patchNum = m.getArgAsInt32(0);
            
            redrawTopBar();
            
		}
        //keys being pressed or released
        else if ( m.getAddress() == "/mrp/key/pos" )
        {
            
            keyPressure[m.getArgAsInt32(0)-keyShift] = m.getArgAsFloat(1);
            
            if ( keyPressure[m.getArgAsInt32(0)-keyShift] < 0 )
            {
                keyPressure[m.getArgAsInt32(0)-keyShift] = 0;
            }
            
            if (playMode == 3)
            {
                
                calibrateKeyHighlighted = m.getArgAsInt32(0)-keyShift;
                
            }
            
            renderSpecific(m.getArgAsInt32(0)-keyShift);
            
            
        }
        
        //touch key information
        else if ( m.getAddress() == "/touchkeys/raw")
        {
            
            TouchInfo recievedKey;
            
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            
            int numTouching = 0;
            
            recievedKey.locV1 = m.getArgAsFloat(1);
            recievedKey.size1 = m.getArgAsFloat(2);
            
            recievedKey.locV2 = m.getArgAsFloat(3);
            recievedKey.size2 = m.getArgAsFloat(4);
            
            recievedKey.locV3 = m.getArgAsFloat(5);
            recievedKey.size3 = m.getArgAsFloat(6);
            
            recievedKey.locH = m.getArgAsFloat(7);
            
            for (int iii = 2; iii < 7; iii+= 2)
            {
                if (m.getArgAsFloat(iii)>0)
                {
                    numTouching++;
                }
            }
            
            recievedKey.count = numTouching;
            
            currentTouches[keyTouching] = recievedKey;
            
            //right now when key touch information is updated, redraw everything.  there are probably more efficient ways to refresh this part of the screen, but it's not a big hassle
            
            mustRedraw = true;
            
        }
        //turn off a key
        else if ( m.getAddress() == "/touchkeys/off")
        {
            TouchInfo recievedKey;
            
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            recievedKey.locV1 = 0;
            recievedKey.size1 = 0;
            recievedKey.locV2 = 0;
            recievedKey.size2 = 0;
            recievedKey.locV3 = 0;
            recievedKey.size3 = 0;
            recievedKey.locH = 0;
            recievedKey.count = 0;
            
            currentTouches[keyTouching] = recievedKey;
            
            recievedKey = currentTouches[keyTouching];
            
        }
        
        //touch key touch added
        
        //THE DOCUMENTATION ON THIS WAS A BIT AMBIGUOUS SO IT MAY NOT WORK
        //my understanding is the id sent is a number between 0 and 2 respresenting where the new touch data should be sent
        
        else if ( m.getAddress() == "/touchkeys/add")
        {
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            
            TouchInfo recievedKey;
            
            recievedKey = currentTouches[keyTouching];
            
            
            
            if (m.getArgAsInt32(2) == 0)
            {
                recievedKey.locV1 = m.getArgAsFloat(3);
                recievedKey.size1 = m.getArgAsFloat(4);
            }
            if (m.getArgAsInt32(2) == 1)
            {
                recievedKey.locV2 = m.getArgAsFloat(3);
                recievedKey.size2 = m.getArgAsFloat(4);
            }
            if (m.getArgAsInt32(2) == 2)
            {
                recievedKey.locV3 = m.getArgAsFloat(3);
                recievedKey.size3 = m.getArgAsFloat(4);
            }
            recievedKey.locH = m.getArgAsFloat(5);
            
            recievedKey.count = m.getArgAsInt32(2);
            
            currentTouches[keyTouching] = recievedKey;
            
            //right now when key touch information is updated, redraw everything.  there are probably more efficient ways to refresh this part of the screen, but it's not a big hassle
            
            mustRedraw = true;
            
            
            
        }
        
        //touch key touch removed
        
        //THE DOCUMENTATION ON THIS WAS A BIT AMBIGIOUS SO IT MAY NOT WORK
        //my understanding is that the id sent is a number between 0 and 2 respresenting which touch was removed, this may be wrong.
        
        else if ( m.getAddress() == "/touchkeys/remove")
        {
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            
            TouchInfo recievedKey;
            
            recievedKey = currentTouches[keyTouching];
            
            
            if (m.getArgAsInt32(1) == 0)
            {
                recievedKey.locV1 = 0;
                recievedKey.size1 = 0;
            }
            if (m.getArgAsInt32(1) == 1)
            {
                recievedKey.locV2 = 0;
                recievedKey.size2 = 0;
            }
            if (m.getArgAsInt32(1) == 2)
            {
                recievedKey.locV3 = m.getArgAsFloat(5);
                recievedKey.size3 = m.getArgAsFloat(6);
            }
            
            recievedKey.count = m.getArgAsInt32(2);
            
            currentTouches[keyTouching] = recievedKey;
            
            //right now when key touch information is updated, redraw everything.  there are probably more efficient ways to refresh this part of the screen, but it's not a big hassle
            
            mustRedraw = true;
            
            
            
        }
        
        
        //touch key touch moved
        
        //THE DOCUMENTATION ON THIS WAS A BIT AMBIGIOUS SO IT MAY NOT WORK
        //my understanding is that the id sent is a number between 0 and 2 respresenting which touch was moved, this may be wrong.
        
        else if ( m.getAddress() == "/touchkeys/move")
        {
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            
            TouchInfo recievedKey;
            
            recievedKey = currentTouches[keyTouching];
            
            
            if (m.getArgAsInt32(1) == 0)
            {
                recievedKey.locV1 = m.getArgAsFloat(2);
                
            }
            if (m.getArgAsInt32(1) == 1)
            {
                recievedKey.locV2 = m.getArgAsFloat(2);
            }
            if (m.getArgAsInt32(1) == 2)
            {
                recievedKey.locV3 = m.getArgAsFloat(2);
            }
            
            recievedKey.count = m.getArgAsFloat(3);
            
            currentTouches[keyTouching] = recievedKey;
            
            //right now when key touch information is updated, redraw everything.  there are probably more efficient ways to refresh this part of the screen, but it's not a big hassle
            
            mustRedraw = true;
            
            
            
        }
        
        //touch key touch resized
        
        //THE DOCUMENTATION ON THIS WAS A BIT AMBIGIOUS SO IT MAY NOT WORK
        //my understanding is that the id sent is a number between 0 and 2 respresenting which touch was resized, this may be wrong.
        
        else if ( m.getAddress() == "/touchkeys/move")
        {
            int keyTouching = m.getArgAsInt32(0);
            keyTouching -= keyShift;
            
            TouchInfo recievedKey;
            
            recievedKey = currentTouches[keyTouching];
            
            
            if (m.getArgAsInt32(1) == 0)
            {
                recievedKey.size1 = m.getArgAsFloat(2);
                
            }
            if (m.getArgAsInt32(1) == 1)
            {
                recievedKey.size2 = m.getArgAsFloat(2);
            }
            if (m.getArgAsInt32(1) == 2)
            {
                recievedKey.size3 = m.getArgAsFloat(2);
            }
            
            currentTouches[keyTouching] = recievedKey;
            
            //right now when key touch information is updated, redraw everything.  there are probably more efficient ways to refresh this part of the screen, but it's not a big hassle
            
            mustRedraw = true;
            
            
        }
        
		//this is basically a "catch is we don't know what the message is, display some debug information"
        else{
			// unrecognized message: display on the bottom of the screen
			string msg_string;
			msg_string = m.getAddress();
			msg_string += ": ";
			for( int i=0; i<m.getNumArgs(); i++ ){
				// get the argument type
				msg_string += m.getArgTypeName( i );
				msg_string += ":";
				// display the argument - make sure we get the right type
				if( m.getArgType( i ) == OFXOSC_TYPE_INT32 )
					msg_string += ofToString( m.getArgAsInt32( i ) );
				else if( m.getArgType( i ) == OFXOSC_TYPE_FLOAT )
					msg_string += ofToString( m.getArgAsFloat( i ) );
				else if( m.getArgType( i ) == OFXOSC_TYPE_STRING )
					msg_string += m.getArgAsString( i );
				else
					msg_string += "unknown";
			}
			// add to the list of strings to display
			msg_strings[current_msg_string] = msg_string;
			timers[current_msg_string] = ofGetElapsedTimef() + 5.0f;
			current_msg_string = ( current_msg_string + 1 ) % NUM_MSG_STRINGS;
			// clear the next line
			msg_strings[current_msg_string] = "";
		}
	}	
    
}



//IMPORTANT:  Things are drawn over top of the existing screen, it doesn't redraw everything every time.  THe only time the whole screen will be redrawn is when mustRedraw is true.

//--------------------------------------------------------------
void testApp::draw(){
    
    //when the ip changing screen is up, since there's so little going on, just redraw everything every time, the lag is negligible
    if (changingIP == true)
    {
        
        ofSetColor(80, 80, 80);
        ofRect(0, 0, 1400, 2000);
        
        
        ofSetColor(225, 225, 225);
        verdana30.drawString("Current IP Sending To:", 85, 40);
        
        
        for (int i = 0; i < hostName.length(); i++)
        {
            
            if (i == numOnHost)
            {
                ofSetColor(255, 0, 0);
                
            }
            else
            {
                ofSetColor(225,225,225);
            }
            verdana30.drawString(hostName.substr(i, 1), i*30 + 500, 40);
            
        }
        
        ofSetColor(225,225,225);
        verdana30.drawString("Tap Numbers Below To Update IP", 245, 100);
        
        
        
        
        ofSetColor(225, 225, 225);
        verdana30.drawString("Current Port Sending To:", 220, 270);
        
        string portPrint = "";
        
        for (int i = 5; i > ofToString(portName).length(); i--)
        {
            portPrint += "0";
        }
        portPrint += ofToString(portName);
        for (int i = 0; i < portPrint.length(); i++)
        {
            
            if (i == numOnPort)
            {
                ofSetColor(255, 0, 0);
                
            }
            else
            {
                ofSetColor(225,225,225);
            }
            verdana30.drawString(portPrint.substr(i, 1), i*30 + 663, 270);
            
        }
        
        ofSetColor(225,225,225);
        verdana30.drawString("Tap Numbers Below To Update Port", 226, 330);
        
        
        ofSetColor(225, 225, 225);
        verdana30.drawString("Current Port Listening On:", 214, 500);
        
        string portPrintListen = "";
        
        for (int i = 5; i > ofToString(portNameListen).length(); i--)
        {
            portPrintListen += "0";
        }
        portPrintListen += ofToString(portNameListen);
        for (int i = 0; i < portPrintListen.length(); i++)
        {
            
            if (i == numOnPortListen)
            {
                ofSetColor(255, 0, 0);
                
            }
            else
            {
                ofSetColor(225,225,225);
            }
            verdana30.drawString(portPrintListen.substr(i, 1), i*30 + 671, 500);
            
        }
        
        ofSetColor(225,225,225);
        verdana30.drawString("Tap Numbers Below To Update Port", 226, 560);
        
        
        
        for (int i = 0; i < 10; i++)
        {
            
            ofSetColor(30, 30, 30);
            ofRect(i*86 + 10, 135, 70, 70);
            
            ofSetColor(225,225,225);
            verdana30.drawString(ofToString(i), i * 86 + 35, 180);
            
            
        }
        
        
        ofSetColor(30, 30, 30);
        ofRect(10*86 + 10, 135, 144, 70);
        
        ofSetColor(225,225,225);
        verdana30.drawString("Next",10 * 86 + 44, 180);
        
        
        for (int i = 0; i < 10; i++)
        {
            
            ofSetColor(30, 30, 30);
            ofRect(i*86 + 10, 365, 70, 70);
            
            ofSetColor(225,225,225);
            verdana30.drawString(ofToString(i), i * 86 + 35, 410);
            
            
        }
        
        
        ofSetColor(30, 30, 30);
        ofRect(10*86 + 10, 365, 144, 70);
        
        ofSetColor(225,225,225);
        verdana30.drawString("Next",10 * 86 + 44, 410);
        
        
        for (int i = 0; i < 10; i++)
        {
            
            ofSetColor(30, 30, 30);
            ofRect(i*86 + 10, 590, 70, 70);
            
            ofSetColor(225,225,225);
            verdana30.drawString(ofToString(i), i * 86 + 35, 640);
            
            
        }
        
        
        ofSetColor(30, 30, 30);
        ofRect(10*86 + 10, 590, 144, 70);
        
        ofSetColor(225,225,225);
        verdana30.drawString("Next",10 * 86 + 44, 640);
        
        
        
        ofFill();
        
        
        ofSetColor(50, 50, 50);
        
        ofRect(850, translateYCore + 5, 500, 1000);
        
        ofSetColor(255, 255, 255);
        
        
        ofDrawBitmapString("Confirm", 912, translateYCore + 33 );
        ofDrawBitmapString("IP", 931, translateYCore + 53 );
        
        
        
    }
    else if (mustRedraw == true)
    {
        
        mustRedraw = false;
        
        
        //clear the whole screen
        ofFill();
        ofSetColor(80, 80, 80);
        ofRect(-10, -10, 2000, 800);
        
        
        
        //redraw every key
        render();
        
        //this just calls each function which is in charge of drawing the relevant parts of the screen
        if (playMode == 3)
        {
            redrawCalibrateBar();
        }
        
        if (playMode == 0 || playMode == 1 || playMode == 2)
        {
            redrawTopBar();            
        }
        
        redrawBottomBar();
    }
    
}


//change the mode of the damper pedal.  this one goes by press and release, when you pick your finger up it stops damping
void testApp::changeDamp()
{
    
    if (damperPushed == false)
    {
        damperPushed = true;
        ofxOscMessage m;
        m.setAddress( "/pedal/damper" );
        m.addIntArg( 1 );
        sender.sendMessage( m );
    }
    else
    {
        damperPushed = false;
        ofxOscMessage m;
        m.setAddress( "/pedal/damper" );
        m.addIntArg( 0 );
        sender.sendMessage( m );
    }
    redrawTopBar();
}


//change the mode of the sos pedal.  this one goes by press and release, when you pick your finger up it stops damping
void testApp::changeSos()
{
    if (sosPushed == false)
    {
        sosPushed = true;
        ofxOscMessage m;
        m.setAddress( "/pedal/sostenuto" );
        m.addIntArg( 1 );
        sender.sendMessage( m );
    }
    else
    {
        sosPushed = false;
        ofxOscMessage m;
        m.setAddress( "/pedal/sostenuto" );
        m.addIntArg( 0 );
        sender.sendMessage( m );
    }
    redrawTopBar();
}


//the bottom bar tells you about what mode you are in and shows the IP address changing button, the toggle two way communication button, and the all notes on/off button
void testApp::redrawBottomBar()
{
    
    
    
    ofFill();
    
    
    ofSetColor(255, 255, 255);
    barBottom.draw(-10, translateYCore + 5, 2000, 75);
    
    if (playMode == 0)
    {
        ofDrawBitmapString("Currently in play mode. Tap and drag fingers along keys to play.", 288, 720);
        ofDrawBitmapString("Pink keys are being touched on the iPad, circles represent touch data.", 288, 735);
        ofDrawBitmapString("The shade of green represents key pressure on the MRP.", 288, 750);
    }
    else if (playMode == 1)
    {
        ofDrawBitmapString("Currently in move mode. Tap and drag fingers to move keyboard.", 288, 720);
        ofDrawBitmapString("Pinch to zoom in and out of keys.", 288, 735);
        ofDrawBitmapString("Double tap to fit entire keyboard on screen and center.", 288, 750);
    }
    else if (playMode == 2)
    {
        ofDrawBitmapString("Currently in observe mode.", 288, 720);
        ofDrawBitmapString("Circles represent touch key touch data.", 288, 735);
        ofDrawBitmapString("The shade of green represents key pressure on the MRP.", 288, 750);        
    }
    else if (playMode == 3)
    {
        ofDrawBitmapString("Currently in calibrate mode. Tap a key on the iPad or piano.", 288, 720);
        ofDrawBitmapString("The blue key is the one currently selected.", 288, 735);
        ofDrawBitmapString("Phase and volume of notes can be edited by dragging the sliders.", 288, 750);
    }
    ofDrawBitmapString("Ryan Daugherty's MRPConnect Piano.  10 finger limit", 288, 765);
    
    
    ofFill();
    
    ofSetColor(255, 255, 255);
    changeIpButton.draw(850, translateYCore+10, 170, 58);
    ofDrawBitmapString("Change", 915, translateYCore + 33 );
    ofDrawBitmapString("IP", 930, translateYCore + 53 );
    
    
    ofSetColor(255, 255, 255);
    changeIpButton.draw(3, translateYCore+10, 170, 58);
    if (displayIncoming == true)
    {
        ofDrawBitmapString("Hide", 75, translateYCore + 33 );
        ofDrawBitmapString("Keytouches", 54, translateYCore + 53 );
    }
    else
    {
        ofDrawBitmapString("Show", 75, translateYCore + 33 );
        ofDrawBitmapString("Keytouches", 54, translateYCore + 53 );
    }
    
    ofSetColor(255, 255, 255);
    changeIpButton.draw(187, translateYCore+10, 88, 58);
    
    ofDrawBitmapString("All Notes", 195, translateYCore + 33 );
    ofDrawBitmapString("Off", 219, translateYCore + 53 );
    
    
}


//the top bar displays buttons for patch number, damp and sos pedals, changing the number of rows, and a slider for global volume
void testApp::redrawTopBar()
{
    
    //when drawing images, set color as pure white to make the actual image appear
    ofSetColor(255, 255, 255);    
    ofEnableAlphaBlending();
    
    
    if (damperPushed == true)
    {
        pedalPushedSymbol.draw(760, 7);
    }
    else
    {
        pedalUnpushedSymbol.draw(760, 7);
    }
    verdana30.drawString("Damp", 774, 67);
    
    if (sosPushed == true)
    {
        pedalPushedSymbol.draw(899, 7);
    }
    else
    {
        pedalUnpushedSymbol.draw(899, 7);
    }
    verdana30.drawString("Sos", 930, 67);
    
    
    
    patchSymbol.draw(515, 24);
    patchSymbol.draw(661, 24);
    patchSymbol.draw(588, 24);
    verdana30.drawString("-", 545, 67);
    verdana30.drawString("+", 684, 67);
    if (patchNum < 10)
    {
        verdana30.drawString(ofToString(patchNum), 615, 67);
    }
    else if (patchNum < 100)
    {
        verdana30.drawString(ofToString(patchNum), 604, 67);
    }
    else
    {
        verdana30.drawString(ofToString(patchNum), 593, 67);
    }
    
    
    globalVolume.draw(7, 7);
    verdana30.drawString("Global Volume", 23, 45);
    
    ofImage blueTip;
    blueTip.loadImage("sliderbluetip.png");
    ofImage whiteTip;
    whiteTip.loadImage("sliderwhitetip.png");
    ofImage blueBar;
    blueBar.loadImage("sliderbluebar.png");
    ofImage whiteBar;
    whiteBar.loadImage("sliderwhitebar.png");
    ofImage ball;
    ball.loadImage("slidercircle.png");
    
    
    blueTip.draw(volumeBarShift-5, volumeBarTop);
    whiteBar.draw(volumeBarShift, volumeBarTop, 240, 9);
    whiteTip.draw(volumeBarShift + 240, volumeBarTop);
    blueBar.draw(volumeBarShift, volumeBarTop, globalVol, 9);
    if (globalVol > 120)
    {
        blueBar.draw(volumeBarShift + 118, volumeBarTop - 5, 4, 19);
    }
    else
    {                
        whiteBar.draw(volumeBarShift + 118, volumeBarTop - 5, 4, 19);
    }
    ball.draw(volumeBarShift+globalVol - 11, volumeBarTop - 12 + 5);
    
    
    rowNum.draw(295, 7);
    if (twoRows == true)
    {
        verdana30.drawString("Show", 350, 45);
        verdana30.drawString("One Row", 320, 85);
    }
    else
    {
        verdana30.drawString("Show", 350, 45);
        verdana30.drawString("Two Rows", 311, 85);
    }
    
    
    ofDisableAlphaBlending();
}

//calibrate bar has the window, key title, and sliders for phase and volume
void testApp::redrawCalibrateBar()
{
    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255);
    
    
    messageWindow.draw(80, 7);
    verdana30.drawString(calibrateKeyTitle, 91, 45);
    
    
    if (calibrateKeyHighlighted != -1)
    {
        verdana30.drawString("Phase", 90, 85);
        verdana30.drawString("Volume", 90, 145);
        
        ofImage blueTip;
        blueTip.loadImage("sliderbluetip.png");
        ofImage whiteTip;
        whiteTip.loadImage("sliderwhitetip.png");
        ofImage blueBar;
        blueBar.loadImage("sliderbluebar.png");
        ofImage whiteBar;
        whiteBar.loadImage("sliderwhitebar.png");
        ofImage ball;
        ball.loadImage("slidercircle.png");
        
        
        blueTip.draw(barSideShift-5, slider1Top);
        whiteBar.draw(barSideShift, slider1Top, 800, 9);
        whiteTip.draw(barSideShift + 800, slider1Top);
        blueBar.draw(barSideShift, slider1Top, sliderVal1[calibrateKeyHighlighted], 9);
        ball.draw(barSideShift+sliderVal1[calibrateKeyHighlighted] - 11, slider1Top - 12 + 5);
        
        
        if (sliderVal2[calibrateKeyHighlighted] > 400)
        {
            blueBar.draw(barSideShift + 398, slider2Top - 5, 4, 19);
        }
        else
        {                    
            whiteBar.draw(barSideShift + 398, slider2Top - 5, 4, 19);
        }
        
        
        blueTip.draw(barSideShift - 5, slider2Top);
        whiteBar.draw(barSideShift, slider2Top, 800, 9);
        whiteTip.draw(barSideShift + 800, slider2Top);
        blueBar.draw(barSideShift, slider2Top, sliderVal2[calibrateKeyHighlighted], 9);
        
        
        if (sliderVal2[calibrateKeyHighlighted] > 400)
        {
            blueBar.draw(barSideShift + 398, slider2Top - 5, 4, 19);
            
        }
        else
        {                    
            whiteBar.draw(barSideShift + 398, slider2Top - 5, 4, 19);
        }
        
        ball.draw(barSideShift+sliderVal2[calibrateKeyHighlighted] - 11, slider2Top - 12 + 5);
        
        
    }
    
    
    ofDisableAlphaBlending();
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}


//any time a new touch is made
//--------------------------------------------------------------
//how touchevents work:  you can access touch.x and touch.y which are position.  touch.id is an identifier used based on the other of fingers touched.  first touched is 0, second is 1, third is 2, etc.  Say you removed the second finger while keeping the first and third on, and then placed another finger, that would be 1, not 3.
void testApp::touchDown(ofTouchEventArgs &touch){
    
    
    numFingersTouching++;
    
    if (numFingersTouching <= TOUCHLIMIT)
    {
        
        fingerX[touch.id] = touch.x;
        fingerY[touch.id] = touch.y;
        
        //if the screen for changing any network information is open
        if (changingIP == true)
        {
            //touching a button for changing the IP address
            if (touch.y >= 135 & touch.y <= 205)
            {
                for (int i = 0; i < 10; i++)
                {
                    if ( touch.x >= i*86 + 10 && touch.x <= i*86 + 80)
                    {
                        mustRedraw = true;
                        
                        string newHostName;
                        
                        newHostName = hostName.substr(0, numOnHost);
                        
                        newHostName += ofToString(i);
                        
                        newHostName += hostName.substr(numOnHost+1);
                        
                        hostName = newHostName;
                        
                        numOnHost++;
                        
                        if (numOnHost == 3)
                        {
                            numOnHost++;
                        }
                        if (numOnHost == 7)
                        {
                            numOnHost++;
                        }
                        if (numOnHost == 11)
                        {
                            numOnHost++;
                        }
                        if (numOnHost == 15)
                        {
                            numOnHost = 0;
                        }
                        break;
                    }
                    
                }
                
                
                
                if (touch.x >= 10*86 + 10 && touch.x <= 10*86 + 154)
                {
                    mustRedraw = true;
                    
                    numOnHost++;
                    
                    if (numOnHost == 3)
                    {
                        numOnHost++;
                    }
                    if (numOnHost == 7)
                    {
                        numOnHost++;
                    }
                    if (numOnHost == 11)
                    {
                        numOnHost++;
                    }
                    if (numOnHost == 15)
                    {
                        numOnHost = 0;
                    }
                    
                }
                
            }
            //changing a number on the port to send to
            if (touch.y >= 365 && touch.y <= 435)
            {
                
                
                
                for (int i = 0; i < 10; i++)
                {
                    
                    
                    if ( touch.x >= i*86 + 10 && touch.x <= i*86 + 80)
                    {
                        
                        mustRedraw = true;
                        
                        
                        int newPort;
                        
                        newPort = (int)(portName/(int)(pow(10.0, 5-(int)numOnPort)));
                        
                        newPort *= (int)pow(10.0, 5-(int)numOnPort);
                        
                        newPort += i * (pow(10.0, 4-(int)numOnPort));
                        
                        
                        newPort += (int)(portName%(int)(pow(10.0, 4-(int)numOnPort)));
                        
                        
                        portName = newPort;
                        
                        numOnPort++;                    
                        if (numOnPort == 5)
                        {
                            numOnPort = 0;
                        }
                        
                        break;
                        
                    }
                    
                }
                if (touch.x >= 10*86 + 10 && touch.x <= 10*86 + 154)
                {
                    
                    mustRedraw = true;
                    
                    
                    numOnPort++;                    
                    if (numOnPort == 5)
                    {
                        numOnPort = 0;
                    }
                    
                }
                
            }
            
            
            //touching a button to change the port to listen on
            if (touch.y >= 595 && touch.y <= 665)
            {
                for (int i = 0; i < 10; i++)
                {
                    if ( touch.x >= i*86 + 10 && touch.x <= i*86 + 80)
                    {
                        
                        mustRedraw = true;
                        
                        
                        int newPort;
                        
                        newPort = (int)(portNameListen/(int)(pow(10.0, 5-(int)numOnPortListen)));
                        
                        newPort *= (int)pow(10.0, 5-(int)numOnPortListen);
                        
                        newPort += i * (pow(10.0, 4-(int)numOnPortListen));
                        
                        
                        newPort += (int)(portNameListen%(int)(pow(10.0, 4-(int)numOnPortListen)));
                        
                        
                        portNameListen = newPort;
                        
                        numOnPortListen++;                    
                        if (numOnPortListen == 5)
                        {
                            numOnPortListen = 0;
                        }
                        
                        break;
                        
                    }
                    
                }
                if (touch.x >= 10*86 + 10 && touch.x <= 10*86 + 154)
                {
                    
                    mustRedraw = true;
                    
                    
                    numOnPortListen++;                    
                    if (numOnPortListen == 5)
                    {
                        numOnPortListen = 0;
                    }
                    
                }
                
            }
            
            
            //exiting IP changing mode
            if (touch.y > translateYCore + 5 && numFingersTouching == 1)
            {
                
                if (touch.x < 700)
                {
                }
                else
                {
                    
                    mustRedraw = true;
                    
                    
                    removeLeadZero();
                    sender.setup(hostName, portName);
                    receiver.setup(portNameListen);
                    changingIP = !changingIP;
                    switchFingerTouching = true;
                }
            }
        }
        
        
        //the changing ip screen is not up
        else
        {
            
            if (playMode == 0 || playMode == 1 || playMode == 2)
            {
                
                //touching the change row numbers button
                if (touch.y >= 0 && touch.y <= 110 && touch.x >= 292 && touch.x <= 488  && numFingersTouching == 1 && switchFingerTouching == false)
                {
                    
                    mustRedraw = true;
                    
                    twoRows = !twoRows;
                    switchFingerTouching = true;
                    center();
                    
                }
                
                //touching the damp pedal
                else if (touch.y >= 0 && touch.y <= 110 && touch.x >= 759 && touch.x <= 760+119+10 && switchFingerTouching == false)
                {
                    
                    fingerDamp = touch.id;
                    changeDamp();
                    
                }
                //touching the sos pedal
                else if (touch.y >= 0 && touch.y <= 110 && touch.x >= 760+120+10 && touch.x <= 1020 && switchFingerTouching == false)
                {
                    
                    fingerSos = touch.id;
                    changeSos();
                    
                }
                //touching the patch - button
                else if (touch.y >= 17 && touch.y <= 93 && touch.x >= 510 && touch.x <= 591 && numFingersTouching == 1 && switchFingerTouching == false)
                {
                    switchFingerTouching = true;
                    
                    
                    ofxOscMessage m;
                    m.setAddress( "/mrp/ui/patch/down" );
                    m.addFloatArg(1);
                    
                    sender.sendMessage( m );
                    
                    //dont actually redraw until you get the message back in update()
                    
                    
                }
                //touching the patch + button
                else if (touch.y >= 17 && touch.y <= 93 && touch.x >= 664 && touch.x <= 746 && numFingersTouching == 1 && switchFingerTouching == false)
                {
                    switchFingerTouching = true;
                    
                    
                    
                    ofxOscMessage m;
                    m.setAddress( "/mrp/ui/patch/up" );
                    m.addFloatArg(1);
                    
                    sender.sendMessage( m );
                    
                    //dont actually redraw until you get the message back in update()                    
                    
                }
                //touching the global volume slider
                else if (touch.x >= volumeBarShift - 15 && touch.x <= 15 + 240 + volumeBarShift && touch.y >= volumeBarTop - 26 + 5 && touch.y <= volumeBarTop + 22 + 5 && fingerVolumeTouching == -1  && switchFingerTouching == false)
                {
                    
                    
                    fingerVolumeTouching = touch.id;
                    
                    globalVol = touch.x - volumeBarShift;
                    
                    if (globalVol < 0)
                    {
                        globalVol = 0;
                    }
                    if (globalVol > 240)
                    {
                        globalVol = 240;
                    }
                    
                    ofxOscMessage m;
                    m.setAddress( "/mrp/midi" );
                    m.addFloatArg((float)globalVol/240.0);
                    
                    sender.sendMessage( m );
                    
                    redrawTopBar();
                    
                    switchFingerTouching = true;
                    
                }
            }
            
            //this is if the user is touching something on the bottom bar
            if (touch.y > translateY && numFingersTouching == 1 && switchFingerTouching == false)
            {
                //changing whether or not incoming data should be displayed
                if (touch.x <= 180)
                {
                    //this may be changed, there are probably more efficient ways to display or hide ALL keytouch info
                    
                    mustRedraw = true;
                    
                    displayIncoming = !displayIncoming;
                    switchFingerTouching = true;
                }
                
                //send a "all notes off" message to the piano
                if (touch.x <= 272)
                {
                    
                    //this may be changed, there are probably more efficient ways to display or hide ALL keytouch info
                    
                    switchFingerTouching = true;
                    
                    ofxOscMessage m;
                    m.setAddress( "/ui/allnotesoff" );
                    m.addIntArg(1);
                    sender.sendMessage( m );
                    
                    mustRedraw = true;
                }
                
                //changing the mode.  order is play mode -> move mode -> observe mode -> calibrate mode -> play mode
                else if (touch.x < 850)
                {
                    playMode ++;
                    if (playMode > 3)
                    {
                        playMode = 0;
                        mustRedraw = true;
                    }
                    
                    if (playMode == 3)
                    {
                        mustRedraw = true;
                    }
                    redrawBottomBar();
                    switchFingerTouching = true;
                }
                //changing to the change IP screen
                else
                {
                    mustRedraw = true;
                    
                    addLeadZero();
                    changingIP = !changingIP;
                    switchFingerTouching = true;
                }
                
            }
            //the user is touching somewhere in the "main" area, most likely the piano
            else
            {
                
                //this is just collecting information about touch points in case someone is pinching or dragging, must be in move mode
                if (playMode == 1 && switchFingerTouching == false)
                {
                    
                    if (touch.id == 0)
                    {
                        
                        drag1valid = true;
                        drag1.x = touch.x;
                        drag1.y = touch.y;
                        
                        drag1current.x = touch.x;
                        drag1current.y = touch.y;
                        
                    }
                    
                    if (touch.id == 1)
                    {
                        
                        drag2valid = true;
                        drag2.x = touch.x;
                        drag2.y = touch.y;
                        
                        drag2current.x = touch.x;
                        drag2current.y = touch.y;
                        
                    }
                    
                    
                    //if two fingers are down, someone is probably pinching, so find the centerpoint of the pinch and find the current sizeFactor.  The scaled size with be based on this
                    if (drag1valid == true && drag2valid == true)
                    {
                        
                        coreSizeFactor = sizeFactor;
                        pinching = true;
                        pinchCenterX = floor((drag1current.x + drag2current.x)/2);
                        pinchCenterY = floor((drag1current.y + drag2current.y)/2);
                        
                        difX = pinchCenterX - translateXCore;
                        
                    }
                    //someone's probably about to start dragging
                    if (numFingersTouching == 1)
                    {
                        
                        sideShiftCoreX = translateXCore;
                        
                        centerX = touch.x;
                        centerY = touch.y;
                        
                    }
                }
                
                //if you're in play mode and aren't currently doing anything else that would prevent you from touching a key
                else if (playMode == 0 && switchFingerTouching == false && touch.id != fingerSos && touch.id != fingerDamp)
                {
                    
                    //-1 means no key touched
                    fingerTouching[touch.id] = detectKey(touch.x, touch.y);
                    
                    
                    //if a key was touched
                    if (fingerTouching[touch.id] != -1)
                    {
                        
                        //if this one wasn't already touched, send all information about initiating a key press, light it, etc
                        if (keyLit[fingerTouching[touch.id]] == false)
                        {
                            
                            keyLit[fingerTouching[touch.id]] = true;
                            
                            
                            ofxOscMessage m;
                            m.setAddress( "/mrp/midi" );
                            m.addIntArg(144);
                            m.addIntArg(fingerTouching[touch.id] + keyShift);
                            m.addIntArg(127);
                            sender.sendMessage( m );
                            
                            
                            touchWithinKey(fingerTouching[touch.id]);
                            renderSpecific(fingerTouching[touch.id]);
                            redrawTopBar();
                            
                        }
                        //otherwise, just get information about fingers within key
                        else
                        {
                            touchWithinKey(fingerTouching[touch.id]);
                        }
                        
                    }
                    
                    
                }
                //if your in calibrate mode and this is the only finger touching
                else if (playMode == 3 && numFingersTouching == 1  && switchFingerTouching == false)
                {
                    
                    //touched phase slider
                    if (touch.x >= barSideShift - 15 && touch.x <= barSideShift + 800 + 15 && touch.y >= slider1Top - 26 + 5 && touch.y <= slider1Top + 22 + 5 && fingerSlide1Touching == -1 && calibrateKeyHighlighted != -1)
                    {
                        
                        fingerSlide1Touching = touch.id;
                        
                        
                        
                        sliderVal1[calibrateKeyHighlighted] = touch.x - barSideShift;
                        if (sliderVal1[calibrateKeyHighlighted] < 0)
                        {
                            sliderVal1[calibrateKeyHighlighted] = 0;
                        }
                        if (sliderVal1[calibrateKeyHighlighted] > 800)
                        {
                            sliderVal1[calibrateKeyHighlighted] = 800;
                        }
                        
                        
                        
                        ofxOscMessage m;
                        m.setAddress( "/mrp/ui/cal/phase" );
                        m.addFloatArg((float)sliderVal1[calibrateKeyHighlighted]/800.0);
                        
                        sender.sendMessage( m );
                        
                        
                        redrawCalibrateBar();
                        
                    }
                    
                    
                    //touched volume slider
                    else if (touch.x >= barSideShift - 15 && touch.x <= barSideShift + 800 + 15 && touch.y >= slider2Top - 26 + 5 && touch.y <= slider2Top + 22 + 5 && fingerSlide2Touching == -1 && calibrateKeyHighlighted != -1)
                    {
                        
                        fingerSlide2Touching = touch.id;
                        
                        
                        sliderVal2[calibrateKeyHighlighted] = touch.x - barSideShift;
                        if (sliderVal2[calibrateKeyHighlighted] < 0)
                        {
                            
                            sliderVal2[calibrateKeyHighlighted] = 0;
                            
                        }
                        
                        if (sliderVal2[calibrateKeyHighlighted] > 800)
                        {
                            
                            sliderVal2[calibrateKeyHighlighted] = 800;
                            
                        }
                        
                        
                        ofxOscMessage m;
                        m.setAddress( "/mrp/ui/cal/volume" );
                        m.addFloatArg((float)sliderVal2[calibrateKeyHighlighted]/800.0);
                        
                        sender.sendMessage( m );
                        
                        redrawCalibrateBar();
                        
                        
                    }
                    
                    //touched a key
                    else
                    {
                        
                        int pastNum = calibrateKeyHighlighted;
                        
                        fingerTouching[touch.id] = detectKey(touch.x, touch.y);
                        
                        
                        //a different key was touched to calibrate
                        if (fingerTouching[touch.id] != -1)
                        {
                            
                            calibrateKeyHighlighted = fingerTouching[touch.id];
                            calibrateKeyTitle = getTitle(fingerTouching[touch.id]);
                            
                            
                            renderSpecific(pastNum);
                            renderSpecific(fingerTouching[touch.id]);
                            redrawCalibrateBar();
                            
                        }
                    }
                }
            }
        }
    }
}


//this looks at which fingers are touching a certain key and sends out information over OSC about the touches on that particular key
void testApp::touchWithinKey(int keyCompare)
{
    
    keyDimensions dimCompare;
    getDimensions(keyCompare, dimCompare);
    
    //up to three fingers to a key
    int fingersFound = 0;
    int fingerIn[3];
    
    
    for (int i = 0; i < 3; i++)
    {
        fingerIn[i] = -1;
    }
    
    
    for (int i = 0; i < TOUCHLIMIT; i ++)
    {
        
        if (fingerTouching[i] == keyCompare)
        {
            fingerIn[fingersFound] = i; 
            fingersFound++;
            
        }
        if (fingersFound >= 3)
        {
            break;
        }
        
    }
    
    //sort them be verticle position
    int sortOrder = 0;
    while (sortOrder < fingersFound-1)
    {
        if (fingerY[fingerIn[sortOrder]] < fingerY[fingerIn[sortOrder+1]] )
        {
            int spareNum = fingerIn[sortOrder];
            
            fingerIn[sortOrder] = fingerIn[sortOrder+1];
            
            fingerIn[sortOrder+1] = spareNum;
            
            sortOrder = -1;
        }
        sortOrder++;
    }
    
    //say which key is touched
    ofxOscMessage m;
    m.setAddress( "/touchkeys/raw" );
    m.addIntArg(keyCompare + keyShift);
    
    
    
    
    //go through all the touches and calculate the verticle positions proportional to the height of a key
    for (int i = 0; i < 3; i++)
    {
        
        if (fingerIn[i] == -1)
        {
            m.addFloatArg(-1.0);
            m.addFloatArg(1.0);
        }
        else
        {
            float yPos;
            
            yPos = fingerY[fingerIn[i]] - dimCompare.topY;
            yPos = yPos / (dimCompare.bottomY - dimCompare.topY);
            
            yPos = 1 - yPos;
            
            if (yPos < 0)
            {
                yPos = 0;
            }
            if (yPos > 1)
            {
                yPos = 1;
            }
            
            
            m.addFloatArg(yPos);
            m.addFloatArg(1.0);
        }
        
    }
    
    
    if(keyShape(keyCompare) >= 0)//white key can have a single horizontal component as well
    {
    
        
        float xPos;
        
        xPos = fingerX[fingerIn[0]] - dimCompare.leftX;
        xPos = xPos / (dimCompare.rightX - dimCompare.leftX);
        
        
        if (xPos < 0)
        {
            xPos = 0;
        }
        if (xPos > 1)
        {
            xPos = 1;
        }
        
        
        m.addFloatArg(xPos);
        
    }
    else
    {
        
        m.addFloatArg(-1.0);
    }
    sender.sendMessage( m );
}


//--------------------------------------------------------------
//whenever a touch that is already down is moved
//how touchevents work:  you can access touch.x and touch.y which are position.  touch.id is an identifier used based on the other of fingers touched.  first touched is 0, second is 1, third is 2, etc.  Say you removed the second finger while keeping the first and third on, and then placed another finger, that would be 1, not 3.
void testApp::touchMoved(ofTouchEventArgs &touch)
{
 //if that finger was touching a pedal, you dont care if it moves   
    if (touch.id == fingerSos || touch.id == fingerDamp)
    {
        
    }
    else
    {
        if (numFingersTouching <= 10)
        {
            
            fingerX[touch.id] = touch.x;
            fingerY[touch.id] = touch.y;
            
            
            //you dont care about moving if your changing ip info
            if (changingIP == true)
            {
                
                if (switchFingerTouching == true)
                {
                }
                else
                {
                }
                
            }
            else
            {
                
                //sliding the finger that is moving the global volume slider
                if (fingerVolumeTouching == touch.id)
                {
                    
                    globalVol = touch.x - volumeBarShift;
                    
                    if (globalVol < 0)
                    {
                        globalVol = 0;
                    }
                    if (globalVol > 240)
                    {
                        globalVol = 240;
                    }
                    
                    
                    ofxOscMessage m;
                    m.setAddress( "/mrp/midi" );
                    m.addFloatArg((float)globalVol/240.0);
                    
                    sender.sendMessage( m );
                    
                    redrawTopBar();
                    
                }
                //drag/pinch info
                else if (playMode == 1)
                {
                    
                    if (touch.id == 0)
                    {
                        drag1current.x = touch.x;
                        drag1current.y = touch.y;
                    }
                    if (touch.id == 1)
                    {
                        drag2current.x = touch.x;
                        drag2current.y = touch.y;
                    }
                    //pinching
                    if (drag1valid == true && drag2valid == true && numFingersTouching == 2 && switchFingerTouching == false)
                    {
                        
                        rescale();
                        mustRedraw = true;
                        
                    }
                    
                    //dragging
                    if (numFingersTouching == 1 && pinching == false && switchFingerTouching == false)
                    {
                        
                        translateXCore = sideShiftCoreX - (centerX - touch.x);
                        mustRedraw = true;
                        
                    }
                }
                //if you move a finger while in play mode
                else if (playMode == 0 && switchFingerTouching == false)
                {
                    
                    
                    if (fingerTouching[touch.id] != -1 && detectSpecificKey(touch.x, touch.y, fingerTouching[touch.id]) )
                    {
                        //send a touch moved within same key note
                        
                        touchWithinKey(fingerTouching[touch.id]);
                    }
                    else
                    {
                        
                        int keyNowTouching = detectKey(touch.x, touch.y);
                        
                        //moved from one key to a space that isn't a key
                        if (keyNowTouching == -1 && fingerTouching[touch.id] != -1)
                        {
                            
                            keyLit[fingerTouching[touch.id]] = false;
                            
                            ofxOscMessage m;
                            m.setAddress( "/mrp/midi" );
                            m.addIntArg(128);
                            m.addIntArg(fingerTouching[touch.id] + keyShift);
                            m.addIntArg(127);
                            
                            sender.sendMessage( m );

                            touchWithinKey(fingerTouching[touch.id]);                            
                            
                            renderSpecific(fingerTouching[touch.id]);
                            redrawTopBar();
                            
                            
                            fingerTouching[touch.id] = -1;
                            
                        }
                        else
                        {
                            
                            //moved from one key to another
                            if (fingerTouching[touch.id] != -1)
                            {
                                
                                bool keyStillTouched = false;
                                
                                for (int i = 0; i < TOUCHLIMIT; i++)
                                {
                                    if (fingerTouching[i] == fingerTouching[touch.id] && i != touch.id)
                                    {
                                        keyStillTouched = true;
                                    }
                                }
                                //turn a note off if it doesnt have any other fingers on it
                                if (keyStillTouched == false)
                                {
                                    
                                    keyLit[fingerTouching[touch.id]] = false;
                                    
                                    ofxOscMessage m;
                                    m.setAddress( "/mrp/midi" );
                                    m.addIntArg(128);
                                    m.addIntArg(fingerTouching[touch.id] + keyShift);
                                    m.addIntArg(127);
                                    
                                    sender.sendMessage( m );
                                    
                                    touchWithinKey(fingerTouching[touch.id]);
                                    
                                    renderSpecific(fingerTouching[touch.id]);
                                    redrawTopBar();
                                    
                                }
                                
                            }
                            fingerTouching[touch.id] = keyNowTouching;
                            
                            bool newKeyAlreadyTouched = false;
                            
                            for (int i = 0; i < TOUCHLIMIT; i++)
                            {
                                if (fingerTouching[i] == fingerTouching[touch.id] && i != touch.id)
                                {
                                    newKeyAlreadyTouched = true;
                                }
                            }
                            //light the new key
                            if (newKeyAlreadyTouched == false && keyNowTouching != -1)
                            {
                                
                                ofxOscMessage m;
                                m.setAddress( "/mrp/midi" );
                                m.addIntArg(144);
                                m.addIntArg(fingerTouching[touch.id] + keyShift);
                                m.addIntArg(127);
                                
                                sender.sendMessage( m );
                                
                                keyLit[keyNowTouching] = true;
                                
                                touchWithinKey(fingerTouching[touch.id]);
                                
                                renderSpecific(fingerTouching[touch.id]);
                                redrawTopBar();
                                
                            }
                            else
                            {
                            }
                        }  
                    }
                }
                //if you moved in calibrate mode
                else if (playMode == 3 && numFingersTouching == 1 && switchFingerTouching == false)
                {
                    
                    
                    if (fingerSlide1Touching != -1)
                    {
                        //sliding the finger thats changing phase in calibrate mode
                        if (touch.id == fingerSlide1Touching)
                        {
                            
                            sliderVal1[calibrateKeyHighlighted] = touch.x - barSideShift;
                            if (sliderVal1[calibrateKeyHighlighted] < 0)
                            {
                                sliderVal1[calibrateKeyHighlighted] = 0;                                
                            }
                            
                            if (sliderVal1[calibrateKeyHighlighted] > 800)
                            {
                                sliderVal1[calibrateKeyHighlighted] = 800;                                
                            }
                            
                            ofxOscMessage m;
                            m.setAddress( "/mrp/ui/cal/phase" );
                            m.addFloatArg((float)sliderVal1[calibrateKeyHighlighted]/800.0);
                            
                            sender.sendMessage( m );
                            
                            redrawCalibrateBar();
                        }
                    }
                    
                    else if (fingerSlide2Touching != -1)
                    {
                        //sliding the finger thats changing the volume in calibrate mode    
                        if (touch.id == fingerSlide2Touching)
                        {
                            
                            sliderVal2[calibrateKeyHighlighted] = touch.x - barSideShift;
                            if (sliderVal2[calibrateKeyHighlighted] < 0)
                            {
                                sliderVal2[calibrateKeyHighlighted] = 0;
                            }
                            if (sliderVal2[calibrateKeyHighlighted] > 800)
                            {
                                sliderVal2[calibrateKeyHighlighted] = 800;
                            }
                            
                            
                            ofxOscMessage m;
                            m.setAddress( "/mrp/ui/cal/volume" );
                            m.addFloatArg((float)sliderVal2[calibrateKeyHighlighted]/800.0);
                            
                            sender.sendMessage( m );
                            
                            redrawCalibrateBar();
                        }
                    }
                    //you may be dragging onto a different key
                    else
                    {
                        
                        int pastNum = calibrateKeyHighlighted;
                        
                        fingerTouching[touch.id] = detectKey(touch.x, touch.y);
                        
                        //moved onto a new calibrate key
                        if (fingerTouching[touch.id] != -1)
                        {
                            
                            calibrateKeyHighlighted = fingerTouching[touch.id];
                            calibrateKeyTitle = getTitle(fingerTouching[touch.id]);
                            
                            renderSpecific(pastNum);
                            renderSpecific(fingerTouching[touch.id]);
                            redrawCalibrateBar();
                        }
                    }
                }
            }
        }
    } 
}

//--------------------------------------------------------------
//when a touch that is on the ipad is removeds
//how touchevents work:  you can access touch.x and touch.y which are position.  touch.id is an identifier used based on the other of fingers touched.  first touched is 0, second is 1, third is 2, etc.  Say you removed the second finger while keeping the first and third on, and then placed another finger, that would be 1, not 3.
void testApp::touchUp(ofTouchEventArgs &touch)
{
    
    numFingersTouching--;
    
    if (numFingersTouching <= 10)
    {
        
        if (numFingersTouching == 0)
        {
            switchFingerTouching = false;
        }
        
        else if (touch.id == fingerDamp)
        {
            fingerDamp =-1;
            changeDamp();
        }
        else if (touch.id == fingerSos)
        {
            fingerSos = -1;
        }
        else
        {
            //if the finger dragging the global volume slider was released
            if (fingerVolumeTouching == touch.id)
            {
                fingerVolumeTouching = -1;   
            }
            if (playMode == 1)
            {
                
            }
            //if the finger dragging a calibration slider was released
            else if (playMode == 3 && switchFingerTouching == false)
            {
                
                if (fingerSlide1Touching == touch.id)
                {
                    fingerSlide1Touching = -1;
                }
                if (fingerSlide2Touching == touch.id)
                {
                    fingerSlide2Touching = -1;
                }
                fingerTouching[touch.id] = -1;
            }
            else if (playMode == 0 && switchFingerTouching == false)
            {
                
                //released a key that's pressed
                if (fingerTouching[touch.id] != -1)
                {
                    
                    touchWithinKey(fingerTouching[touch.id]);
                    
                    //check if another finger is touching it
                    bool keyStillTouched = false;
                    for (int i = 0; i < TOUCHLIMIT; i++)
                    {
                        if (fingerTouching[i] == fingerTouching[touch.id] && i != touch.id)
                        {
                            keyStillTouched = true;
                        }
                    }
                    if (keyStillTouched == false)
                    {
                        keyLit[fingerTouching[touch.id]] = false;
                        
                        ofxOscMessage m;
                        m.setAddress( "/mrp/midi" );
                        m.addIntArg(128);
                        m.addIntArg(fingerTouching[touch.id] + keyShift);
                        m.addIntArg(127);
                        
                        sender.sendMessage( m );
                        
                        renderSpecific(fingerTouching[touch.id]);
                        redrawTopBar();
                        
                    }                    
                    fingerTouching[touch.id] = -1;
                    
                }
            }
        }
        
    }
    
    fingerX[touch.id] = -1;
    fingerY[touch.id] = -1;
    
    
    //if the player was pinching, make sure it doesn't think they are any more
    if (playMode == 1)
    {
        
        if (touch.id == 0)
        {            
            drag1valid = false;
        }
        
        if (touch.id == 1)
        {
            
            drag2valid = false;
            
        }
        if (drag1valid == false && drag2valid == false)
        {
            pinching = false;
        }
    }
}



//resize everything to fit the screen and center it
void testApp::center()
{
    
    if (twoRows == true)
    {
        sizeFactor = 36;
        
        translateXCore =  (1024/2) - ((26 *( sizeFactor * 1.1))/2 ) ;
        
    }
    else
    {
        sizeFactor = 18;
        
        translateXCore =  (1024/2) - ((52 *( sizeFactor * 1.1))/2 ) ;
    }
    
    
    
    // Display dimensions, normalized to the width of one white key
    
    kWhiteKeyFrontWidth = kWhiteKeyFrontWidthCore*sizeFactor;
    kBlackKeyWidth = kBlackKeyWidthCore*sizeFactor;
    kWhiteKeyFrontLength = kWhiteKeyFrontLengthCore*sizeFactor;
    kWhiteKeyBackLength = kWhiteKeyBackLengthCore*sizeFactor;
    kBlackKeyLength = kBlackKeyLengthCore*sizeFactor;
    kInterKeySpacing = kInterKeySpacingCore*sizeFactor;
    
    // Individual geometry for C, D, E, F, G, A, B, c'
    
    for (int i = 0; i < 9; i++)
    {
        kWhiteKeyBackOffsets[i] = kWhiteKeyBackOffsetsCore[i]*sizeFactor;
        kWhiteKeyBackWidths[i] = kWhiteKeyBackWidthsCore[i]*sizeFactor;
    }
    // Display margins
    
    kDisplaySideMargin = kDisplaySideMarginCore * sizeFactor;
    kDisplayBottomMargin = kDisplayBottomMarginCore * sizeFactor;
    kDisplayTopMargin = kDisplayTopMarginCore * sizeFactor;
    
    
    mustRedraw = true;
    
}


//--------------------------------------------------------------

void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    
    
    //center the screen, but only if one finger is touching
    //iOS has a nasty habit of confusing super quick pinches where the fingers begin incredibly close together for double taps
    if (playMode == 1 && touch.id == 0 && numFingersTouching == 0)
    {
        center();
    }
    
}


//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){
    
}



//the distance of the fingers from each other compared the the distance they started apart from each other determines the new size

void testApp::rescale()
{
    
    
    
    double coreDistance = ofDist(drag1.x, drag1.y, drag2.x, drag2.y);
    double distance = ofDist(drag1current.x, drag1current.y, drag2current.x, drag2current.y);
    
    
    double ratio = distance/coreDistance;
    
    
    
    if (coreDistance <= 55)
    {
        ratio = (1+ratio)/2;
    }
    if (coreDistance <= 45)
    {
        ratio = (1+ratio)/2;
    }
    if (coreDistance <= 35)
    {
        ratio = (1+ratio)/2;
    }
    
    sizeFactor = coreSizeFactor*ratio;
    
    
    if (sizeFactor < 15)
    {
        sizeFactor = 15;
    }
    
    if (sizeFactor > 90)
    {
        sizeFactor = 90;
    }
    
    translateXCore = pinchCenterX - ((difX/coreSizeFactor)*sizeFactor);
    
    
    // Display dimensions, normalized to the width of one white key
    
    kWhiteKeyFrontWidth = kWhiteKeyFrontWidthCore*sizeFactor;
    kBlackKeyWidth = kBlackKeyWidthCore*sizeFactor;
    kWhiteKeyFrontLength = kWhiteKeyFrontLengthCore*sizeFactor;
    kWhiteKeyBackLength = kWhiteKeyBackLengthCore*sizeFactor;
    kBlackKeyLength = kBlackKeyLengthCore*sizeFactor;
    kInterKeySpacing = kInterKeySpacingCore*sizeFactor;
    
    // Individual geometry for C, D, E, F, G, A, B, c'
    
    for (int i = 0; i < 9; i++)
    {
        kWhiteKeyBackOffsets[i] = kWhiteKeyBackOffsetsCore[i]*sizeFactor;
        kWhiteKeyBackWidths[i] = kWhiteKeyBackWidthsCore[i]*sizeFactor;
    }
    // Display margins
    
    kDisplaySideMargin = kDisplaySideMarginCore * sizeFactor;
    kDisplayBottomMargin = kDisplayBottomMarginCore * sizeFactor;
    kDisplayTopMargin = kDisplayTopMarginCore * sizeFactor;
    
    
}


//establish the size of the keyboard

void testApp::setKeyboardRange(int lowest, int highest) {
	if(lowest < 0 || highest < 0)
		return;
	
    
	lowestMidiNote_ = lowest;
	if(keyShape(lowest) < 0)	// Lowest key must always be a white key for display to
		
    {
        lowest++;				// render properly
        
    }
	highestMidiNote_ = highest;
	
    
	
}

//used for drawing keys
int testApp::keyShape(int key)
{ 
    if(key < 0) {
        
        return -1;
    }
    
    return kShapeForNote[key % 12]; 
}


//determine if a touch is within a specific key
bool testApp::detectSpecificKey(int x, int y, int keyTest)
{
    
    translateX = translateXCore;
    translateY = translateYCore;
    
    if (twoRows == true)
    {
        translateY = translateYCore - (sizeFactor * 7);   
        
    }
    
	for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
        
        if (twoRows == true)
        {
            
            if (key == keyNewLine)
            {
                translateY = translateYCore;
                translateX = translateXCore;
            }
            
        }
        

		if(keyShape(key) >= 0) 
        {
            
            if (translateX > 1040 && twoRows == false)
            {
                break;
            }
            
			// White keys: compare and move the frame over for the next key
            
            if (key == keyTest)
            {
                if (detectWhiteKey(x, y, 0, 0, keyShape(key), key == lowestMidiNote_, key == highestMidiNote_, kKeyTitle[key%12]) == true)
                {
                    
                    return true;
                }
            }
			translateX += kWhiteKeyFrontWidth + kInterKeySpacing;			
		}
		else 
        {
            if (key == keyTest)
            {
                // Black keys: compare and leave the frame in place
                int previousWhiteKeyShape = keyShape(key - 1);
                float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
                float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;
                
                
                
                translateX += offsetH;
                translateY -= offsetV;
                if (detectBlackKey(x, y, 0, 0, kKeyTitle[key%12]) == true)
                {
                    
                    return true;
                    
                }
                
                translateX -= offsetH;
                translateY += offsetV;
            }
		}
	}
    return false;
}




//this just returns the value of the key being touched
int testApp::detectKey(int x, int y)
{
    
    translateX = translateXCore;
    translateY = translateYCore;
    
    if (twoRows == true)
    {
        translateY = translateYCore - (sizeFactor * 7);   
    }
    
	for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
        
        if (twoRows == true)
        {
            
            if (key == keyNewLine)
            {
                translateY = translateYCore;
                translateX = translateXCore;
            }
            
        }
        
        
		if(keyShape(key) >= 0) 
        {
            
            if (translateX > 1040 && twoRows == false)
            {
                break;
            }
            
			// White keys: compare and move the frame over for the next key
            
            
			if (detectWhiteKey(x, y, 0, 0, keyShape(key), key == lowestMidiNote_, key == highestMidiNote_, kKeyTitle[key%12]) == true)
            {
                
                return key;
            }
            
			translateX += kWhiteKeyFrontWidth + kInterKeySpacing;			
		}
		else 
        {
			// Black keys: compare and leave the frame in place
			int previousWhiteKeyShape = keyShape(key - 1);
			float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
			float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;
            
            translateX += offsetH;
            translateY -= offsetV;
			if (detectBlackKey(x, y, 0, 0, kKeyTitle[key%12]) == true)
            {
                return key;
            }
            
            translateX -= offsetH;
            translateY += offsetV;
            
		}
	}
    return -1;
    
}






bool testApp::detectWhiteKey(int touchX, int touchY, float x, float y, int shape, bool first, bool last, string title) {
    
    
    x += translateX;
    y += translateY;
    
	
	float backOffset, backWidth;
	
	if(first) {
		backOffset = 0.0;
		backWidth = kWhiteKeyBackOffsets[shape] + kWhiteKeyBackWidths[shape];
        
        
	}
	else if(last) {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = (1.0*sizeFactor) - kWhiteKeyBackOffsets[shape];
        
        
	}
	else {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = kWhiteKeyBackWidths[shape]; 
	}
    
    
    if (x + kWhiteKeyFrontWidth >= 0)
    {
        
        if (touchX >= x && touchX <= x + kWhiteKeyFrontWidth &&  touchY <= y && touchY >= y - kWhiteKeyFrontLength )
        {
            return true;
        }
        
        
        if ( touchX >= x + backOffset && touchX <= x + backOffset + backWidth && touchY <= y - kWhiteKeyFrontLength && touchY >= y - kWhiteKeyFrontLength - kWhiteKeyBackLength )
        {
            return true;
        }  
        
    }
    
    return false;
    
}


bool testApp::detectBlackKey(int touchX, int touchY, float x, float y, string title) {
    
    
    x += translateX;
    y += translateY;
    
    
    if (touchX >= x && touchX <= x+kBlackKeyWidth && touchY <= y && touchY >= y - kBlackKeyLength)
    {
        return true;
    }
    
    
    return false;
}






string testApp::getTitle(int keyCompare) {
    
    
    int octave = 0;
    
    int multInc = 9;
	
    
    
    for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
        
		if(keyShape(key) >= 0) 
        {
            
            if (keyCompare == key)
            {
                return (kKeyTitle[key%12]+ofToString(octave));
            }
		}
		else 
        {
			if (key == keyCompare)
            {
                return (kKeyTitle[key%12]+ofToString(octave));
			}
            
		}
        
        multInc++;
        if (multInc > 11)
        {
            octave++;
            multInc = 0;
        }
 
	}
	
    return "Invalid key selection";
    
}




void testApp::getDimensions(int keyCompare, keyDimensions & dimCompare)
{
    
    translateX = translateXCore;
    translateY = translateYCore;

    if (twoRows == true)
    {
        translateY = translateYCore - (sizeFactor * 7);   
        
    }
    
    
	for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
  
        
        if (twoRows == true)
        {
            
            if (key == keyNewLine)
            {
                translateY = translateYCore;
                translateX = translateXCore;
            }
            
        }
        
        
		if(keyShape(key) >= 0) 
        {
            
            if (translateX > 1040 && twoRows == false)
            {
                break;
            }
            
			if (key == keyCompare)
            {
                dimWhiteKey( dimCompare, 0, 0, keyShape(key), key == lowestMidiNote_, key == highestMidiNote_);
                
            }
            
			translateX += kWhiteKeyFrontWidth + kInterKeySpacing;			
		}
		else 
        {
			int previousWhiteKeyShape = keyShape(key - 1);
			float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
			float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;

            
            translateX += offsetH;
            translateY -= offsetV;
            
            if (key == keyCompare)
            {
                dimBlackKey(dimCompare, 0, 0);
			}
            
            
            translateX -= offsetH;
            translateY += offsetV;
            
		}
	}
}




void testApp::dimWhiteKey (keyDimensions & keyDim, float x, float y, int shape, bool first, bool last) 
{
    
    
    x += translateX;
    y += translateY;
    
	
	float backOffset, backWidth;
	
	if(first) {
		backOffset = 0.0;
		backWidth = kWhiteKeyBackOffsets[shape] + kWhiteKeyBackWidths[shape];
        
        
	}
	else if(last) {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = (1.0*sizeFactor) - kWhiteKeyBackOffsets[shape];
        
        
	}
	else {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = kWhiteKeyBackWidths[shape]; 
	}
    
    
    if (x + kWhiteKeyFrontWidth >= 0)
    {
        
        
        keyDim.leftX = x;
        
        keyDim.rightX = x + kWhiteKeyFrontWidth;
        
        keyDim.bottomY = y;
        
        keyDim.topY = y - kWhiteKeyFrontLength - kWhiteKeyBackLength;
        
    }
}


void testApp::dimBlackKey(keyDimensions & keyDim, float x, float y) 
{    
    
    x += translateX;
    y += translateY;
    
    
    
    keyDim.leftX = x;
    
    keyDim.rightX = x+kBlackKeyWidth;
    
    keyDim.topY = y - kBlackKeyLength;
    
    keyDim.bottomY = y;
    
}




// Render a specific key to be redrawn, great for situations like when a single key lights or darkens

void testApp::renderSpecific(int keyDraw) {
	if(lowestMidiNote_ == highestMidiNote_)
    {
		return;
	}
    
    if (keyDraw == -1)
    {
        return;
    }
    
    int octave = 0;
    
    int multInc = 9;
	
    
    translateX = translateXCore;
    translateY = translateYCore;
    
    
	if (twoRows == true)
    {
        translateY = translateYCore - (sizeFactor * 7);   
        
    }
    
    
	// Draw the keys themselves first, then draw the touches
	for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
        
        if (twoRows == true)
        {
            if (key == keyNewLine)
            {
                translateY = translateYCore;
                translateX = translateXCore;
            }
        }
        
		if(keyShape(key) >= 0) 
        {
            
            if (key == keyDraw)
            {
                if (translateX > 1040 && twoRows == false)
                {
                    break;
                }
                
                // White keys: draw and move the frame over for the next key
                
                int highLightType = -1;
                
                if (playMode == 3 && key == calibrateKeyHighlighted)
                {
                    highLightType = 3;
                }
                else if (playMode == 0 && keyLit[key] == true)
                {
                    
                    highLightType = 0;
                    
                }
                
                drawWhiteKey(0, 0, keyShape(key), key == lowestMidiNote_, key == highestMidiNote_,
                             highLightType, kKeyTitle[key%12]+ofToString(octave), keyPressure[key]);
                break;   
            }
            
			translateX += kWhiteKeyFrontWidth + kInterKeySpacing;			
		}
		else 
        {
            
            if (key == keyDraw)
            {
                // Black keys: draw and leave the frame in place
                int previousWhiteKeyShape = keyShape(key - 1);
                float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
                float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;

                
                translateX += offsetH;
                translateY -= offsetV;
                
                int highLightType = -1;
                
                if (playMode == 3 && key == calibrateKeyHighlighted)
                {
                    highLightType = 3;
                }
                else if (playMode == 0 && keyLit[key] == true)
                {
                    
                    highLightType = 0;
                    
                }
                
                
                drawBlackKey(0, 0, highLightType, kKeyTitle[key%12]+ofToString(octave), keyPressure[key]);
                
                translateX -= offsetH;
                translateY += offsetV;
                break;   
            }
            
		}
        
        multInc++;
        if (multInc > 11)
        {
            octave++;
            multInc = 0;
        }
        
	}
	
    
    
	// Draw the touches
    
    if (displayIncoming == true)
    {
        
        translateX = translateXCore;
        translateY = translateYCore;
        
        
        if (twoRows == true)
        {
            translateY = translateYCore - (sizeFactor * 7);   
        }
        
        
        for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
        {
            
            
            
            if (twoRows == true)
            {
                
                if (key == keyNewLine)
                {
                    translateY = translateYCore;
                    translateX = translateXCore;
                }
                
            }
            
            if(keyShape(key) >= 0) 
            {
                
                // Check whether there are any current touches for this key
                if(currentTouches[key].count > 0) {
                    TouchInfo t = currentTouches[key];
                    
                    if(t.locV1 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV1, t.size1);
                    if(t.locV2 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV2, t.size2);
                    if(t.locV3 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV3, t.size3);
                }
                
                translateX += kWhiteKeyFrontWidth + kInterKeySpacing;
                
            }
            else {
                // Black keys: draw and leave the frame in place
                int previousWhiteKeyShape = keyShape(key - 1);
                float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
                float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;
                
                
                translateX += offsetH;
                
                translateY -= offsetV;
                
                
                // Check whether there are any current touches for this key
                if(currentTouches[key].count > 0) {
                    TouchInfo t = currentTouches[key];
                    
                    if(t.locV1 >= 0)
                        drawBlackTouch(0, 0, t.locV1, t.size1);
                    if(t.locV2 >= 0)
                        drawBlackTouch(0, 0, t.locV2, t.size2);
                    if(t.locV3 >= 0)
                        drawBlackTouch(0, 0, t.locV3, t.size3);				
                }
                
                translateX -= offsetH;
                
                translateY += offsetV;
                
            }
        }	
    }
}




// Render the keyboard display

void testApp::render() {
    
	if(lowestMidiNote_ == highestMidiNote_)
		return;
	
    
    
    int octave = 0;
    
    int multInc = 9;
	
    
    translateX = translateXCore;
    translateY = translateYCore;
    
    
    
    
	if (twoRows == true)
    {
        translateY = translateYCore - (sizeFactor * 7);   
        
    }
    
    
	// Draw the keys themselves first, then draw the touches
	for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
    {
        
        if (twoRows == true)
        {
            
            if (key == keyNewLine)
            {
                translateY = translateYCore;
                translateX = translateXCore;
            }
            
        }
        
        
		if(keyShape(key) >= 0) 
        {
            
            if (translateX > 1040 && twoRows == false)
            {
                break;
            }
            
			// White keys: draw and move the frame over for the next key
            
            int highLightType = -1;
            
            if (playMode == 3 && key == calibrateKeyHighlighted)
            {
                highLightType = 3;
            }
            else if (playMode == 0 && keyLit[key] == true)
            {
                
                highLightType = 0;
                
            }
            
			drawWhiteKey(0, 0, keyShape(key), key == lowestMidiNote_, key == highestMidiNote_,
						 highLightType, kKeyTitle[key%12]+ofToString(octave), keyPressure[key]);
            
			translateX += kWhiteKeyFrontWidth + kInterKeySpacing;			
		}
		else 
        {
            
            
			// Black keys: draw and leave the frame in place
			int previousWhiteKeyShape = keyShape(key - 1);
			float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
			float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;
            

            
            translateX += offsetH;
            translateY -= offsetV;
            
            int highLightType = -1;
            
            if (playMode == 3 && key == calibrateKeyHighlighted)
            {
                highLightType = 3;
            }
            else if (playMode == 0 && keyLit[key] == true)
            {
                
                highLightType = 0;
                
            }
            
            
			drawBlackKey(0, 0, highLightType, kKeyTitle[key%12]+ofToString(octave), keyPressure[key]);
            
            translateX -= offsetH;
            translateY += offsetV;
            
		}
        
        multInc++;
        if (multInc > 11)
        {
            octave++;
            multInc = 0;
        }
          
	}
    
    if (displayIncoming == true)
    {
        
        translateX = translateXCore;
        translateY = translateYCore;
        
        
        if (twoRows == true)
        {
            translateY = translateYCore - (sizeFactor * 7);   
            
        }
        
        // Draw the touches
        for(int key = lowestMidiNote_; key <= highestMidiNote_; key++) 
        {

            
            if (twoRows == true)
            {
                
                if (key == keyNewLine)
                {
                    translateY = translateYCore;
                    translateX = translateXCore;
                }
                
            }
            
            if(keyShape(key) >= 0) 
            {
                
                // Check whether there are any current touches for this key
                if(currentTouches[key].count > 0) {
                    cout << key;
                    cout << "\n";
                    cout << "\n";
                    cout << "\n";
                    cout << currentTouches[key].count;
                    cout << "\n";
                    cout << "\n";
                    
                    TouchInfo t = currentTouches[key];
                    
                    if(t.locV1 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV1, t.size1);
                    if(t.locV2 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV2, t.size2);
                    if(t.locV3 >= 0)
                        drawWhiteTouch(0, 0, keyShape(key), t.locH, t.locV3, t.size3);
                }
                
                translateX += kWhiteKeyFrontWidth + kInterKeySpacing;
                
            }
            else {
                // Black keys: draw and leave the frame in place
                
                
                // Check whether there are any current touches for this key
                if(currentTouches[key].count > 0) {
                    
                    int previousWhiteKeyShape = keyShape(key - 1);
                    float offsetH = (-1.0*sizeFactor) + kWhiteKeyBackOffsets[previousWhiteKeyShape] + kWhiteKeyBackWidths[previousWhiteKeyShape];
                    float offsetV = kWhiteKeyFrontLength + kWhiteKeyBackLength - kBlackKeyLength;
                    
                    
                    translateX += offsetH;
                    
                    translateY -= offsetV;
                    cout << "OFFSETV IS ";
                    cout << offsetV;
                    cout << "\n\n";
                    
                    TouchInfo t = currentTouches[key];
                    
                    if(t.locV1 >= 0)
                        drawBlackTouch(0, 0, t.locV1, t.size1);
                    if(t.locV2 >= 0)
                        drawBlackTouch(0, 0, t.locV2, t.size2);
                    if(t.locV3 >= 0)
                        drawBlackTouch(0, 0, t.locV3, t.size3);		
                    
                    translateX -= offsetH;
                    
                    translateY += offsetV;
                    
                }
                
                
            }
        }	
    }
}






// Draw a circle indicating a touch on the white key surface

void testApp::drawWhiteTouch(float x, float y, int shape, float touchLocH, float touchLocV, float touchSize) {
    
    cout << "WE BE DRAWIN THE WHITE TOUCH HERE SON THE LOC H IS ";
    cout << touchLocH;
    cout << " AND THE LOCV IS ";
    cout << touchLocV;
    cout << " AND SIZE IS ";
    cout << touchSize;
    cout << "\n";
    x += translateX;
    y += translateY;

    
    ofFill();
    
    
    ofSetColor(255, 0, 255);
    
    
    if(touchLocV < kWhiteKeyFrontBackCutoff && touchLocH >= 0.0) {
        cout << "FIRSTLOOPSIZEFACTOR IS ";
        cout << sizeFactor;
        cout << "\n";
        
        
        // Here, the touch is in a location that has both horizontal and vertical information.
        
        ofCircle(x + + touchLocH*kWhiteKeyFrontWidth, y - kWhiteKeyFrontLength*(touchLocV/kWhiteKeyFrontBackCutoff), touchSize*sizeFactor/2);
        
        cout << "XDRAWINGATIS ";
        cout << x + touchLocH*kWhiteKeyFrontWidth;
        cout << "\n";
        cout << "YDRAWINGATIS ";
        cout << y- kWhiteKeyFrontLength*(touchLocV/kWhiteKeyFrontBackCutoff);
        cout << "\n";
        cout << "TRASNSLATE Y IS ";
        cout << translateY;
        cout << "\n";
        cout << "AND THE SIZE IS ";
        cout << touchSize*sizeFactor;
        cout << "\n";
        
        
    }
    else {
        cout << "SECONDLOOP   ";
        cout << kWhiteKeyFrontBackCutoff;
        cout << "\n";
        // The touch is in the back part of the key, or for some reason lacks horizontal information
        ofCircle(x + kWhiteKeyBackOffsets[shape] + kWhiteKeyBackWidths[shape]/2, y - kWhiteKeyFrontLength*(touchLocV/kWhiteKeyFrontBackCutoff), touchSize*sizeFactor/2);
        
    }
}


// Draw a circle indicating a touch on the black key surface

void testApp::drawBlackTouch(float x, float y, float touchLocV, float touchSize) {
    
    
    x += translateX;
    y += translateY;
    
    ofFill();
    ofSetColor(255, 255, 0);
    
    ofCircle(x + kBlackKeyWidth*0.5,
             y - kBlackKeyLength*touchLocV, touchSize*sizeFactor/2);
}








// Draw the outline of a white key.  Shape ranges from 0-7, giving the type of white key to draw
// Coordinates give the lower-left corner of the key

void testApp::drawWhiteKey(float x, float y, int shape, bool first, bool last, int highlighted, string title, float pressure) {
    
    
    
	// First and last keys will have special geometry since there is no black key below
	// Figure out the precise geometry in this case...
    
    x += translateX;
    y += translateY;
    
    
    
	
	float backOffset, backWidth;
	
	if(first) {
		backOffset = 0.0;
		backWidth = kWhiteKeyBackOffsets[shape] + kWhiteKeyBackWidths[shape];
        
        
	}
	else if(last) {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = (1.0*sizeFactor) - kWhiteKeyBackOffsets[shape];
        
        
	}
	else {
		backOffset = kWhiteKeyBackOffsets[shape];
		backWidth = kWhiteKeyBackWidths[shape]; 
	}
	
    
    
	if(highlighted == 0)
    {
        ofSetColor(255, 128, 128);
    }
    else if (highlighted == 3)
    {
        ofSetColor(128, 128, 255);
        
    }
	else
    {
        ofSetColor(255, 255, 255);
    }
    
    
    if (displayIncoming == true)
    {
        
        if (pressure <= 0)
        {
            
        }
        else
        {
            
            int subtractor;
            subtractor = (pressure*200);
            if (pressure > 1)
            {
                subtractor = 220;
            }
            
            ofSetColor(240-subtractor, 255, 240-subtractor);
            
            
        }
        
        
        
    }
    
    
    
    if (x + kWhiteKeyFrontWidth >= 0)
    {
        
        
        ofFill();
        
        ofBeginShape();
        
        
        
        ofVertex(x, y);
        ofVertex(x, y - kWhiteKeyFrontLength);
        ofVertex(x + kWhiteKeyFrontWidth, y - kWhiteKeyFrontLength);
        ofVertex(x + kWhiteKeyFrontWidth, y);
        
        ofEndShape();
        
        
        ofBeginShape();
        
        ofVertex(x + backOffset, y - kWhiteKeyFrontLength);
        ofVertex(x + backOffset, y - kWhiteKeyFrontLength - kWhiteKeyBackLength);
        ofVertex(x + backOffset + backWidth, y - kWhiteKeyFrontLength - kWhiteKeyBackLength);
        ofVertex(x + backOffset + backWidth, y - kWhiteKeyFrontLength);
        
        
        
        ofEndShape();
        
        
        // Now draw the outline as black line segments
        
        
        ofSetLineWidth(1);
        
        ofNoFill();
        ofSetColor(0, 0, 0);
        
        ofBeginShape();
        
        ofVertex(x, y);
        ofVertex(x, y - kWhiteKeyFrontLength);
        ofVertex(x + backOffset, y - kWhiteKeyFrontLength);
        ofVertex(x + backOffset, y - kWhiteKeyFrontLength - kWhiteKeyBackLength);
        ofVertex(x + backOffset + backWidth, y - kWhiteKeyFrontLength - kWhiteKeyBackLength);
        ofVertex(x + backOffset + backWidth, y - kWhiteKeyFrontLength);
        ofVertex(x + kWhiteKeyFrontWidth, y - kWhiteKeyFrontLength);
        ofVertex(x + kWhiteKeyFrontWidth, y);
        ofVertex(x, y);
        
        
        ofEndShape();
        
        if (sizeFactor > 24)
        {
            //ofDrawBitmapString(shape, x + 3, y - 3);
            ofDrawBitmapString(title, x + 3, y - 5);
        }
        else if (sizeFactor > 17)
        {
            ofDrawBitmapString(title, x + 1, y - 5);
            
        }
        
        
    }
}

// Draw the outline of a black key, given its lower-left corner

void testApp::drawBlackKey(float x, float y, int highlighted, string title, float pressure) 
{
    
    x += translateX;
    y += translateY;
    
    
    if (x + kBlackKeyWidth >= 0)
    {
        
        
        ofFill();
        
        if(highlighted == 0)
        {
            ofSetColor(128, 0, 0);
        }
        else if (highlighted == 3)
        {
            ofSetColor(0,0,128);
        }
        else
        {
            ofSetColor(0, 0, 0);
        }
        
        if (displayIncoming == true)
        {
            
            if (pressure <= 0)
            {
                
            }
            else
            {
                
                int subtractor;
                subtractor = (pressure*200);
                if (pressure > 1)
                {
                    subtractor = 220;
                }
                
                ofSetColor(10, 0+subtractor, 10);
                
                
            }

        }
            
        
        
        ofBeginShape();
        
        ofVertex(x, y);
        ofVertex(x, y - kBlackKeyLength);
        ofVertex(x + kBlackKeyWidth, y - kBlackKeyLength);
        ofVertex(x + kBlackKeyWidth, y);
        
        ofEndShape();
        
        if (sizeFactor > 52)
        {
            ofSetColor(255, 255, 255);
            if (sizeFactor < 55)
            {
                ofDrawBitmapString(title, x + 2, y - 5);
                
            }
            else
            {
                ofDrawBitmapString(title, x + 3, y - 5);
                
            }
        }
    }
}





void testApp::removeLeadZero()
{
    string p1, p2, p3, p4;
    
    
    int posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p1 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p2 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p3 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    p4 =hostName;
    
    
    
    
    bool canRemove = true;
    
    while (canRemove == true)
    {
        if (p1.length() == 1)
        {
            canRemove = false;
        }
        else if (p1.substr(0,1) == "0")
        {
            p1 = p1.substr(1);
        }
        else
        {
            canRemove = false;
        }
        
    }
    
    
    canRemove = true;
    
    while (canRemove == true)
    {
        if (p2.length() == 1)
        {
            canRemove = false;
        }
        else if (p2.substr(0,1) == "0")
        {
            p2 = p2.substr(1);
        }
        else
        {
            canRemove = false;
        }
        
    }
    
    
    canRemove = true;
    
    while (canRemove == true)
    {
        if (p3.length() == 1)
        {
            canRemove = false;
        }
        else if (p3.substr(0,1) == "0")
        {
            p3 = p3.substr(1);
        }
        else
        {
            canRemove = false;
        }
        
    }
    
    
    canRemove = true;
    
    while (canRemove == true)
    {
        if (p4.length() == 1)
        {
            canRemove = false;
        }
        else if (p4.substr(0,1) == "0")
        {
            p4 = p4.substr(1);
        }
        else
        {
            canRemove = false;
        }
        
    }

    
    hostName = p1+"."+p2+"."+p3+"."+p4;
    
    
    
    
    
}


void testApp::addLeadZero()
{
    
    string p1, p2, p3, p4;
    
    
    int posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p1 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p2 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    posMarker = 0;
    
    while (hostName.substr(posMarker, 1) != ".")
    {
        posMarker++;
    }
    
    p3 = hostName.substr(0, posMarker);
    
    hostName = hostName.substr(posMarker+1);
    
    p4 =hostName;
    
    
    
    while (p1.length() < 3)
    {
        p1 = "0"+p1;
    }
    while (p2.length() < 3)
    {
        p2 = "0"+p2;
    }
    while (p3.length() < 3)
    {
        p3 = "0"+p3;
    }
    while (p4.length() < 3)
    {
        p4 = "0"+p4;
    }
    

    
    hostName = p1+"."+p2+"."+p3+"."+p4;
    
    
    
    
    
}



