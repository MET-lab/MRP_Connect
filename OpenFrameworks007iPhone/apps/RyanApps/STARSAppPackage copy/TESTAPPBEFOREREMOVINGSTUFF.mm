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


class ripple
{
public:
    
    int totalLife;
    
    int currentLife;
    
    int dropOff;
    
    int idNum;
    
    int x;
    
    int y;
    
    
    
    void init(int newX, int newY, int newLife, int newDrop)
    {
        x = newX;
        y = newY;
        
        currentLife = newLife;
        
        dropOff = newDrop;
        
    }
    
    
    
    void draw() {
        
        printf("drawing");
        
        ofSetColor(180, 180, 180, currentLife);
        
        ofRect( x * 47 + 7 + 8, y * 47 + 7 + 8, 40, 40);
        
	}
    
    int getX()
    {
        return x;
    }
    
    int getY()
    {
        return y;
    }
    
    int getLife()
    {
        return currentLife;
    }
    
    int getDrop()
    {
        return dropOff;
    }
    
    
    
    
private:
    
    
    
    
    
    
};


class sound
{
    
public:
    
    
    double frequencies;
    
    int sustains;
    
    int fades;
    
    double volumes;
    
    int life;
    
    double phaseAdderTargets;
    
    double phases;
    
    double phaseAdders;
    
    
    
    
    
};





int SIDEMARGIN;

int BOXSIZE;

int SPACESIZE;

double STARTINGVOLUME;






square grid[16][16];

vector<ripple> ripples;

vector<ripple> newRipples;




bool activeType;

int columnPlay;




int lastMilli;

int milliDif;

int currentMilli;




int rippleLastMilli;

int rippleMilliDif;

int rippleCurrentMilli;




int bpm;

int sustain;

int fade;




bool movingBPM;

bool changingSquares;

int movingDif;

int basis;






vector<sound> sounds;





//--------------------------------------------------------------
void testApp::setup(){	
    
    printf("HI");
    
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
    
    bpm = 60;
    
    sustain = 1500;
    
    fade = 0;
    
    
    
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
    
    
    
    
    
    
    activeType = false;
    
    
    
    
    
    
    
    
    
    
    
    
    for(int i=0;i<16;i++)
	{
        
		//synth[i].loadSound("synth.caf");
        //synth[i].loadSound("1.caf");
        
        string fileName;
        fileName = ofToString(i + 1);
        fileName += ".caf";
            synth[i].setMultiPlay(true);

        synth[i].loadSound(fileName);
        
        
	}
     
     
     
    
    
     
/*
	ofxOpenALSoundPlayer::ofxALSoundSetListenerLocation(ofGetWidth()/2,0,ofGetHeight()/2);
	ofxOpenALSoundPlayer::ofxALSoundSetReferenceDistance(10);
	ofxOpenALSoundPlayer::ofxALSoundSetMaxDistance(500);
	ofxOpenALSoundPlayer::ofxALSoundSetListenerGain(5.0);
 
 */
    
    
    /*
    
	for(int i=0;i<5;i++)
	{
		audioLoc[i].set(-1,-1);
		audioSize[i]=0;
	}
	lastSoundPlayed=0;
     
     */
     
    
    
    
    
    
    
    
    
    // 2 output channels,
	// 0 input channels
	// 44100 samples per second
	// 512 samples per buffer
	// 4 num buffers (latency)
    
	sampleRate 			= 44100;
	//phase 				= 0;
	//phaseAdder 			= 0.0f;
	//phaseAdderTarget 	= 0.0;
	//volume				= 0.15f;
	//pan					= 0.5;
	//bNoise 				= false;
	
	//for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
	//so we do 512 - otherwise we crash
	initialBufferSize	= 1024;
	
    
    
	lAudio				= new float[initialBufferSize];
	rAudio				= new float[initialBufferSize];
	
	memset(lAudio, 0, initialBufferSize * sizeof(float));
	memset(rAudio, 0, initialBufferSize * sizeof(float));
	
	//we do this because we don't have a mouse move function to work with:
	//targetFrequency = 444.0;
	//phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
	
	ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
    
    
    
    
    
    

}




void testApp::audioRequested(float * output, int bufferSize, int nChannels){
    
    
    /*
    
    printf("AHHH");
    
	if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	pan = 0.5;
	float leftScale = 1 - pan;
	float rightScale = pan;
    
	for (int i = 0; i < bufferSize; i++)
    {
        
        output[i*nChannels] = 0;
        output[i*nChannels + 1] = 0;
        
    }
    
    for (int freqNum = 0; freqNum < sounds.size(); freqNum ++)
    {
        
        
        while (sounds[freqNum].phases > TWO_PI)
        {
            sounds[freqNum].phases -= TWO_PI;
        }

        
		sounds[freqNum].phaseAdders = 0.95 * sounds[freqNum].phaseAdders + 0.05 * sounds[freqNum].phaseAdderTargets;
        
		for (int i = 0; i < bufferSize; i++)
        {
            
			sounds[freqNum].phases += sounds[freqNum].phaseAdders;
			float sample = sin(sounds[freqNum].phases);
            
            output[i*nChannels] += sample * sounds[freqNum].volumes * leftScale / sounds.size();
            output[i*nChannels + 1] += sample * sounds[freqNum].volumes * rightScale / sounds.size();
            
            
			lAudio[i] = output[i*nChannels    ];
			rAudio[i] = output[i*nChannels + 1];
            
		}
        
        
        
       
        
        
        
    }
     */
	
}





//--------------------------------------------------------------
void testApp::update() {
    
    /*
    double milliCalc;
    milliCalc = (double)bpm/ 60;
    milliCalc = 1/milliCalc;
    milliCalc = milliCalc * 1000;
    
    milliDif = floor(milliCalc);
    
    //sustain = milliDif;
    
    //printf("%i\n", milliDif);
    
    
    currentMilli += ofGetElapsedTimeMillis() - lastMilli;
    
    for (int i = 0; i < sounds.size(); i++)
    {
        //printf("%i", frequencies.size());
        
        sounds[i].life += ofGetElapsedTimeMillis() - lastMilli;
        
    }
    
    for (int i = 0; i < sounds.size(); i++)
    {
        
        if ( sounds[i].life > sounds[i].sustains + (sounds[i].fades * .9) )
        {
            
            for (int a = i; a < sounds.size()-1; a++)
            {
                sounds[a] = sounds[a + 1];
            }
            sounds.pop_back();
            i = 0;
            
        }
    }
    
    for (int i = 0; i < sounds.size(); i++)
    {
        if ( sounds[i].life <= sounds[i].sustains )
        {
            sounds[i].volumes = STARTINGVOLUME;
        }
        else
        {
            sounds[i].volumes = STARTINGVOLUME * ( 1 - ( (double)(sounds[i].life - sounds[i].sustains) / sounds[i].fades ) );
        }
        
    
    }
    
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
                 //ripple newRipple;
                 //newRipple.init( columnPlay, i, 150 + sustain, 50 - fade);
                 //newRipples.push_back(newRipple);
                 
                 sound newSound;
                 
                 newSound.phases = 0;
                 newSound.phaseAdders = 0;
                 newSound.phaseAdderTargets = 0;
                 newSound.volumes = STARTINGVOLUME;
                 
                 
                 if ( i == 0)
                 {
                     newSound.frequencies = 1760;
                 }
                 if ( i == 1)
                 {
                     newSound.frequencies = 1480;
                 }
                 if ( i == 2)
                 {
                     newSound.frequencies = 1318.5;
                 }
                 if ( i == 3)
                 {
                     newSound.frequencies = 1174.7;
                 }
                 if ( i == 4)
                 {
                     newSound.frequencies = 987.77;
                 }
                 if ( i == 5)
                 {
                     newSound.frequencies = 880;
                 }
                 if ( i == 6)
                 {
                     newSound.frequencies = 739.99;
                 }
                 if ( i == 7)
                 {
                     newSound.frequencies = 659.26;
                 }
                 if ( i == 8)
                 {
                     newSound.frequencies = 587.33;
                 }
                 if ( i == 9)
                 {
                     newSound.frequencies = 493.88;
                 }
                 if ( i == 10)
                 {
                     newSound.frequencies = 440;
                 }
                 if ( i == 11)
                 {
                     newSound.frequencies = 369.99;
                 }
                 if ( i == 12)
                 {
                     newSound.frequencies = 329.63;
                 }
                 if ( i == 13)
                 {
                     newSound.frequencies = 293.67;
                 }
                 if ( i == 14)
                 {
                     newSound.frequencies = 246.94;
                 }
                 if ( i == 15)
                 {
                     newSound.frequencies = 220;
                 }
                 newSound. phaseAdderTargets = (newSound.frequencies / (double) sampleRate) * TWO_PI;
                 
                 newSound.life = 0;
                 newSound.sustains = sustain;
                 newSound.fades = fade;
                 
                 
                 sounds.push_back(newSound);
                 
                 //we do this because we don't have a mouse move function to work with:
                 //targetFrequency = 444.0;
                 //phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
                 
         
             }
        }  
    }

     lastMilli = ofGetElapsedTimeMillis();

    
    */
    
    
    double milliCalc;
    milliCalc = (double)bpm/ 60;
    milliCalc = 1/milliCalc;
    milliCalc = milliCalc * 1000;
    
    milliDif = floor(milliCalc);
    
    //sustain = milliDif;
    
    //printf("%i\n", milliDif);
    
    
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
                
                /*
                bool spotFound = false;
                string fileName = "";
                fileName += ofToString(i + 1);
                fileName += ".caf";
                //fileName = "synth.caf";
                cout << fileName;
                
                for (int a = 0; a < notes.size(); a++)
                {
                    if (spotFound == false)
                    {
                    
                        if (2 == 1)
                        {
                            
                            notes[a].unloadSound();
                            notes[a].loadSound(fileName);
                            notes[a].play();
                            spotFound = true;
                            
                            
                        }
                        
                    }
                    
                }
                
                if (spotFound == false)
                {
                 
                    
                    newNote.loadSound(fileName);
                    newNote.play();
                    notes.push_back(newNote);
                    
                    
                //}
                
                */
                
                
                
                
            }
        }  
    }

    
    
    
    
    
    
    
    
    
    
    //printf("%i", ripples.size());
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
    
    
    for (int i = 0; i < ripples.size(); i ++)
    {
        ripples[i].draw();
    }
    
    ofSetColor(255, 255, 255, 255);
    
    ofDrawBitmapString("BPM", 10, 795);
    
    ofDrawBitmapString("Duration", 10, 855);
    
    ofDrawBitmapString("Fade Length", 10, 915);
    
    
    
    ofDrawBitmapString(ofToString(bpm), 660, 795);
    
    ofDrawBitmapString("123456789 ms", 660, 855);
    
    ofDrawBitmapString("123456789 ms", 660, 915);
    
    
    
    ofLine(150, 795, 650, 795);
    
    ofLine(150, 855, 650, 855);
    
    ofLine(150, 915, 650, 915);
    
    
    ofSetColor(128, 128, 128);
    
    ofRect( bpm + 120, 770, 100, 50 );
    
    ofRect( 150, 830, 100, 50 );
    
    ofRect( 150, 890, 100, 50 );
    
    
}

//--------------------------------------------------------------
void testApp::exit() {
    
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
    
    
    /*
    audioLoc[id].set(x,y);
	audioSize[id]=1;
	
	lastSoundPlayed++;
	if(lastSoundPlayed>=10)
		lastSoundPlayed=0;
	
	printf("%f %f  \n", (float)y / ofGetHeight(), (float)y);
	synth[lastSoundPlayed].play();
	//synth[lastSoundPlayed].setPitch(0.5 + (float)y / ofGetHeight());
	//synth[lastSoundPlayed].setLocation(x, 0, y);

    */
    
    
    printf("TOUCH");
    
    if (id == 0)
    {
        if ( y > 770 && y < 820 && x > (bpm + 120) && x < (bpm + 120) + 100)
        {
            // printf("MOVING");
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
                    activeType = false;
                    grid[x][y].setInactive();
                }
                else
                {
                    activeType = true;
                    grid[x][y].setActive();
                }
            }
        }
        
        
    }
}



//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
    
    /*
    
    audioLoc[touch.id].set(touch.x,touch.y);
	audioSize[touch.id]=1;
	
	lastSoundPlayed++;
	if(lastSoundPlayed>=10)
		lastSoundPlayed=0;
	
	printf("%f %f  \n", touch.y / ofGetHeight(), touch.y);
	synth[lastSoundPlayed].play();
	synth[lastSoundPlayed].setPitch(0.5 + touch.y / ofGetHeight());
	synth[lastSoundPlayed].setLocation(touch.x, 0, touch.y);
    
    */
    
    
    
    if (id == 0)
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
                
                if (activeType == true)
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