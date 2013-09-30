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
    int lightestColor;
    int lighterColor;
    int darkestColor;
    int darkerColor;
    
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
    
    void draw(double SIDELENGTH, double SIDEPORTION)
    {
        //cout << "HEHEHE\n";   
        double innerDist = sqrt((2)*(((SIDELENGTH/SIDEPORTION)/1)*((SIDELENGTH/SIDEPORTION)/1)));
        
        
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
        
        
        
        if (SIDELENGTH > 500)
        {
            
            
            //combining all of top half into one color
            if (isPressed == true)
            {
                ofSetHexColor(darkestColor);
            }
            else
            {
                ofSetHexColor(lightestColor);
            }
            
            ofBeginShape();
            
            
            
            //upperrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
            
            //rightmost point
            ofVertex( x + SIDELENGTH + SIDELENGTH, y );
            
            //innerright point
            ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
            
            //innerrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
            
            //innerleftmost point
            ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
            
            //innerleft point
            ofVertex( x + innerDist, y );
            
            //leftmost point
            ofVertex( x, y );
            
            
            //upperleftmost point
            ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
            
            //upperrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
            
            ofEndShape();
            
            
            
            
            
            
            
            
            
            
            //bottom combined into color
            if (isPressed == true)
            {
                ofSetHexColor(lightestColor);
            }
            else
            {
                ofSetHexColor(darkestColor);
            }
            
            ofBeginShape();
            
            
            
            //leftmost point
            ofVertex( x, y );
            
            //innerleft point
            ofVertex( x + innerDist, y );
            
            //innerleftmost point
            ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            //innerrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            //inner right point
            ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
            
            //rightmost point
            ofVertex( x + SIDELENGTH + SIDELENGTH, y );
            
            //bottomrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );        
            
            
            //bottomleftmost point
            ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
            
            //leftmost point
            ofVertex( x, y );
            
            ofEndShape();
            
            
            
        }   
        
        
        
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
        
        
        
        if (SIDELENGTH > 500)
        {
            
            //top
            
            
            ofBeginShape();
            
            
            //upperrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
            
            //innerrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
            
            //innerleftmost point
            ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
            
            
            
            
            ofEndShape();
            
            
            
            
            
            //upperleft
            
            
            ofBeginShape();
            
            //leftmost point
            ofVertex( x, y );
            
            //innerleft point
            ofVertex( x + innerDist, y );
            
            //innerleftmost point
            ofVertex( x  + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION));
            
            
            //upperleftmost point
            ofVertex( x + (SIDELENGTH/2) , y - ((SIDELENGTH*sqrt(3)) / 2) );
            
            
            ofEndShape();
            
            
            
            
            //upper right 
            
            
            ofBeginShape();
            
            
            
            
            
            //rightmost point
            ofVertex( x + SIDELENGTH + SIDELENGTH, y );
            
            //innerright point
            ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
            
            //innerrightmost point
            ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
            
            
            ofEndShape();
            
            
            
            
            
            //lower right
            
            
            ofBeginShape();
            
            
            
            
            //bottomrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
            
            //innerrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            //inner right point
            ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
            
            
            
            
            ofEndShape();
            
            
            
            
            
            
            //bottom
            
            ofBeginShape();
            
            
            
            
            //bottomleftmost point
            ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
            
            //innerleftmost point
            ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            //innerrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            //bottomrightmost point
            ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
            
            
            ofEndShape();
            
            
            
            
            //lower left
            
            
            ofBeginShape();
            
            
            
            //innerleft point
            ofVertex( x + innerDist, y );
            
            //innerleftmost point
            ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
            
            
            ofEndShape();
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        /*
         
         //top
         if (isPressed == true)
         {
         ofSetHexColor(darkestColor);
         }
         else
         {
         ofSetHexColor(lightestColor);
         }
         
         ofBeginShape();
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         //upperleft
         
         if (isPressed == true)
         {
         ofSetHexColor(darkerColor);
         }
         else
         {
         ofSetHexColor(lighterColor);
         }
         
         ofBeginShape();
         
         //leftmost point
         ofVertex( x, y );
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2) , y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerleftmost point
         ofVertex( x  + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION));
         
         //innerleft point
         ofVertex( x + innerDist, y );
         
         //leftmost point
         ofVertex( x, y );
         
         ofEndShape();
         
         
         
         
         //upper right 
         if (isPressed == true)
         {
         ofSetHexColor(darkerColor);
         }
         else
         {
         ofSetHexColor(lighterColor);
         }
         
         ofBeginShape();
         
         
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         //innerright point
         ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
         
         //innerrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         
         
         
         
         //bottom
         if (isPressed == true)
         {
         ofSetHexColor(lightestColor);
         }
         else
         {
         ofSetHexColor(darkestColor);
         }
         
         ofBeginShape();
         
         
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //bottomleftmost point
         ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //innerrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         
         
         //lower left
         if (isPressed == true)
         {
         ofSetHexColor(lighterColor);
         }
         else
         {
         ofSetHexColor(darkerColor);
         }
         
         ofBeginShape();
         
         //leftmost point
         ofVertex( x, y );
         
         //innerleft point
         ofVertex( x + innerDist, y );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //bottomleftmost point
         ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //leftmost point
         ofVertex( x, y );
         
         ofEndShape();
         
         
         
         //lower right
         if (isPressed == true)
         {
         ofSetHexColor(lighterColor);
         }
         else
         {
         ofSetHexColor(darkerColor);
         }
         
         ofBeginShape();
         
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //inner right point
         ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         ofEndShape();
         
         */
        
        
        
        /*
         
         
         ofSetLineWidth(1);
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
         
         
         
         //top
         
         
         ofBeginShape();
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2), y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         
         
         
         //upperleft
         
         
         ofBeginShape();
         
         //leftmost point
         ofVertex( x, y );
         
         //upperleftmost point
         ofVertex( x + (SIDELENGTH/2) , y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerleftmost point
         ofVertex( x  + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION));
         
         //innerleft point
         ofVertex( x + innerDist, y );
         
         //leftmost point
         ofVertex( x, y );
         
         ofEndShape();
         
         
         
         
         //upper right 
         
         
         ofBeginShape();
         
         
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         //innerright point
         ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
         
         //innerrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y - ((SIDELENGTH*sqrt(3)) / 2) + (SIDELENGTH/SIDEPORTION) );
         
         //upperrightmost point
         ofVertex( x  + (SIDELENGTH/2) + SIDELENGTH, y - ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         
         
         
         
         //bottom
         
         ofBeginShape();
         
         
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //bottomleftmost point
         ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //innerrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION), y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         
         ofEndShape();
         
         
         
         
         //lower left
         
         
         ofBeginShape();
         
         //leftmost point
         ofVertex( x, y );
         
         //innerleft point
         ofVertex( x + innerDist, y );
         
         //innerleftmost point
         ofVertex( x + (SIDELENGTH/2) + (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //bottomleftmost point
         ofVertex( x + (SIDELENGTH/2), y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //leftmost point
         ofVertex( x, y );
         
         ofEndShape();
         
         
         
         //lower right
         
         
         ofBeginShape();
         
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         //bottomrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH, y + ((SIDELENGTH*sqrt(3)) / 2) );
         
         //innerrightmost point
         ofVertex( x + (SIDELENGTH/2) + SIDELENGTH - (SIDELENGTH/SIDEPORTION) , y + ((SIDELENGTH*sqrt(3)) / 2) - (SIDELENGTH/SIDEPORTION) );
         
         //inner right point
         ofVertex( x + SIDELENGTH + SIDELENGTH - innerDist, y );
         
         //rightmost point
         ofVertex( x + SIDELENGTH + SIDELENGTH, y );
         
         
         ofEndShape();
         
         
         
         */
        
        
        
        ofFill();
        
        ofSetHexColor(0xffffff);
        
        ofDrawBitmapString(title, x + SIDELENGTH - 8, y + 4);
        // cout << title;
        //cout << "\n";
        
    }
    
    void setInfo(string title_, int numFreq, int mult)
    {
        int colors[12];
        int darkerColors[12];
        int darkerColorsEdge[12];
        int darkestColorsEdge[12];
        int lighterColorsEdge[12];
        int lightestColorsEdge[12];
        
        
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
        
        darkerColorsEdge[0] = 0xcc0000; //c
        darkerColorsEdge[1] = 0x990000; //g
        darkerColorsEdge[2] = 0x660000; //d
        darkerColorsEdge[3] = 0x330000; //a
        darkerColorsEdge[4] = 0x0000cc; //e
        darkerColorsEdge[5] = 0x000099; //b
        darkerColorsEdge[6] = 0x000066; //gb
        darkerColorsEdge[7] = 0x000033; //db
        darkerColorsEdge[8] = 0x00cc00; //ab
        darkerColorsEdge[9] = 0x009900; //eb
        darkerColorsEdge[10] = 0x006600; //bb
        darkerColorsEdge[11] = 0x003300; //f
        
        darkestColorsEdge[0] = 0xbb0000; //c
        darkestColorsEdge[1] = 0x880000; //g
        darkestColorsEdge[2] = 0x550000; //d
        darkestColorsEdge[3] = 0x220000; //a
        darkestColorsEdge[4] = 0x0000bb; //e
        darkestColorsEdge[5] = 0x000088; //b
        darkestColorsEdge[6] = 0x000055; //gb
        darkestColorsEdge[7] = 0x000022; //db
        darkestColorsEdge[8] = 0x00bb00; //ab
        darkestColorsEdge[9] = 0x008800; //eb
        darkestColorsEdge[10] = 0x005500; //bb
        darkestColorsEdge[11] = 0x002200; //f
        
        lighterColorsEdge[0] = 0xff4444; //c
        lighterColorsEdge[1] = 0xdd0000; //g
        lighterColorsEdge[2] = 0xaa0000; //d
        lighterColorsEdge[3] = 0x770000; //a
        lighterColorsEdge[4] = 0x4444ff; //e
        lighterColorsEdge[5] = 0x0000dd; //b
        lighterColorsEdge[6] = 0x0000aa; //gb
        lighterColorsEdge[7] = 0x000077; //db
        lighterColorsEdge[8] = 0x44ff44; //ab
        lighterColorsEdge[9] = 0x00dd00; //eb
        lighterColorsEdge[10] = 0x00aa00; //bb
        lighterColorsEdge[11] = 0x007700; //f
        
        lightestColorsEdge[0] = 0xff8888; //c
        lightestColorsEdge[1] = 0xff0000; //g
        lightestColorsEdge[2] = 0xbb0000; //d
        lightestColorsEdge[3] = 0x880000; //a
        lightestColorsEdge[4] = 0x8888ff; //e
        lightestColorsEdge[5] = 0x0000ff; //b
        lightestColorsEdge[6] = 0x0000bb; //gb
        lightestColorsEdge[7] = 0x000088; //db
        lightestColorsEdge[8] = 0x88ff88; //ab
        lightestColorsEdge[9] = 0x00ff00; //eb
        lightestColorsEdge[10] = 0x00bb00; //bb
        lightestColorsEdge[11] = 0x008800; //f
        
        
        baseFrequencies[0] = 32.7;
        baseFrequencies[1] = 49;
        baseFrequencies[2] = 36.71;
        baseFrequencies[3] = 55;
        baseFrequencies[4] = 41.2;
        baseFrequencies[5] = 61.74;
        baseFrequencies[6] = 46.2;
        baseFrequencies[7] = 34.65;
        baseFrequencies[8] = 51.91;
        baseFrequencies[9] = 38.89;
        baseFrequencies[10] = 58.27;
        baseFrequencies[11] = 43.65;
        
        
        baseColor = colors[numFreq];
        darkerBaseColor = darkerColors[numFreq];
        lighterColor = lighterColorsEdge[numFreq];
        lightestColor = lightestColorsEdge[numFreq];
        darkerColor = darkerColorsEdge[numFreq];
        darkestColor = darkestColorsEdge[numFreq];
        
        frequency = baseFrequencies[numFreq] * ((double)mult + 1);
        
        
        
    }
    
    bool isWithin(double SIDELENGTH, int touchX, int touchY)
    {
        //if (insideHex(SIDELENGTH, touchX, touchY))
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
            cout << title;
            cout << "\n";
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
            return(FALSE);
        else
            return(TRUE);
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

double pinchCenterX, pinchCenterY;


double SIDELENGTH;

double INNERRECTLENGTH;

double SPACEBETWEENLENGTH;

int BIGGERNUMHOR;

int BIGGERNUMVERT;

double TOPMARGIN;

double SIDEMARGIN;

int TOUCHLIMIT;

int SIDESHIFT;

int TOPSHIFT;

int NUMNOTES;

int BOTTOMSCREENCUTOFF;





double SIDEPORTION;





bool modeChanging;




bool resizing;





int centerX;

int centerY;

int sideShiftCoreX;

int sideShiftCoreY;




int numFingersTouching;




int colors[12];

int baseColor;




double fingerFrequencies[10];

double fingerPhaseAdder[10];

double fingerPhaseAdderTarget[10];


double fingerPhase[10];

double soundLastMilli;



int fingerTouching[10];




double baseFrequencies[12];



string colorTitles[12];


double sizeFactor;




bool switchFingerTouching;

bool pinching;




double octaveMult;

int octaveAdder;

ofPoint drag1;
ofPoint drag2;

ofPoint drag1current;
ofPoint drag2current;

bool drag1valid;
bool drag2valid;




//--------------------------------------------------------------
void testApp::setup(){
    
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
    
    
    
    modeChanging = false;
    
    
    
    
    
    
    SIDEPORTION = 10;
    
    SIDELENGTH = 60;
    
    INNERRECTLENGTH = SIDELENGTH * sqrt(3);
    
    SPACEBETWEENLENGTH = SIDELENGTH/2;
    
    BIGGERNUMHOR = 4;
    
    BIGGERNUMVERT = 8;
    
    
    TOPMARGIN = (1024 - (8*INNERRECTLENGTH))/2;
    
    SIDEMARGIN = (752 - (8*SPACEBETWEENLENGTH) - (7*SIDELENGTH)) / 2;
    
    TOUCHLIMIT = 10;
    
    //NUMNOTES= 101;
    
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
    
    //hex values for colors
    
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
    
    baseFrequencies[0] = 32.7;
    baseFrequencies[1] = 49;
    baseFrequencies[2] = 36.71;
    baseFrequencies[3] = 55;
    baseFrequencies[4] = 41.2;
    baseFrequencies[5] = 61.74;
    baseFrequencies[6] = 46.2;
    baseFrequencies[7] = 34.65;
    baseFrequencies[8] = 51.91;
    baseFrequencies[9] = 38.89;
    baseFrequencies[10] = 58.27;
    baseFrequencies[11] = 43.65;
    
    
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
    
    
    
    octaveAdder = 0;
    
    
    
    
    drag1valid = false;
    drag2valid = false;
    
    pinching = false;
    
    
    soundLastMilli = ofGetElapsedTimeMillis();
    
    
    
    
    
    
    sampleRate 			= 44100;
	phaseAdder 			= 0.0f;
	phaseAdderTarget 	= 0.0;
	volume				= 0.3f;
	pan					= 0.5;
	
	//for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
	//so we do 512 - otherwise we crash
	//initialBufferSize	= 512;
	
    initialBufferSize = 1024;
    
    
	lAudio				= new float[initialBufferSize];
	rAudio				= new float[initialBufferSize];
	
	memset(lAudio, 0, initialBufferSize * sizeof(float));
	memset(rAudio, 0, initialBufferSize * sizeof(float));
	
	//we do this because we don't have a mouse move function to work with:
	targetFrequency = 444.0;
	phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
	
	ofSoundStreamSetup(2,0,this, sampleRate, initialBufferSize, 4);
	//ofSetFrameRate(60);
    
    
    
    
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
    
    
    
    
    
    
    if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	//pan = 0.5f;
	float leftScale = 1 - pan;
	float rightScale = pan;
    
    
    
    for (int i = 0; i < bufferSize; i++){
        
        lAudio[i] = output[i*nChannels    ] = 0;
        rAudio[i] = output[i*nChannels + 1] = 0;
        //            printf("%f   %f \n", lAudio[i], rAudio[i]);
        
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
            // sin (n) seems to have trouble when n is very large, so we
            // keep phase in the range of 0-TWO_PI like this:
            while (fingerPhase[freqNum] > TWO_PI)
            {
                fingerPhase[freqNum] -= TWO_PI;
            }
            //
            //printf("adder is %f \n", fingerPhaseAdder[freqNum]);
            //printf("adderTarget is %f \n", fingerPhaseAdderTarget[freqNum]);
            
            //fingerPhaseAdder[freqNum] = 0.95f * fingerPhaseAdder[freqNum] + 0.05f * fingerPhaseAdderTarget[freqNum];
            fingerPhaseAdder[freqNum] = fingerPhaseAdderTarget[freqNum];
            
            for (int i = 0; i < bufferSize; i++){
                fingerPhase[freqNum] += fingerPhaseAdder[freqNum];
                float sample = sin(fingerPhase[freqNum]);
                lAudio[i] = output[i*nChannels    ] += sample * volume * leftScale / numDivide;
                rAudio[i] = output[i*nChannels + 1] += sample * volume * rightScale / numDivide;
                //            printf("%f   %f \n", lAudio[i], rAudio[i]);
                
            }
            
        }
        
    }
    
	
}





//--------------------------------------------------------------
void testApp::update() {
    
    /*
    cout << SIDESHIFT;
    cout << "\n";
    cout << TOPSHIFT;
    cout << "\n";
    cout << "newline\n";
     */
	
}

//--------------------------------------------------------------
void testApp::draw() {
    
    
    /*
     
     ofSetColor( 70, 70, 70,  255);
     
     ofRect( -10, -10, 900, 1400 );
     
     ofSetColor(255, 255, 255);
     
     string limitText = "Limit ";
     limitText += ofToString(TOUCHLIMIT);
     limitText += " finger multitouch";
     
     ofDrawBitmapString(limitText, 10, 38);
     */
    
    
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
            hexList[i].draw(SIDELENGTH, SIDEPORTION);
            
        }
    }
    
    
    
    ofSetColor(120, 120,120);
    
    ofRect(-10, BOTTOMSCREENCUTOFF, 800, 200);
    
    ofSetColor(255, 255, 255);
    
    
    ofDrawBitmapString("Limit 10 finger multitouch", 10, BOTTOMSCREENCUTOFF + 15);
    ofDrawBitmapString("Ryan Daugherty's STAR Scholar Hexatonnetz Sin Wave Generator", 10, BOTTOMSCREENCUTOFF + 35);
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
        ofDrawBitmapString("Double tap to center the keys", 10, BOTTOMSCREENCUTOFF + 115);

    }
    
    //ofSetColor(255, 255, 255);
    //ofRect(SIDESHIFT, TOPSHIFT, 2, 2);
    
    
    /* 
     
     if (octaveAdder == -1)
     {
     ofSetColor(88, 88, 88);
     }
     else
     {
     ofSetColor(128, 128, 128);
     
     }
     
     ofRect( 513, 0, 70, 70 );
     
     if (octaveAdder == 0)
     {
     ofSetColor(88, 88, 88);
     }
     else
     {
     ofSetColor(128, 128, 128);
     
     }
     
     ofRect( 603, 0, 70, 70 );
     
     if (octaveAdder == 1)
     {
     ofSetColor(88, 88, 88);
     }
     else
     {
     ofSetColor(128, 128, 128);
     
     }
     
     ofRect( 693, 0, 70, 70 );
     
     
     
     ofSetColor(255, 255, 255);
     
     ofDrawBitmapString("Tap a button to change octave", 270, 38);
     
     ofDrawBitmapString("Low", 535, 38);
     
     ofDrawBitmapString("Mid", 623, 38);
     
     ofDrawBitmapString("High", 710, 38);
     
     
     
     ofSetColor(128, 128, 128);
     ofRect(0, 960, 900, 1400);
     ofSetColor(255, 255, 255);
     if (resizing == false)
     {
     ofDrawBitmapString( "Touch hexagons to play.  Tap here to change to resize mode." , 150, 995);
     
     }
     else
     {
     
     ofDrawBitmapString( "Drag two fingers together to shrink, apart to expand.  Tap here to change to play mode." , 40, 995);
     
     
     }
     */
    
}





void testApp::rescale()
{
    
    
    
    
    
    double difX, difY;
    
    difX = pinchCenterX - sideShiftCoreX;
    
    difY = sideShiftCoreY - pinchCenterY;
    
    
    double distance;
    
    distance = ofDist(pinchCenterX, pinchCenterY, SIDESHIFT, TOPSHIFT);
    
    double angle;
    
    angle = atan(difY/difX);
    
    if (difX > 0)
    {
        if (angle < 0)
        {
            angle = (2 *PI) + angle;
        }
    }
    else
    {
       
            angle = (PI) + angle;
        
            
    }
    
    /*
    
    cout << "ANGLE IS ";
    cout << angle;
    cout << "\n";
     
     */
    
    double sizeFactorOriginal = sizeFactor;

    
    
    
    double ratio;
    
    ratio = ofDist( drag1current.x, drag1current.y, drag2current.x, drag2current.y) / ofDist( drag1.x, drag1.y, drag2.x, drag2.y) ;
    

    if (ofDist( drag1.x, drag1.y, drag2.x, drag2.y) < 65)
    {
        ratio = (1 + ratio) / 2;
    }

    
    
    
    sizeFactor *= ratio;
    
    
    if (sizeFactor > 180)
    {
        sizeFactor = 180;
    }
    if (sizeFactor < 30)
    {
        sizeFactor = 30;
    }
    
    
    
    
    
    SIDELENGTH = floor(sizeFactor);
    
    
    INNERRECTLENGTH = SIDELENGTH * sqrt(3);
    
    SPACEBETWEENLENGTH = SIDELENGTH/2;
    
    BIGGERNUMHOR = 4;
    
    BIGGERNUMVERT = 8;
    
    
    int posInRow = 1;
    
    int rowIn = 0;
    
    
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
    
    
    
    
    /*
    difX *= sizeFactorOriginal/sizeFactor;
    
    difY *= sizeFactorOriginal/sizeFactor;
    int counter = 0;
    
if (ratio > 1)
{
    while ( difX > SIDESHIFT - pinchCenterX )
    {
        
        difX--;
        counter++;
    }
    for (int i = 0; i < counter; i++)
    {
        SIDESHIFT--;
    }
    counter = 0;
    
    while ( difY > TOPSHIFT - pinchCenterY )
    {
        cout << "HFHHFHFHFHF";
        cout << "\n";
        difY--;
        counter++;
    }
    
    for (int i = 0; i < counter; i++)
    {
        TOPSHIFT++;
    }
    
}
    else
    {
        
    }
    
     */
    
    distance = distance - (distance * (sizeFactorOriginal/sizeFactor));
    if (ratio > 1)
    {
    distance *= 1.1;
    }
    else
    {
        distance *= .9;
    }
    SIDESHIFT -= distance * cos(angle);
    
    /*
    cout << "CHANGE IN X IS ";
    cout << distance * cos(angle);
    cout << "\n";
     */
    
    TOPSHIFT += distance * sin(angle);
     
    /*
    cout << "CHANGE IN Y IS ";
    cout << distance * sin(angle);
    cout << "\n";
     */
    
    
    relocate();
    
    
    
    
    
    
    /*
     
     double difX, difY;
     
     difX = pinchCenterX - sideShiftCoreX;
     
     difY = sideShiftCoreY - pinchCenterY;
     
     
     double distance;
     
     distance = ofDist(pinchCenterX, pinchCenterY, sideShiftCoreX, sideShiftCoreY);
     
     double angle;
     
     angle = atan(difY/difX);
     
     if (difX > 0)
     {
     if (angle < 0)
     {
     angle = (2 *PI) + angle;
     }
     }
     else
     {
     
     angle = (PI) + angle;
     
     
     }
     
     cout << "ORIGINAL DISTANCE IS "; 
     cout << distance;
     cout << "\n";
     cout << "BIGGER DISTANCE IS "; 
     cout << (distance * (coreSize/SIDELENGTH));
     cout << "\n";
     
     distance = distance - (distance * (coreSize/SIDELENGTH));
     
     cout << "WERE GOING TO SHIFT THE DISTANCE BY "; 
     cout << distance;
     cout << "\n";
     
     
     cout << "SIDELENGTH IS ";
     cout << SIDELENGTH;
     cout << "\n";
     

    
    SIDESHIFT = sideShiftCoreX - (distance * cos(angle));
    

    
    TOPSHIFT = sideShiftCoreY + (distance * sin(angle));
    

    
    relocate();
     
     */
    
    
}





//--------------------------------------------------------------
void testApp::exit() {
    
}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
    
    numFingersTouching++;
    
    if (y > BOTTOMSCREENCUTOFF)
    {
        resizing = !resizing;
        switchFingerTouching = true;
        
    }
    else if (resizing ==true)
    {
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
        
        
        
        if (drag1valid == true && drag2valid == true)
        {
            
            pinching = true;
            pinchCenterX = floor((drag1current.x + drag2current.x)/2);
            pinchCenterY = floor((drag1current.y + drag2current.y)/2);
            sideShiftCoreX = SIDESHIFT;
            sideShiftCoreY = TOPSHIFT;
        }
        
        
    }
    else
    {
        cout << "touch registered";
        cout << "\n";
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
                fingerTouching[id] = i;
                break;
            }
        }
    }
    /*
     if (y > 0 && y < 70 )
     {
     
     
     if (x > 513 && x < 583 && octaveAdder != -1)
     {
     if (octaveAdder == 1)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] / 4;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     if (octaveAdder == 0)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] / 2;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     octaveAdder = -1;
     }
     if (x > 603 && x < 673 && octaveAdder != 0)
     {
     if (octaveAdder == 1)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] / 2;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     if (octaveAdder == -1)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] * 2;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     octaveAdder = 0;
     }
     if (x > 693 && x < 768 && octaveAdder != 1)
     {
     
     if (octaveAdder == -1)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] *4;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     if (octaveAdder == 0)
     {
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     if (fingerFrequencies[i] != -1)
     {
     double newFreq;
     newFreq = fingerFrequencies[i] *2;
     fingerFrequencies[i] = newFreq;
     fingerPhase[i] = 0;
     fingerPhaseAdderTarget[i] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[i] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     }
     
     }
     
     
     
     
     octaveAdder = 1;
     }
     
     }
     
     
     
     else if (y > 960)
     {
     resizing = !resizing;
     for (int i = 0; i < TOUCHLIMIT; i++)
     {
     fingerFrequencies[i] = -1;
     fingerPhase[i] = -1;
     fingerPhaseAdderTarget[i] = -1;       
     fingerPhaseAdder[i] = -1;
     
     }
     }
     else if (resizing == true)
     {
     
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
     
     }
     else if (resizing == false)
     {
     if (id < TOUCHLIMIT)
     {
     int numTouched;
     
     double newFreq;
     
     // numTouched = determineTouched(x, y);
     numTouched = 0;
     
     
     if (numTouched != -1)
     {
     
     newFreq = baseFrequencies[numTouched];
     for (int i = 0; i < octaveMult; i++)
     {
     newFreq *= 2;
     }
     if (fingerFrequencies[id] != newFreq)
     {
     
     fingerFrequencies[id] = newFreq;
     fingerPhase[id] = 0;
     fingerPhaseAdderTarget[id] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[id] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     //printf("%f", newFreq);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     }
     
     
     
     }
     
     } 
     }
     */
}




//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
    
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
        
        if (drag1valid == true && drag2valid == true && numFingersTouching == 2)
        {
            
            rescale();
            drag1 = drag1current;
            drag2 = drag2current;
            
        }
        
        if (numFingersTouching == 1  && switchFingerTouching == false && pinching == false)
        {
            
            SIDESHIFT = sideShiftCoreX - (centerX - x);
            TOPSHIFT = sideShiftCoreY - (centerY - y);
            relocate();
            
            
            
        }
    }
    else
    {
        if ((hexList[fingerTouching[id]].isWithin(SIDELENGTH, x, y)))
        {
            
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
                
                
                else  if (hexList[i].isWithin(SIDELENGTH, x, y))
                {
                    hexList[fingerTouching[id]].unPress();
                    hexList[i].press();
                    fingerTouching[id] = i;
                    break;
                }
            }
        }
    }
    /*
     if (resizing == true)
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
     
     if (drag1valid == true && drag2valid == true)
     {
     
     rescale();
     drag1 = drag1current;
     drag2 = drag2current;
     
     }
     
     
     
     }
     
     else if (resizing == false)
     {
     if (id < TOUCHLIMIT)
     {
     int numTouched;
     
     double newFreq;
     
     //numTouched = determineTouched(x, y);
     numTouched = 0;
     
     if (numTouched != -1)
     {
     
     newFreq = baseFrequencies[numTouched];
     for (int i = 0; i < octaveMult; i++)
     {
     newFreq *= 2;
     }
     if (fingerFrequencies[id] != newFreq)
     {
     
     cout << "HARK";
     
     fingerFrequencies[id] = newFreq;
     fingerPhase[id] = 0;
     fingerPhaseAdderTarget[id] = (newFreq/ (float) sampleRate) * TWO_PI;       
     fingerPhaseAdder[id] = 0;
     
     
     
     
     phaseAdder 			= 0.0f;
     phaseAdderTarget 	= 0.0;
     targetFrequency = newFreq;
     printf("%f", targetFrequency);
     phaseAdderTarget = (targetFrequency / (float) sampleRate) * TWO_PI;
     
     }
     
     
     
     }
     else
     {
     fingerFrequencies[id] = -1;
     fingerPhase[id] = -1;
     fingerPhaseAdderTarget[id] = -1;       
     fingerPhaseAdder[id] = -1;
     }
     
     
     }
     }
     */
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){
    
    
    numFingersTouching--;
    switchFingerTouching = false;
    
    if (fingerTouching[id] == -1)
    {
        
    }
    else
    {
        hexList[fingerTouching[id]].unPress();
        
    }
    fingerTouching[id] = -1;
    
    
    
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
    
    
    /*
     if (resizing == false)
     {
     fingerFrequencies[id] = -1;
     fingerPhase[id] = -1;
     fingerPhaseAdderTarget[id] = -1;       
     fingerPhaseAdder[id] = -1;
     }
     else if (resizing == true)
     {
     
     if (id == 0)
     {
     
     drag1valid = false;
     
     }
     
     if (id == 1)
     {
     
     drag2valid = false;
     
     }
     
     }
     */
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id){
    if (resizing == true)
    {
        
        //SIDESHIFT = ( (BIGGERNUMHOR/2) * (2*SIDELENGTH) ) + ( (BIGGERNUMHOR/4) * (SIDELENGTH) ) - (SIDELENGTH/2);
        
        
        SIDESHIFT =  (768/2) - (((BIGGERNUMHOR * 2 * SIDELENGTH) + ( (BIGGERNUMHOR - 1) * SIDELENGTH ))/2 ) ;
        
        
        
        TOPSHIFT = (BOTTOMSCREENCUTOFF / 2) + ((BIGGERNUMVERT * SIDELENGTH * sqrt(3))/2) + (SIDELENGTH * sqrt(3));
        
        
        //cout << SIDELENGTH;
        cout << "\n";
        cout << (BOTTOMSCREENCUTOFF / 2);
        cout << "\n";
        
        
        //SIDESHIFT = 0;
        //TOPSHIFT = 0;
        
        relocate();
        
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





