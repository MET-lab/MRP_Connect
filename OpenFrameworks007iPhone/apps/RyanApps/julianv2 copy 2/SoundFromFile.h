#pragma message ("\tAttempting to open SoundFromFile Header...")
#pragma once
#pragma message ("\tOpened SoundFromFile Header.")
#include "SoundAction.h"
#include "ofSoundPlayer.h"

class SoundFromFile : public SoundAction
{
public:
	string fileName;

	SoundFromFile(void);
	~SoundFromFile(void);

	//IMplmentations of abstract items from SoundAction class
	void start(int touchID);
	void modify(float percentX, float percentY);
	void end();
	bool isPlaying();
	//All SAs request synth - only from syth SAs respond
	void synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers);
	

	//Reproduce functionality ofSoundPlayer
	bool loadAsAStream;
	void loadSound(string fileName, bool stream);
	void unloadSound();
	void setVolume(float vol);
	float getVolume();
	void setPan(float pan);
	void setSpeed(float speed);
	void setPaused(bool bP);
	void setLoop(bool bLp);
	void setMultiPlay(bool bMp);
	void setPosition(float percent);
	float getPosition();
	float getSpeed();
	float getPan();

private:
	ofSoundPlayer theSound;

};

