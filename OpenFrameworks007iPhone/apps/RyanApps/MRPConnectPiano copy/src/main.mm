#include "ofMain.h"
#include "testApp.h"

//don't touch this file, it's here to do OpenFrameworks things.  All relevant code is in testApp.mm and testApp.h

int main(){
	ofSetupOpenGL(1024,768, OF_FULLSCREEN);			// <-------- setup the GL context
	ofRunApp(new testApp);
}
