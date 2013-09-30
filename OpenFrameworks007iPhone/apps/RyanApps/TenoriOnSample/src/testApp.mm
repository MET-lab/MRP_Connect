#include "testApp.h"



class square
{
    
public:
    int x;
    int y;
    bool active;
    
    void init(int newX, int newY)
    {
        x = newX;
        y = newY;
        active = false;
    }
    
    
    
    void draw(int columnPlay) {
        if (x == columnPlay)
        {
            if (active == false)
            {
                ofSetColor(60, 60, 60, 190);
            }
            else
            {
                ofSetColor(240, 240, 240, 240);
            }   
        }
        else
        {
            if (active == false)
            {
                ofSetColor(60, 60, 60, 190);
            }
            else
            {
                ofSetColor(180, 180, 180, 190);
            }
        }
        ofRect( x * 47 + 7 + 8, y * 47 + 7 + 8, 40, 40);
        
	}
    
    void setPos(int newX, int newY)
    {
        x = newX;
        y = newY;
    }
    
    bool getActive()
    {
        return active;
    }
    
    void setActive()
    {
        active = true;
    }
    void setInactive()
    {
        active = false;
    }
    
    
};











square grid[16][16];






//--------------------------------------------------------------
void testApp::setup(){	
    
    
	// register touch events
	ofxRegisterMultitouch(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
    
    ofEnableAlphaBlending();
    
    ofSetFrameRate(30);
    
    
    SIDEMARGIN = 8;
    BOXSIZE = 47;
    SPACESIZE = 7;
    STARTINGVOLUME = .5;
    
    bpm = 360;
    
    
    
    
    currentMilli = 0;
    
    milliDif = 1000;
    
    lastMilli = ofGetElapsedTimeMillis();
    
    
    
    movingBPM = false;
    
    changingSquares = false;
    
    movingDif = 0;
    
    
    
    for (int x = 0; x < 16; x ++)
    {
        for (int y = 0; y < 16; y ++)
        {
            square newSquare;
            newSquare.init ( x, y );
            grid[x][y] = newSquare;
        }
        
        
    }
    
    
    for (int i = 0; i < 5; i ++)
    {
        activeType[i] = false;
    }
    
    for(int i=0;i<16;i++)
	{
        
        string fileName;
        fileName = ofToString(i + 1);
        fileName += ".caf";
        synth[i].setMultiPlay(true);
        synth[i].loadSound(fileName);
        
	}
    
    
    
    
    
}




//--------------------------------------------------------------
void testApp::update() {
    
    
    double milliCalc;
    milliCalc = (double)bpm/ 60;
    milliCalc = 1/milliCalc;
    milliCalc = milliCalc * 1000;
    
    milliDif = floor(milliCalc);
    
    currentMilli += ofGetElapsedTimeMillis() - lastMilli;
    
    
    if (currentMilli > milliDif)
    {
        
        while (currentMilli >= milliDif)
        {
            currentMilli -= milliDif;
        }
        columnPlay ++;
        if (columnPlay >= 16)
        {
            columnPlay = 0;
        }
        
        
        for (int i = 0; i < 16; i ++ )
        {
            if (grid[columnPlay][i].getActive() == true)
            {
                
                synth[i].play();
                
                
            }
        }  
    }
    
    lastMilli = ofGetElapsedTimeMillis();
	
}

//--------------------------------------------------------------
void testApp::draw() {
    
    ofSetColor( 0, 0, 0,  255);
    
    ofRect( -10, -10, 900, 1400 );
    
    ofSetColor(40, 40, 40, 240);
    
    ofRect( (columnPlay * BOXSIZE) + SIDEMARGIN + SPACESIZE, SIDEMARGIN + SPACESIZE, BOXSIZE - SPACESIZE, (BOXSIZE * 16) - SPACESIZE );
    
    for (int x = 0; x < 16; x++ )
    {
        for (int y = 0; y < 16; y ++)
        {
            grid[x][y].draw(columnPlay);
            
        }
    }   
    
    
    
    
    ofSetColor(255, 255, 255, 255);
    
    ofDrawBitmapString("BPM", 10, 795);
    
    
    ofDrawBitmapString(ofToString(bpm), 660, 795);
    
    
    
    ofLine(150, 795, 650, 795);
    
    
    
    ofSetColor(128, 128, 128);
    
    ofRect( bpm + 120, 770, 100, 50 );
    
    ofSetColor(255, 255, 255);
    
    ofDrawBitmapString("Limit 5 finger touch", 10, 920);
    ofDrawBitmapString("Ryan Daugherty's STAR Scholar Tenori-On Sample Based Sequencer, made with OpenFrameworks", 10, 940);
    ofDrawBitmapString("Touch and drag to light up or darken boxes", 10, 960);
    ofDrawBitmapString("Drag the BPM box to change the speed at which notes are played", 10, 980);
    ofDrawBitmapString("When the moving column hits a lit up box, a corresponding note will play", 10, 1000);
    ofDrawBitmapString("Double tap to clear the screen", 10, 1020);
    
    
}

//--------------------------------------------------------------
void testApp::exit() {
    
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
    
    
    if (id < 5)
    {
        
        if ( y > 770 && y < 820 && x > (bpm + 120) && x < (bpm + 120) + 100)
        {
            movingBPM = true;  
            movingDif = x - (bpm + 120);
        }
        
        else
        {
            
            
            x -= SIDEMARGIN;
            y -= SIDEMARGIN;
            
            x = x / BOXSIZE;
            
            y = y / BOXSIZE;
            
            if (x >= 0 && x < 16 && y >= 0 && y < 16)
            {
                
                if (grid[x][y].getActive() == true)
                {
                    activeType[id] = false;
                    grid[x][y].setInactive();
                }
                else
                {
                    activeType[id] = true;
                    grid[x][y].setActive();
                }
            }
        }
        
    }
    
}



//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
    
    
    
    if (id < 5)
    {
        
        if (movingBPM == true)
        {
            
            
            bpm = x - movingDif - 120;
            
            if (bpm < 30)
            {
                bpm = 30;
            }
            if (bpm > 430)
            {
                bpm = 430;
            }
            
        }
        else
        {
            x -= SIDEMARGIN;
            y -= SIDEMARGIN;
            
            x = x / BOXSIZE;
            
            y = y / BOXSIZE;
            
            if (x >= 0 && x < 16 && y >= 0 && y < 16)
            {
                
                if (activeType[id] == true)
                {
                    grid[x][y].setActive();
                }
                else
                {
                    grid[x][y].setInactive();
                }
                
            }
        }
    }
    
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){
    
    movingBPM = false;
    
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id){
    
    if (id == 0)
    {
        for (int a = 0; a < 16; a++)
        {
            for (int b = 0; b < 16; b++)
            {
                grid[a][b].setInactive();
                
            }
        }
        
        
    }
    
}

//--------------------------------------------------------------
void testApp::lostFocus() {
}

//--------------------------------------------------------------
void testApp::gotFocus() {
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning() {
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
}