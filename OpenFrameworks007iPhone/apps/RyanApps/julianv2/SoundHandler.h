#pragma message ("\tAttempting to open SoundHandler Header...")
#pragma once
#pragma message ("\tOpened SoundHandler Header.")
//Resolve mutual dependencies
class TouchHandler;
class DrawHandler;
class Instruface;
class SoundAction;

#include <vector>
#include "SoundAction.h"
#include "ofBaseApp.h"
#include "ofSoundStream.h"
#include "TouchHandler.h"
#include "DrawHandler.h"
#include "Instruface.h"

using namespace std;



class SoundHandler
{
public:
	SoundHandler(void);
	vector<SoundAction*> ptrSoundActionsToHandle;

	void setParentApp(ofBaseApp *parentApplication);

	static const int outputChannels = 2;
	static const int inputChannels = 0;
	static const int sampleRate = 22050;
	static const int bufferSize = 256;
	static const int numBuffers = 4;

	void audioRequested(float * output, int bufferSize, int nChannels);

	int getNumSoundActionsRequestingAudio();

	vector<Instruface*> ptrInstrufacesToHandle;

	~SoundHandler(void);

	//Link to other handlers
	TouchHandler * touchHandler;
	DrawHandler * drawHandler;

private:

};
