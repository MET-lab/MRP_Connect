#ifndef _TEST_APP
#define _TEST_APP

#include "ofMain.h"
#include "ofxTuioClient.h"
#include "../MusicApp.h"

using namespace std;

class testApp : public ofBaseApp{
	
public:
	void setup();
	void update();
	void draw();
	
	void keyPressed  (int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y );
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void windowResized(int w, int h);
	
	ofxTuioClient myTuio;
	
	void touchDown(ofTouchEventArgs & touch);
	void touchUp(ofTouchEventArgs & touch);
	void touchMoved(ofTouchEventArgs & touch);

	DrawHandler drawHandler;
	TouchHandler touchHandler;
	SoundHandler soundHandler;
	void audioRequested(float * output, int bufferSize, int nChannels);
	
	void handleInstruface(Instruface & inst, const testApp* parentApp);

	Instruface testI1;
	Instruface testI2;
	//Instruface testI3;

private:
	
};

#endif
