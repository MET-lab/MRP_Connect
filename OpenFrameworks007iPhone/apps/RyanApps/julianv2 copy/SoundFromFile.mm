#include "SoundFromFile.h"


SoundFromFile::SoundFromFile(void)
{
	loadAsAStream = false;
}

SoundFromFile::~SoundFromFile(void)
{
}

void SoundFromFile::start(int touchID)
{
	associatedTouchID = touchID;
	theSound.play();
}
void SoundFromFile::modify(float percentX, float percentY)
{

}
void SoundFromFile::end()
{
	theSound.stop();
}
bool SoundFromFile::isPlaying()
{
	return theSound.getIsPlaying();
}
void SoundFromFile::loadSound(string fileName, bool stream)
{
	theSound.loadSound(fileName,stream);
}
void SoundFromFile::unloadSound()
{
	theSound.unloadSound();
}
void SoundFromFile::setVolume(float vol)
{
	if(vol>1)
	{
		vol = 1;
	}

	if(vol < 0)
	{
		vol = 0;
	}
	volume = vol;
	theSound.setVolume(vol);
}
float SoundFromFile::getVolume()
{
	return volume;
}
void SoundFromFile::setPan(float pan)
{
	theSound.setPan(pan);
}
void SoundFromFile::setSpeed(float speed)
{
	theSound.setSpeed(speed);
}
void SoundFromFile::setPaused(bool bP)
{
	theSound.setPaused(bP);
}
void SoundFromFile::setLoop(bool bLp)
{
	theSound.setLoop(bLp);
}
void SoundFromFile::setMultiPlay(bool bMp)
{
	theSound.setMultiPlay(bMp);
}
void SoundFromFile::setPosition(float percent)
{
	theSound.setPosition(percent);
}
float SoundFromFile::getPosition()
{
	return theSound.getPosition();
}

float SoundFromFile::getSpeed()
{
	return theSound.getSpeed();
}
float SoundFromFile::getPan()
{
	return theSound.getPan();
}


void SoundFromFile::synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers)
{

}