#include "testApp.h"
#include <vector>

using namespace std;

//--------------------------------------------------------------
void testApp::setup(){
	ofBackground(50, 50, 50);
	ofSetVerticalSync(true);
	ofSetFrameRate(60);

	ofSetWindowShape(1024,768);
	ofSetWindowPosition(-1024,0);
	
	//Connect to Port
	myTuio.connect(3333);

	//Link handlers (better way? - annoying)
	drawHandler.soundHandler = &soundHandler;
	drawHandler.touchHandler = &touchHandler;
	soundHandler.drawHandler = &drawHandler;
	soundHandler.touchHandler = &touchHandler;
	touchHandler.drawHandler = &drawHandler;
	touchHandler.soundHandler = &soundHandler;

	//Assign Global TUIO Callback Functions
	ofAddListener(ofEvents.touchDown,this,&testApp::touchDown);
	ofAddListener(ofEvents.touchUp,this,&testApp::touchUp);
	ofAddListener(ofEvents.touchMoved,this,&testApp::touchMoved);

	testI1 = Instruface(0);
	testI2 = Instruface(1);
	//testI3 = Instruface(2);

	//Re finalize touchable objects?
	//YES! After allocating memory for all interfaces finalize the touchable objects!
	testI1.finalizeTouchableObjects();
	testI2.finalizeTouchableObjects();
	//testI3.finalizeTouchableObjects();

	handleInstruface(testI1,this);
	handleInstruface(testI2,this);
	//handleInstruface(testI3,this);

	testI1.moveCenterTo(300,300);
	testI2.moveCenterTo(300,300);
	//testI3.moveCenterTo(300,300);

	

	//Sound //Only do once
	soundHandler.setParentApp(this);
}

//--------------------------------------------------------------
void testApp::draw(){
	
	//render TUIO Cursors and Objects
	myTuio.drawCursors();
	myTuio.drawObjects();

	//Draw via handler
	drawHandler.draw();
}

void testApp::touchDown(ofTouchEventArgs & touch)
{
	//Handle via touch handler
	touchHandler.touchDown(touch);
}

void testApp::touchUp(ofTouchEventArgs & touch)
{
	//Handle via touch handler
	touchHandler.touchUp(touch);
}

void testApp::touchMoved(ofTouchEventArgs & touch)
{
	//Handle via touch handler
	touchHandler.touchMoved(touch);
}

void testApp::audioRequested(float * output, int bufferSize, int nChannels)
{
	//redo sound part of handling eahc time?
	//Use flag?

	//Handle via sound handler
	soundHandler.audioRequested(output,bufferSize,nChannels);
}

void testApp::handleInstruface(Instruface & inst, const testApp* parentApp)
{
	//Organize handle of drawing, touching and sound for instruface
	//Draw
	drawHandler.addScreenObjectToHandle(&inst);
	//Touch
	touchHandler.addTouchableObjectToHandle(&inst);
	//Sound
	soundHandler.ptrInstrufacesToHandle.push_back(&inst);
	/*Unneeded code?
	for(int i = 0; i< inst.getSoundActionRegionPtrs().size() ; i++)
	{
		//Allow region to access handler
		inst.getSoundActionRegionPtrs()[i]->associatedSoundHandlerPtr = &soundHandler;

		for(int j = 0; j < inst.getSoundActionRegionPtrs()[i]->soundActions.size() ; j++)
		{
			//Allow action to access handler
			inst.getSoundActionRegionPtrs()[i]->soundActions[j].associatedSoundHandlerPtr = &soundHandler;
		}
	}
	*/
}

//--------------------------------------------------------------
void testApp::update()
{
}

//--------------------------------------------------------------
void testApp::keyPressed(int key){

}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

