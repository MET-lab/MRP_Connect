#include "SoundHandler.h"


SoundHandler::SoundHandler(void)
{
	//Since the parent app is needed for the sound stream setup, the setup is done in the setParentApp method
}

SoundHandler::~SoundHandler(void)
{
}


int SoundHandler::getNumSoundActionsRequestingAudio()
{
	int rV = 0;
	int numInstrufaces = ptrInstrufacesToHandle.size();
	//Loop through the instrufaces
	for(int i = 0;  i < numInstrufaces ; i++)
	{
		//Loop through intruface SARs
		vector<SoundActionRegion*> listSARs = ptrInstrufacesToHandle[i]->getSoundActionRegionPtrs();
		int numSARs = listSARs.size();
		for(int j = 0; j < numSARs; j++)
		{
			vector<SoundAction*> listSAs = listSARs[j]->getSoundActionPtrs();
			int numSAs = listSAs.size();
			//Loop through the SAs within the SAR
			for(int k = 0; k < numSAs; k++)
			{
				if(listSAs[k]->isRequestingSynthAudio)
				{
					rV++;
				}
			}
		}
	}
	return rV;
}

void SoundHandler::setParentApp(ofBaseApp *parentApplication)
{
	ofSoundStreamSetup(outputChannels,inputChannels, parentApplication, sampleRate, bufferSize, numBuffers);
}

void SoundHandler::audioRequested(float * output, int bufferSize, int nChannels)
{
	int numInstrufaces = ptrInstrufacesToHandle.size();
	//Loop through the instrufaces
	for(int i = 0;  i < numInstrufaces ; i++)
	{
		//Loop through intruface SARs
		vector<SoundActionRegion*> listSARs = ptrInstrufacesToHandle[i]->getSoundActionRegionPtrs();
		int numSARs = listSARs.size();
		for(int j = 0; j < numSARs; j++)
		{
			if(listSARs[j]->needsAudioRequest())
			{
				
				//Old Loop - FAST?
				vector<SoundAction*> listSAs = listSARs[j]->getSoundActionPtrs();
				int numSAs = listSAs.size();
				int numSoundsPlaying = getNumSoundActionsRequestingAudio();
				//Loop through the SAs within the SAR
				for(int k = 0; k < numSAs; k++)
				{
					//Make sure SA is initialized by checking some default properties
					//Bug?
					//Synth was being requested by pure virtual uninitialized SA objects
					//This check helps stop them from calling a pure virtual function
					//Huge check to prevent


					//Double check?
					if(listSAs.size() == listSARs[j]->getSoundActionPtrs().size())
					{
						if(listSAs[k]->isRequestingSynthAudio)
						{
							if(listSAs[k]->associatedTouchID < -1 || listSAs[k]->getVolume()<0 || listSAs[k]->getVolume()>1)
							{
								cout << "Warning! SA exists in list but is uninitialized! Not playing audio." << endl;
							}
							else
							{
								//Play normally
								listSAs[k]->synthAudioRequested(output,bufferSize,nChannels,numSoundsPlaying,outputChannels,inputChannels,sampleRate,numBuffers);
							}
						}
					}
					else
					{
						cout << "Sound Actions changing too quickly. Error avoided." << endl;
					}

					
				}
			}
		}
	}
}

