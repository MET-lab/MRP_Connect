#pragma message ("\tAttempting to open SoundAction Header...")
#pragma once
#pragma message ("\tOpened SoundAction Header.")
//Resolve mutual dependencies
class SoundHandler;

#include <string>
#include <map>
#include <math.h>
//#include "SoundHandler.h"
//Debug
#include <iostream>
#include <fstream>

using namespace std;

class SoundAction
{
public:
	bool isRequestingSynthAudio;
	float acceptableFrequencyErrorPercent;
	
	int associatedTouchID;
	int midiNum;
	map<string,float> noteNameToFrequency; //Include map from musical note -> Freq (hz)
	map<int,float> midiNumberToFrequency;
	SoundAction(void);
	~SoundAction(void);

	//Abstract things
	//Nevermind  - pure virtual functions were being called - Bug?
	//Make functions just virtual to avoid errors - cheap work around for now
	virtual void start(int touchID);
	virtual void modify(float percentX, float percentY);
	virtual void end();
	virtual bool isPlaying();
	virtual void setVolume(float vol);
	virtual float getVolume();
	//All SAs request synth - only from syth SAs respond
	virtual void synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers);
	
private:

protected:
	float volume;
};

