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
    
    
    
    void draw(int columnPlay) 
    {
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






typedef struct {
    double x,y;
} location;


//information stored about each individual hexagon

class hexagon
{
private:
    int x;
    int y;
    
    int baseColor;
    int darkerBaseColor;
    
    double frequency;
    
    string title;
    
    //Higher Columns are the odd ones, the ones that are higher on the lowest row
    bool isHigherCol;
    
    bool isPressed;
    
    
    
public:
    
    
    
    void init(int x_, int y_, string title_, bool isHigherCol_, int numFreq, int mult)
    {
        
        
        x = x_;
        y = y_;
        
        title = title_;
        
        isHigherCol = isHigherCol_;
        
        setInfo(title, numFreq, mult);
        
        title = title + ofToString(mult);
        
        isPressed = false;
        
        
    }
    
    bool isHigher()
    {
        return isHigherCol;
    }
    
    int getY()
    {
        return y;
    }
    int getX()
    {
        return x;
    }
    
    double getFrequency()
    {
        return frequency;
    }
    
    void setY(int num)
    {
        y = num;
    }
    void setX(int num)
    {
        x = num;
    }
    
    
    void unPress()
    {
        isPressed = false;
    }
    void press()
    {
        isPressed = true;
    }
    
    void draw(double SIDELENGTH)
    {
        
        
        ofFill();
        
        //base color
        if (isPressed == true)
        {
            ofSetHexColor(darkerBaseColor);
        }
        else
        {
            ofSetHexColor(baseColor);
        }
        
        ofBeginShape();
        
        //leftmost point
        ofVertex( x, y );
        
        //upperleftmost point
        ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
        
        //upperrightmost point
        ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
        
        //rightmost point
        ofVertex( x + SIDELENGTH + SIDELENGTH, y );
        
        //bottomrightmost point
        ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
        
        //bottomleftmost point
        ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
        
        //leftmost point
        ofVertex( x, y );
        
        ofEndShape();
        
        
        
        
        
        //lines
        
        
        ofSetLineWidth(3);
        
        ofSetHexColor(0x000000);
        
        
        ofNoFill();
        
        
        ofBeginShape();
        
        //leftmost point
        ofVertex( x, y );
        
        //upperleftmost point
        ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
        
        //upperrightmost point
        ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
        
        //rightmost point
        ofVertex( x + SIDELENGTH + SIDELENGTH, y );
        
        //bottomrightmost point
        ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
        
        //bottomleftmost point
        ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
        
        //leftmost point
        ofVertex( x, y );
        
        ofEndShape();
        
        
        
        ofFill();
        
        if (isPressed == true)
        {
            ofSetHexColor(0xcccccc);
        }
        else
        {
            ofSetHexColor(0xffffff);
            
        }
        ofDrawBitmapString(title, x + SIDELENGTH - 8, y + 4);
        
        
    }
    
    //this function determines the colors and frequencies
    void setInfo(string title_, int numFreq, int mult)
    {
        int colors[12];
        int darkerColors[12];
        
        
        double baseFrequencies[12];
        
        colors[0] = 0xff0000; //c
        colors[1] = 0xcc0000; //g
        colors[2] = 0x990000; //d
        colors[3] = 0x660000; //a
        colors[4] = 0x0000ff; //e
        colors[5] = 0x0000cc; //b
        colors[6] = 0x000099; //gb
        colors[7] = 0x000066; //db
        colors[8] = 0x00ff00; //ab
        colors[9] = 0x00cc00; //eb
        colors[10] = 0x009900; //bb
        colors[11] = 0x006600; //f
        
        darkerColors[0] = 0xdd0000; //c
        darkerColors[1] = 0xaa0000; //g
        darkerColors[2] = 0x770000; //d
        darkerColors[3] = 0x440000; //a
        darkerColors[4] = 0x0000dd; //e
        darkerColors[5] = 0x0000aa; //b
        darkerColors[6] = 0x000077; //gb
        darkerColors[7] = 0x000044; //db
        darkerColors[8] = 0x00dd00; //ab
        darkerColors[9] = 0x00aa00; //eb
        darkerColors[10] = 0x007700; //bb
        darkerColors[11] = 0x004400; //f
        
        
        baseFrequencies[0] = 16.35;
        baseFrequencies[1] = 24.5;
        baseFrequencies[2] = 18.35;
        baseFrequencies[3] = 27.5;
        baseFrequencies[4] = 20.6;
        baseFrequencies[5] = 30.87;
        baseFrequencies[6] = 23.12;
        baseFrequencies[7] = 17.32;
        baseFrequencies[8] = 25.96;
        baseFrequencies[9] = 19.45;
        baseFrequencies[10] = 29.14;
        baseFrequencies[11] = 21.83;
        
        
        baseColor = colors[numFreq];
        darkerBaseColor = darkerColors[numFreq];
        
        
        frequency = baseFrequencies[numFreq];
        
        
        for (int i = 0; i < mult; i++) 
        {
            frequency *= 2;
        }
        
        
    }
    
    //first, check if the touch is in the general vicinity of the hexagon
    //then, checks to see if the touch point is one of the vertices
    //find the sum of the angles mde by the touch and all the vertices to see if it is within the polygon
    
    bool isWithin(double SIDELENGTH, int touchX, int touchY)
    {
        if (touchX < x)
        {
            return false;
        }
        if (touchX > x+SIDELENGTH+SIDELENGTH)
        {
            return false;
        }
        if (touchY < y - (SIDELENGTH*sqrt(3)/2))
        {
            return false;
        }
        if (touchY > y + (SIDELENGTH*sqrt(3)/2))
        {
            return false;
        }
        if (InsidePolygon(SIDELENGTH, touchX, touchY))
        {
            
            return true;
        }
        
        return false;
    }
    
    
    double minNum(double num1, double num2)
    {
        if (num1 < num2)
        {
            return num1;
        }
        return num2;
    }
    double maxNum(double num1, double num2)
    {
        if (num1 > num2)
        {
            return num1;
        }
        return num2;
    } 
    
    typedef struct {
        double x,y;
    } location;
    
    //http://paulbourke.net/geometry/insidepoly/
    //solution 2
    
    int InsidePolygon(double SIDELENGTH, int touchX, int touchY)
    {
        double angle=0;        
        
        
        
        location p;
        
        p.x = touchX;
        p.y = touchY;
        
        location p1, p2;
        
        location polygon[6];
        
        polygon[0].x = x;
        polygon[0].y = y;
        
        polygon[1].x = x + (SIDELENGTH/2);
        polygon[1].y = y - ((SIDELENGTH*sqrt(3)) / 2);
        
        polygon[2].x = x  + (SIDELENGTH/2) + SIDELENGTH;
        polygon[2].y = y - ((SIDELENGTH*sqrt(3)) / 2) ;
        
        polygon[3].x = x + SIDELENGTH + SIDELENGTH;
        polygon[3].y = y;
        
        polygon[4].x = x + (SIDELENGTH/2) + SIDELENGTH;
        polygon[4].y = y + ((SIDELENGTH*sqrt(3)) / 2) ;
        
        polygon[5].x =  x + (SIDELENGTH/2);
        polygon[5].y = y + ((SIDELENGTH*sqrt(3)) / 2);
        
        
        int N = 6;
        
        
        
        for (int i = 0; i < 6; i++)
        {
            if (p.x == polygon[i].x && p.y == polygon[i].y)
            {
                return true;
            }
        }
        
        
        
        for (int i=0;i<N;i++) {
            p1.x = polygon[i].x - p.x;
            p1.y = polygon[i].y - p.y;
            p2.x = polygon[(i+1)%N].x - p.x;
            p2.y = polygon[(i+1)%N].y - p.y;
            angle += Angle2D(p1.x,p1.y,p2.x,p2.y);
        }
        
        if (ABS(angle) < PI)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    /*
     Return the angle between two vectors on a plane
     The angle is from vector 1 to vector 2, positive anticlockwise
     The result is between -pi -> pi
     */
    double Angle2D(double x1, double y1, double x2, double y2)
    {
        double dtheta,theta1,theta2;
        
        theta1 = atan2(y1,x1);
        theta2 = atan2(y2,x2);
        dtheta = theta2 - theta1;
        while (dtheta > PI)
        {
            dtheta -= PI;
            dtheta -= PI;
            
        }
        while (dtheta < -PI)
        {
            dtheta += PI;
            dtheta += PI;
        }
        return(dtheta);
    }    
};
















square grid[16][16];


vector <hexagon> hexList;




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
    
    
    appMode = 0;
    //mode 0 is selectscreen
    //mode 1 is tenorion
    
    
    
    
    //tenoriOn
    
    
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
    
    
    
    
    
    //hexatonnetx
    
    
    numFingersTouching = 0;
    
    
    
    
    
    
    SIDELENGTH = 60;
    
    BIGGERNUMHOR = 4;
    
    BIGGERNUMVERT = 8;
    
    TOUCHLIMIT = 10;
    
    NUMNOTES = 73;
    
    BOTTOMSCREENCUTOFF = 900;
    
    
    
    
    //any of the following equaling -1 basically tells the program to ignore that finger because its not touching
    
    
    for (int a = 0; a < TOUCHLIMIT; a++)
    {
        fingerTouching[a] = -1;
    }
    for (int a = 0; a < TOUCHLIMIT; a++)
    {
        fingerFrequencies[a] = -1;
    }
    for (int a = 0; a < TOUCHLIMIT; a++)
    {
        fingerPhaseAdder[a] = -1;
    }
    for (int a = 0; a < TOUCHLIMIT; a++)
    {
        fingerPhaseAdderTarget[a] = -1;
    }
    for (int a = 0; a < TOUCHLIMIT; a++)
    {
        fingerPhase[a] = -1;
    }
    
    
    
    //this is the color of the first note on the topmost row
    
    baseColor = 10;
    
    
    
    colorTitles[0] = "C";
    colorTitles[1] = "G";
    colorTitles[2] = "D";
    colorTitles[3] = "A";
    colorTitles[4] = "E";
    colorTitles[5] = "B";
    colorTitles[6] = "Gb";
    colorTitles[7] = "Db";
    colorTitles[8] = "Ab";
    colorTitles[9] = "Eb";
    colorTitles[10] = "Bb";
    colorTitles[11] = "F";
    
    
    TOPSHIFT = 1000;
    
    
    
    int baseCounter = 0;
    int multCounter = 1;
    int numInRow = 0;
    //this goes up every time it works through BOTH rows, lower and higher
    int numRow = 0;
    //this means if the lowest hex is higher up
    bool higherCol = false;
    
    for (int i = 0; i < NUMNOTES; i++)
    {
        hexagon HEX;
        if (higherCol == true)
        {
            
            HEX.init(numInRow*((2)*(SIDELENGTH)) + (numInRow*SIDELENGTH) + SIDESHIFT, TOPSHIFT - ((numRow * (SIDELENGTH*sqrt(3))) + ((SIDELENGTH*sqrt(3)/2))) , colorTitles[baseCounter], higherCol, baseCounter, multCounter);
            
        }
        else
        {
            
            HEX.init((numInRow+1)*((3/2)*(SIDELENGTH)) + ((numInRow+1)*SIDELENGTH) + ((numInRow)*SIDELENGTH) - (SIDELENGTH/2) + SIDESHIFT, TOPSHIFT - ((numRow * (SIDELENGTH*sqrt(3)))), colorTitles[baseCounter], higherCol, baseCounter, multCounter);
            
        }
        hexList.push_back(HEX);
        numInRow++;
        if (higherCol == true)
        {
            if (numInRow >= BIGGERNUMHOR)
            {
                numInRow = 0;
                higherCol = false;
                numRow++;
            }
        }
        
        else 
        {
            if (numInRow >= BIGGERNUMHOR - 1)
            {
                numInRow = 0;
                higherCol = true;
            }
        }
        if (i != 1 && (i+1)% 12 == 0)
        {
            multCounter++;
        }
        
        baseCounter += 7;
        while (baseCounter >= 12)
        {
            baseCounter -= 12;
        }
    }
    
    
    
    
    center();
    
    
    
    
    
    drag1valid = false;
    drag2valid = false;
    
    pinching = false;
    
    
    
    resizing = false;
    
    
    sizeFactor = 60;
    
    
    
    //initialize things for the sound
    
    sampleRate 			= 44100;
	volume				= 0.5f;
    initialBufferSize = 1024;
    
    
	lAudio				= new float[initialBufferSize];
	rAudio				= new float[initialBufferSize];
	
	memset(lAudio, 0, initialBufferSize * sizeof(float));
	memset(rAudio, 0, initialBufferSize * sizeof(float));
	
	
	ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
    
    
    

    
    
    
}




//--------------------------------------------------------------
void testApp::update() {
    
    
    
    
    if (appMode == 1)
    {
    
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
	
}

//--------------------------------------------------------------
void testApp::draw() {
    
    
    if (appMode == 1)
    {
    
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
    
    
    
    if (appMode == 2)
    {
        int numprinted = 0;
        for (int i = 0; i < hexList.size(); i++)
        {
            
            //if this hex is too low to be on screen, don't draw it
            
            if (hexList[i].getY() - (SIDELENGTH*sqrt(3)/2) > BOTTOMSCREENCUTOFF  )
            {
                if (hexList[i].isHigher())
                {
                    i+= 3;
                }
                else
                {
                    
                    i+= 2;
                }
                
            }
            
            //if this is too high to be on screen, stop drawing things
            
            else if (hexList[i].getY() + (SIDELENGTH*sqrt(3)/2) < 0  )
            {
                i = hexList.size() + 2;
                
            }
            else
            {
                numprinted++;
                hexList[i].draw(SIDELENGTH);
                
            }
        }
        
        
        
        ofSetColor(120, 120,120);
        
        ofRect(-10, BOTTOMSCREENCUTOFF, 800, 200);
        
        ofSetColor(255, 255, 255);
        
        
        ofDrawBitmapString("Limit 10 finger multitouch", 10, BOTTOMSCREENCUTOFF + 15);
        ofDrawBitmapString("Ryan Daugherty's STAR Scholar Hexatonnetz Sin Wave Generator, made with OpenFrameworks", 10, BOTTOMSCREENCUTOFF + 35);
        if (resizing == false)
        {
            ofDrawBitmapString("Currently in Play Mode, tap this box to switch to Move Mode", 10, BOTTOMSCREENCUTOFF + 55);
            ofDrawBitmapString("Tap or drag fingers to play notes", 10, BOTTOMSCREENCUTOFF + 75);
            ofDrawBitmapString("Keys arranged vertically are perfect fifths, diagonally to ", 10, BOTTOMSCREENCUTOFF + 95);
            ofDrawBitmapString("the upper right are major thirds, and diagonally to the upper left are minor thirds", 10, BOTTOMSCREENCUTOFF + 115);
            
        }
        else
        {
            ofDrawBitmapString("Currently in Move Mode, tap this box to switch to Play Mode", 10, BOTTOMSCREENCUTOFF + 55);
            ofDrawBitmapString("Touch and drag with one finger to move keys", 10, BOTTOMSCREENCUTOFF + 75);
            ofDrawBitmapString("Move two fingers apart or together to zoom in and out", 10, BOTTOMSCREENCUTOFF + 95);
            ofDrawBitmapString("Double tap one finger to center the keys", 10, BOTTOMSCREENCUTOFF + 115);
            
        }
    }
    
    
}

//--------------------------------------------------------------
void testApp::exit() {
    
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
    
    
    
    if (appMode == 1)
    {
    
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
    
    
    if (appMode == 2)
    {
        numFingersTouching++;
        
        if (y > BOTTOMSCREENCUTOFF && numFingersTouching == 1)
        {
            resizing = !resizing;
            switchFingerTouching = true;
            
        }
        else if (resizing ==true)
        {
            
            //save initial position in case the player is moving hexes
            if (numFingersTouching == 1)
            {
                
                sideShiftCoreX = SIDESHIFT;
                sideShiftCoreY = TOPSHIFT;
                
                
                centerX = x;
                centerY = y;
                
            }
            
            if (id == 0)
            {
                
                drag1valid = true;
                drag1.x = x;
                drag1.y = y;
                
                drag1current.x = x;
                drag1current.y = y;
                
            }
            
            if (id == 1)
            {
                
                drag2valid = true;
                drag2.x = x;
                drag2.y = y;
                
                drag2current.x = x;
                drag2current.y = y;
                
            }
            
            
            //save information about the screen and pinch for the sake of scaling
            if (drag1valid == true && drag2valid == true)
            {
                
                pinching = true;
                sizeFactorCore = SIDELENGTH;
                pinchCenterX = floor((drag1current.x + drag2current.x)/2);
                pinchCenterY = floor((drag1current.y + drag2current.y)/2);
                
                
                sideShiftCoreX = SIDESHIFT;
                sideShiftCoreY = TOPSHIFT;
                
                
                
            }
            
            
        }
        else if (resizing == false)
        {
            //find which one its touching, dont waste your time on offscreen hexes
            for (int i = 0; i < hexList.size(); i++)
            {
                if (hexList[i].getY() - (SIDELENGTH*sqrt(3)/2) > BOTTOMSCREENCUTOFF  )
                {
                    if (hexList[i].isHigher())
                    {
                        i+= 3;
                    }
                    else
                    {
                        
                        i+= 2;
                    }
                    
                }
                else if (hexList[i].getY() + (SIDELENGTH*sqrt(3)/2) < 0  )
                {
                    i = hexList.size() + 2;
                    
                }
                
                
                else  if (hexList[i].isWithin(SIDELENGTH, x, y))
                {
                    hexList[i].press();
                    
                    double newFreq;
                    
                    fingerTouching[id] = i;
                    
                    
                    newFreq = hexList[i].getFrequency();
                    
                    
                    if (fingerFrequencies[id] != newFreq)
                    {
                        
                        fingerFrequencies[id] = newFreq;
                        fingerPhase[id] = 0;
                        fingerPhaseAdderTarget[id] = (newFreq/ (float) sampleRate) * TWO_PI;       
                        fingerPhaseAdder[id] = 0;
                        
                    }
                    
                    
                    break;
                }
            }
        }
    }
    
}



//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
    
    
    if (appMode == 1)
    {
    
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
    
    
    
    if (appMode == 2)
    {
        bool foundHex = false;
        
        if (resizing ==true )
        {
            if (id == 0)
            {
                drag1current.x = x;
                drag1current.y = y;
            }
            if (id == 1)
            {
                drag2current.x = x;
                drag2current.y = y;
            }
            
            //resize everything based on previously saved values
            if (drag1valid == true && drag2valid == true && numFingersTouching == 2)
            {
                
                rescale();
                
            }
            //move everything based on previously saved values
            else  if (numFingersTouching == 1  && switchFingerTouching == false && pinching == false)
            {
                SIDESHIFT = sideShiftCoreX - (centerX - x);
                TOPSHIFT = sideShiftCoreY - (centerY - y);
                
                relocate();
                
            }
        }
        else  if (switchFingerTouching == false)
        {
            //if its moved, but within the same hexagon, don't change anything
            if ((hexList[fingerTouching[id]].isWithin(SIDELENGTH, x, y)))
            {
                foundHex = true;
            }
            //find out what hexagon its now in and silence the one it was in
            else
            {
                for (int i = 0; i < hexList.size(); i++)
                {
                    
                    
                    if (hexList[i].getY() - (SIDELENGTH*sqrt(3)/2) > BOTTOMSCREENCUTOFF  )
                    {
                        if (hexList[i].isHigher())
                        {
                            i+= 3;
                        }
                        else
                        {
                            
                            i+= 2;
                        }
                        
                    }
                    else if (hexList[i].getY() + (SIDELENGTH*sqrt(3)/2) < 0  )
                    {
                        i = hexList.size() + 2;
                        
                    }
                    
                    
                    else  if (hexList[i].isWithin(SIDELENGTH, x, y) && id < TOUCHLIMIT)
                    {
                        hexList[fingerTouching[id]].unPress();
                        hexList[i].press();
                        fingerTouching[id] = i;
                        foundHex = true;
                        
                        
                        
                        
                        double newFreq;
                        
                        
                        
                        newFreq = hexList[i].getFrequency();
                        
                        if (fingerFrequencies[id] != newFreq)
                        {
                            
                            fingerFrequencies[id] = newFreq;
                            fingerPhase[id] = 0;
                            fingerPhaseAdderTarget[id] = (newFreq/ (float) sampleRate) * TWO_PI;       
                            fingerPhaseAdder[id] = 0;
                            
                        }
                        
                        
                        
                        
                        break;
                    }
                }
            }
        }
        
        
        
        
        if (foundHex == false)
        {
            
            fingerFrequencies[id] = -1;
            fingerPhase[id] = -1;
            fingerPhaseAdderTarget[id] = -1;       
            fingerPhaseAdder[id] = -1;
            
        }
    }
    
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){
    
    
    
    if (appMode == 1)
    {
    
    movingBPM = false;
        
    }
    
    
    
    if (appMode == 2)
    {
        numFingersTouching--;
        
        if (numFingersTouching == 0)
        {
            switchFingerTouching = false;
        }
        
        if (fingerTouching[id] == -1)
        {
            
        }
        else
        {
            hexList[fingerTouching[id]].unPress();
            
        }
        fingerTouching[id] = -1;
        
        
        fingerFrequencies[id] = -1;
        fingerPhase[id] = -1;
        fingerPhaseAdderTarget[id] = -1;       
        fingerPhaseAdder[id] = -1;
        
        
        
        if (resizing == true)
        {
            
            if (id == 0)
            {
                
                drag1valid = false;
                
            }
            
            if (id == 1)
            {
                
                drag2valid = false;
                
            }
            if (drag1valid == false && drag2valid == false)
            {
                pinching = false;
            }
        }
    }
    
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id)
{
    
    if (appMode == 1)
    {
    
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
    
    
    
    
    if (appMode == 2)
    {
        //center the screen, but only if one finger is touching
        //iOS has a nasty habit of confusing super quick pinches where the fingers begin incredibly close together for double taps
        if (resizing == true && id == 0 && numFingersTouching == 0)
        {
            center();
            
        }
    }
    
    
}

//---------------------------------------------------------r-----
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















//when you shift over TOPSHIFT and SIDESHIFT, this moves all hexes accordingly
//SIDESHIFT,TOPSHIFT is the point at hex[0]'s x-((3/2)SIDELENGTH), y


void testApp::relocate()
{
    int baseCounter = 0;
    int multCounter = 1;
    int numInRow = 0;
    //this goes up every time it works through BOTH rows, lower and higher
    int numRow = 0;
    //this means if the lowest hex is higher up
    bool higherCol = false;
    
    for (int i = 0; i < NUMNOTES; i++)
    {
        
        if (higherCol == true)
        {
            
            hexList[i].setX(numInRow*((2)*(SIDELENGTH)) + (numInRow*SIDELENGTH) + SIDESHIFT);
            hexList[i].setY(TOPSHIFT - ((numRow * (SIDELENGTH*sqrt(3))) + ((SIDELENGTH*sqrt(3)/2))));
            
        }
        else
        {
            
            hexList[i].setX((numInRow+1)*((3/2)*(SIDELENGTH)) + ((numInRow+1)*SIDELENGTH) + ((numInRow)*SIDELENGTH) - (SIDELENGTH/2) + SIDESHIFT);
            hexList[i].setY(TOPSHIFT - ((numRow * (SIDELENGTH*sqrt(3)))));
            
        }
        numInRow++;
        if (higherCol == true)
        {
            if (numInRow >= BIGGERNUMHOR)
            {
                numInRow = 0;
                higherCol = false;
                numRow++;
            }
        }
        
        else 
        {
            if (numInRow >= BIGGERNUMHOR - 1)
            {
                numInRow = 0;
                higherCol = true;
            }
        }
        if (i != 1 && (i+1)% 12 == 0)
        {
            multCounter++;
        }
        
        baseCounter += 7;
        while (baseCounter >= 12)
        {
            baseCounter -= 12;
        }
    }
    
}





//this is where the buffer is filled with sound
//one "frame" in the buffer is a single sample
//sample rate determines samples per second

void testApp::audioRequested(float * output, int bufferSize, int nChannels)
{
    
    if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
    
    //change this to change the panning of the sound
	float leftScale = .5;
	float rightScale = .5;
    
    
    for (int i = 0; i < bufferSize; i++){
        
        lAudio[i] = output[i*nChannels    ] = 0;
        rAudio[i] = output[i*nChannels + 1] = 0;
        
    }
    
    
    //find out how many sounds are playing
    int numDivide = 0;
    
    for (int freqNum = 0; freqNum < TOUCHLIMIT; freqNum++)
    {
        if (fingerFrequencies[freqNum] != -1)
        {
            numDivide++;
        }
    }
    
    if (numDivide == 0)
    {
        numDivide = 1;
    }
    
    
    for (int freqNum = 0; freqNum < TOUCHLIMIT; freqNum++)
    {
        
        
        if (fingerFrequencies[freqNum] != -1)
        {
            
            //prevenet the number from getting ridiculously high, keep it between 0 and 2 pi
            while (fingerPhase[freqNum] > TWO_PI)
            {
                fingerPhase[freqNum] -= TWO_PI;
            }
            
            //this is how much to increase theta each sample
            
            fingerPhaseAdder[freqNum] = fingerPhaseAdderTarget[freqNum];
            
            //for each "frame" in the buffer, add the sound for this finger's frequency
            //each addition is divided by number of sounds total to prevent clipping
            
            for (int i = 0; i < bufferSize; i++){
                fingerPhase[freqNum] += fingerPhaseAdder[freqNum];
                float sample = sin(fingerPhase[freqNum]);
                lAudio[i] = output[i*nChannels    ] += sample * volume * leftScale / numDivide;
                rAudio[i] = output[i*nChannels + 1] += sample * volume * rightScale / numDivide;
                
            }
            
        }
        
    }
    
	
}




//resize everything around where the pinch center is located, change SIDELENGTH SIDESHIFT and TOPSHIFT accordingly
//based on a ratio between how far apart the fingers were at the start of the pinch compared to where they are now
//base everything off of the board's values before the pinch started

void testApp::rescale()
{
    
    
    
    
    
    double difX, difY;
    
    difX = pinchCenterX - sideShiftCoreX;
    
    difY = sideShiftCoreY - pinchCenterY;
    
    
    double coreDistance = ofDist(drag1.x, drag1.y, drag2.x, drag2.y);
    
    double distance = ofDist(drag1current.x, drag1current.y, drag2current.x, drag2current.y);
    
    
    
    //scale the ratio a bit if fingers started insanely close together  
    
    double ratio;
    
    ratio = distance/coreDistance;
    
    if (ofDist( drag1.x, drag1.y, drag2.x, drag2.y) < 65)
    {
        ratio = (1 + ratio) / 2;
    }
    
    
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
    
    sizeFactor = sizeFactorCore * ratio;
    
    
    if (sizeFactor > 180)
    {
        sizeFactor = 180;
    }
    if (sizeFactor < 30)
    {
        sizeFactor = 30;
    }
    
    
    
    
    
    SIDELENGTH = floor(sizeFactor);
    
    
    int posInRow = 1;
    
    int rowIn = 0;
    
    
    //relocate the hexes relative to hex[0]
    
    for (int i = 1; i < NUMNOTES; i++)
    {
        
        if (hexList[i].isHigher())
        {
            
            hexList[i].setX(hexList[0].getX() - ((3/2)*SIDELENGTH) - (SIDELENGTH/2 )+ (3 * SIDELENGTH * posInRow));
            
            hexList[i].setY(hexList[0].getY() - (SIDELENGTH * sqrt(3) / 2) - (rowIn * (SIDELENGTH*sqrt(3))));
            
        }
        else
        {
            hexList[i].setX( hexList[0].getX() + (3 * SIDELENGTH * posInRow) );
            
            hexList[i].setY(hexList[0].getY() - (rowIn * (SIDELENGTH*sqrt(3))));
            
        }
        
        
        
        posInRow++;
        if (hexList[i].isHigher() == true)
        {
            if (posInRow >= BIGGERNUMHOR)
            {
                posInRow = 0;
                rowIn++;
            }
        }
        
        else 
        {
            if (posInRow >= BIGGERNUMHOR - 1)
            {
                posInRow = 0;
            }
        }
        
        
    }
    
    
    //move so that the pinch is still in the same spot even though hexes are different sizes
    
    SIDESHIFT = pinchCenterX - ((difX/sizeFactorCore)*sizeFactor);
    
    
    TOPSHIFT = pinchCenterY + ((difY/sizeFactorCore)*sizeFactor);
    
    
    relocate();
    
    
    
}


void testApp::center()
{
    
    SIDESHIFT =  (768/2) - (((BIGGERNUMHOR * 2 * SIDELENGTH) + ( (BIGGERNUMHOR - 1) * SIDELENGTH ))/2 ) ;
    
    TOPSHIFT = (BOTTOMSCREENCUTOFF / 2) + ((BIGGERNUMVERT * SIDELENGTH * sqrt(3))/2) + (SIDELENGTH * sqrt(3));
    
    relocate();
    
}










