#include "testApp.h"


typedef struct {
    double x,y;
} location;

class hexagon
{
private:
    int x;
    int y;
    
    int baseColor;
    int darkerBaseColor;
    
    double frequency;
    
    string title;
    
    //Higher Columns are the odd ones
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
        
        printf("x %i    y %i title is ", x, y);
        cout << title;
        cout << " frequency is ";
        cout << frequency;
        cout << "\n";
        
        
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






vector <hexagon> hexList;


bool changingIP;

int numOnHost;

int numOnPort;




//--------------------------------------------------------------
void testApp::setup(){
    
    ofSetFrameRate(60);
    
	ofBackground( 40, 1400, 40 );
    
    hostName = "10.0.1.144";
    
    portName = 12345;
    
    
    
    changingIP = false;
    
    numOnHost = 0;
    
    numOnPort = 0;
    
    
    
    
    ofTrueTypeFont::setGlobalDpi(72);
    
	verdana30.loadFont("verdana.ttf", 30, true, true);
	verdana30.setLineHeight(34.0f);
	verdana30.setLetterSpacing(1.035);
    
    
    
    
    
    
	// open an outgoing connection to HOST:PORT
	sender.setup( hostName, portName);
    
    
    
    
    // register touch events
	ofxRegisterMultitouch(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
    
    ofDisableAlphaBlending();
    
    // ofDisableSmoothing();
    ofEnableSmoothing();
    
    
    ofSetFrameRate(30);
    
    
    
    numFingersTouching = 0;
    
    
    
    
    
    
    SIDELENGTH = 60;
    
    BIGGERNUMHOR = 4;
    
    BIGGERNUMVERT = 8;
    
    TOUCHLIMIT = 10;
    
    NUMNOTES = 73;
    
    BOTTOMSCREENCUTOFF = 900;
    
    
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
    
    
    
    sampleRate 			= 44100;
	volume				= 0.4f;
    initialBufferSize = 1024;
    
    
	lAudio				= new float[initialBufferSize];
	rAudio				= new float[initialBufferSize];
	
	memset(lAudio, 0, initialBufferSize * sizeof(float));
	memset(rAudio, 0, initialBufferSize * sizeof(float));
	
	
	ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
    
    
    
    
    resizing = false;
    
    
    
    
    
    sizeFactor = 60;
    
    
    
}




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






void testApp::audioRequested(float * output, int bufferSize, int nChannels){
    
    /*
     
     if( initialBufferSize != bufferSize ){
     ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
     return;
     }	
     //pan = 0.5f;
     float leftScale = .5;
     float rightScale = .5;
     
     
     
     for (int i = 0; i < bufferSize; i++){
     
     lAudio[i] = output[i*nChannels    ] = 0;
     rAudio[i] = output[i*nChannels + 1] = 0;
     
     }
     
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
     while (fingerPhase[freqNum] > TWO_PI)
     {
     fingerPhase[freqNum] -= TWO_PI;
     }
     
     
     fingerPhaseAdder[freqNum] = fingerPhaseAdderTarget[freqNum];
     
     for (int i = 0; i < bufferSize; i++){
     fingerPhase[freqNum] += fingerPhaseAdder[freqNum];
     float sample = sin(fingerPhase[freqNum]);
     lAudio[i] = output[i*nChannels    ] += sample * volume * leftScale / numDivide;
     rAudio[i] = output[i*nChannels + 1] += sample * volume * rightScale / numDivide;
     
     }
     
     }
     
     }
     
     
     */
	
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
    
    
    cout << hostName;
    cout << "\n";
    
    
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
    
    
    cout << hostName;
    cout << "\n";
    
    
    
}



//--------------------------------------------------------------
void testApp::update(){
	//we do a heartbeat on iOS as the phone will shut down the network connection to save power
	//this keeps the network alive as it thinks it is being used. 
	if( ofGetFrameNum() % 120 == 0 ){
        cout << "testing";
		ofxOscMessage m;
		m.setAddress( "/misc/heartbeat" );
		m.addIntArg( ofGetFrameNum() );
		sender.sendMessage( m );
	}
    
    
    
    
    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    
    if (changingIP == true)
    {
        
        ofSetColor(80, 80, 80);
        ofRect(0, 0, 1000, 2000);
        
        
        ofSetColor(225, 225, 225);
        verdana30.drawString("Current IP Sending To:", 195, 100);
        
        
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
            verdana30.drawString(hostName.substr(i, 1), i*30 + 170, 180);
            
        }
        
        ofSetColor(225,225,225);
        verdana30.drawString("Tap Numbers Below To Update IP", 108, 260);
        
        
        
        
        ofSetColor(225, 225, 225);
        verdana30.drawString("Current Port Sending To:", 190, 440);
        
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
            verdana30.drawString(portPrint.substr(i, 1), i*30 + 305, 520);
            
        }
        
        ofSetColor(225,225,225);
        verdana30.drawString("Tap Numbers Below To Update Port", 100, 600);
        
        
        
        
        for (int i = 0; i < 10; i++)
        {
            
            ofSetColor(30, 30, 30);
            ofRect(i*77 + 8, 305, 60, 60);
            
            ofSetColor(225,225,225);
            verdana30.drawString(ofToString(i), i * 77 + 28, 345);
            
            
        }
        
        
        
        
        for (int i = 0; i < 10; i++)
        {
            
            ofSetColor(30, 30, 30);
            ofRect(i*77 + 8, 645, 60, 60);
            
            ofSetColor(225,225,225);
            verdana30.drawString(ofToString(i), i * 77 + 28, 685);
            
            
        }
        
        
        
        
        
        
        ofSetColor(50, 50, 50);
        
        ofRect(700, BOTTOMSCREENCUTOFF, 200, 1000);
        
        ofSetColor(255, 255, 255);
        
        if (changingIP == true)
        {
            ofDrawBitmapString("Confirm", 706, BOTTOMSCREENCUTOFF + 65 );
            ofDrawBitmapString("IP", 725, BOTTOMSCREENCUTOFF + 85 );
            
        }
        else
        {
            ofDrawBitmapString("Change", 710, BOTTOMSCREENCUTOFF + 65 );
            ofDrawBitmapString("IP", 725, BOTTOMSCREENCUTOFF + 85 );
            
        }
        
        
        
    }
    else
    {
        
        
        ofSetColor(80, 80, 80);
        ofRect(0, 0, 1000, 2000);
        
        
        
        int numprinted = 0;
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
        ofDrawBitmapString("Ryan Daugherty's STAR Scholar Hexatonnetz MRPConnect, made with OpenFrameworks", 10, BOTTOMSCREENCUTOFF + 35);
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
            ofDrawBitmapString("Double tap with one finger to center the keys", 10, BOTTOMSCREENCUTOFF + 115);
            
        }
        
        
        ofSetColor(50, 50, 50);
        
        ofRect(700, BOTTOMSCREENCUTOFF, 200, 1000);
        
        ofSetColor(255, 255, 255);
        
        if (changingIP == true)
        {
            ofDrawBitmapString("Confirm", 705, BOTTOMSCREENCUTOFF + 65 );
            ofDrawBitmapString("IP", 725, BOTTOMSCREENCUTOFF + 85 );
            
        }
        else
        {
            ofDrawBitmapString("Change", 710, BOTTOMSCREENCUTOFF + 65 );
            ofDrawBitmapString("IP", 725, BOTTOMSCREENCUTOFF + 85 );
            
        }
        
    }
    
    
    
}




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





//--------------------------------------------------------------
void testApp::exit(){
    
}


//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    //args are x, y, id
    
    
    if (changingIP == true)
    {
        numFingersTouching++;
        
        
        
        if (touch.y >= 305 & touch.y <= 365)
        {
            
            for (int i = 0; i < 10; i++)
            {
                
                
                if ( touch.x >= i*77 + 8 && touch.x <= i*77 + 68)
                {
                    
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
                }
                
            }
            
            
            
            
            
        }
        
        
        if (touch.y >= 645 && touch.y <= 705)
        {
            
            
            
            for (int i = 0; i < 10; i++)
            {
                
                
                if ( touch.x >= i*77 + 8 && touch.x <= i*77 + 68)
                {
                    
                    int newPort;
                    
                    newPort = (int)(portName/(int)(pow(10.0, 5-(int)numOnPort)));
                    
                    newPort *= (int)pow(10.0, 5-(int)numOnPort);
                    
                    newPort += i * (pow(10.0, 4-(int)numOnPort));
                    
                    cout << i * (pow(10.0, 4-(int)numOnPort));
                    
                    newPort += (int)(portName%(int)(pow(10.0, 4-(int)numOnPort)));
                    
                    cout << (int)(portName%(int)(pow(10.0, 4-(int)numOnPort)));
                    
                    portName = newPort;
                    
                    numOnPort++;                    
                    if (numOnPort == 5)
                    {
                        numOnPort = 0;
                    }
                }
                
                
            }
            
        }
        
        
        if (touch.y > BOTTOMSCREENCUTOFF && numFingersTouching == 1)
        {
            
            if (touch.x < 700)
            {
            }
            else
            {
                removeLeadZero();
                sender.setup(hostName, portName);
                changingIP = !changingIP;
                switchFingerTouching = true;
            }
            
        }
        
        
    }
    else
    {
        
        numFingersTouching++;
        
        if (touch.y > BOTTOMSCREENCUTOFF && numFingersTouching == 1)
        {
            
            if (touch.x < 700)
            {
                resizing = !resizing;
                switchFingerTouching = true;
            }
            else
            {
                addLeadZero();
                changingIP = !changingIP;
                switchFingerTouching = true;
            }
            
        }
        else if (resizing ==true)
        {
            if (numFingersTouching == 1)
            {
                
                sideShiftCoreX = SIDESHIFT;
                sideShiftCoreY = TOPSHIFT;
                
                centerX = touch.x;
                centerY = touch.y;
                
            }
            
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
                
                
                else  if (hexList[i].isWithin(SIDELENGTH, touch.x, touch.y))
                {
                    hexList[i].press();
                    
                    ofxOscMessage m;
                    m.setAddress( "/mrp/midi" );
                    
                    m.addIntArg(144);
                    
                    m.addIntArg(i+24);
                    m.addIntArg(127);
                    
                    sender.sendMessage( m );
                    
                    
                    double newFreq;
                    
                    fingerTouching[touch.id] = i;
                    
                    
                    
                    newFreq = hexList[i].getFrequency();
                    cout << newFreq;
                    cout << "\n";
                    
                    if (fingerFrequencies[touch.id] != newFreq)
                    {
                        
                        fingerFrequencies[touch.id] = newFreq;
                        fingerPhase[touch.id] = 0;
                        fingerPhaseAdderTarget[touch.id] = (newFreq/ (float) sampleRate) * TWO_PI;       
                        fingerPhaseAdder[touch.id] = 0;
                        
                    }
                    
                    
                    break;
                }
            }
        }
        
    }
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    
    
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
        
        bool foundHex = false;
        
        if (resizing ==true )
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
            
            if (drag1valid == true && drag2valid == true && numFingersTouching == 2)
            {
                
                rescale();
                
            }
            
            if (numFingersTouching == 1  && switchFingerTouching == false && pinching == false)
            {
                
                SIDESHIFT = sideShiftCoreX - (centerX - touch.x);
                TOPSHIFT = sideShiftCoreY - (centerY - touch.y);
                relocate();
                
                
                
            }
        }
        else if (switchFingerTouching == false)
        {
            if ((hexList[fingerTouching[touch.id]].isWithin(SIDELENGTH, touch.x, touch.y)))
            {
                foundHex = true;
                //cout <<"HERE";
            }
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
                    
                    
                    else  if (hexList[i].isWithin(SIDELENGTH, touch.x, touch.y) && touch.id < TOUCHLIMIT)
                    {
                        hexList[fingerTouching[touch.id]].unPress();
                        
                        ofxOscMessage m;
                        m.setAddress( "/mrp/midi" );
                        
                        m.addIntArg(128);
                        
                        m.addIntArg(fingerTouching[touch.id]+24);
                        m.addIntArg(127);
                        
                        sender.sendMessage( m );
                        
                        hexList[i].press();
                        
                        ofxOscMessage n;
                        n.setAddress( "/mrp/midi" );
                        
                        n.addIntArg(144);
                        
                        n.addIntArg(i+24);
                        n.addIntArg(127);
                        
                        sender.sendMessage( n );
                        
                        
                        fingerTouching[touch.id] = i;
                        foundHex = true;
                        
                        
                        
                        
                        double newFreq;
                        
                        
                        
                        newFreq = hexList[i].getFrequency();
                        
                        if (fingerFrequencies[touch.id] != newFreq)
                        {
                            
                            cout << "HARK";
                            
                            fingerFrequencies[touch.id] = newFreq;
                            fingerPhase[touch.id] = 0;
                            fingerPhaseAdderTarget[touch.id] = (newFreq/ (float) sampleRate) * TWO_PI;       
                            fingerPhaseAdder[touch.id] = 0;
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        break;
                    }
                }
            }
        }
        
        
        
        
        if (foundHex == false)
        {
            
            fingerFrequencies[touch.id] = -1;
            fingerPhase[touch.id] = -1;
            fingerPhaseAdderTarget[touch.id] = -1;       
            fingerPhaseAdder[touch.id] = -1;
            
        }
        
    }
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    
    
    numFingersTouching--;
    
    if (numFingersTouching == 0)
    {
        switchFingerTouching = false;
    }
    
    if (fingerTouching[touch.id] == -1)
    {
        
    }
    else
    {
        hexList[fingerTouching[touch.id]].unPress();
        
        ofxOscMessage m;
        m.setAddress( "/mrp/midi" );
        
        m.addIntArg(128);
        
        m.addIntArg(fingerTouching[touch.id]+24);
        m.addIntArg(127);
        sender.sendMessage( m );
        
        
        
    }
    fingerTouching[touch.id] = -1;
    
    
    fingerFrequencies[touch.id] = -1;
    fingerPhase[touch.id] = -1;
    fingerPhaseAdderTarget[touch.id] = -1;       
    fingerPhaseAdder[touch.id] = -1;
    
    
    
    if (resizing == true)
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







//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    
    
    //center the screen, but only if one finger is touching
    //iOS has a nasty habit of confusing super quick pinches where the fingers begin incredibly close together for double taps
    if (resizing == true && touch.id == 0 && numFingersTouching == 0)
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


