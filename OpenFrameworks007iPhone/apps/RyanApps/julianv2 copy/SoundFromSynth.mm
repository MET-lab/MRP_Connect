#include "SoundFromSynth.h"


SoundFromSynth::SoundFromSynth(void)
{
	//Set defaults
	numAdditiveSynthWaves = 1;//Single wave default
	waveShape = SoundFromSynth::WAVE_SHAPE::SINE; //Sine default
	additiveSynthWeightType = SoundFromSynth::ADDITIVE_SYNTH_WEIGHT_TYPE::DECREASING_HARMONIC_SERIES; // Freq goes up, weight goes down
	additiveSynthFreqSelection = SoundFromSynth::ADDITIVE_SYNTH_FREQ_SELECTION::OCTAVES; //Sounds nicer
	touchPostionChangesProperties = false;
	autoUpdateMIDINumber = true;
	frequency = 0;
	duration_ms = -1; //Default infinite duration
	SYSTEM_VOLUME_SCALER = .15; //Writing to buffer is much louder than playing clips
}


SoundFromSynth::~SoundFromSynth(void)
{
}

string SoundFromSynth::getNoteNameFromFreq(float freq)
{
	map<string,float>::iterator it;
	for(it = noteNameToFrequency.begin(); it != noteNameToFrequency.end(); it++) 
	{
		if( (abs(it->second - freq)/ it->second)*100 < acceptableFrequencyErrorPercent)
		{
			return it->first;
		}
	}
	return "";
}

int SoundFromSynth::getMIDINumFromFreq(float freq)
{
	map<int,float>::iterator it;
	for(it = midiNumberToFrequency.begin(); it != midiNumberToFrequency.end(); it++) 
	{
		if( (abs(it->second - freq)/ it->second)*100 < acceptableFrequencyErrorPercent)
		{
			return it->first;
		}
	}
	return -1;
}


void SoundFromSynth::start(int touchID)
{
	isRequestingSynthAudio = true;
	associatedTouchID = touchID;
}
void SoundFromSynth::modify(float percentX, float percentY)
{
	if(touchPostionChangesProperties)
	{
		//Change this if too slow
		//Check for modify params
		float * x;
		float * y;
		float dummy = 0;

		float newXParamValue = getValueFromSeries(percentX,xAxisTaylorSeries);
		float newYParamValue = getValueFromSeries(percentY,yAxisTaylorSeries);

		setValue(xAxisControlParam,newXParamValue);
		setValue(yAxisControlParam,newYParamValue);
	}

	//Old code
	/*
	if(touchPostionChangesProperties)
	{
		//Modify this to have varible property management
		volume = percentY;
		float n = (percentX*87.0 + 1.0);
		frequency = 440.0 * pow(2.0,((percentX*87.0 + 1.0)-49.0)/12.0);
	}
	*/
}

void SoundFromSynth::setValue(SoundFromSynth::CONTROL_PARAM controlParam, float value)
{
	if(controlParam == SoundFromSynth::CONTROL_PARAM::DURATION)
	{
		setDuration(value);
	}
	else if(controlParam == SoundFromSynth::CONTROL_PARAM::FREQUENCY)
	{
		setFrequency(value);
	}
	else if(controlParam == SoundFromSynth::CONTROL_PARAM::NUM_WAVES)
	{
		setNumAdditiveSynthWaves(value);
	}
	else if(controlParam == SoundFromSynth::CONTROL_PARAM::VOLUME)
	{
		setVolume(value);
	}
	else
	{
		//Do nothing
	}
}

void SoundFromSynth::setDuration(float _duration_ms)
{
	duration_ms = _duration_ms;
}
float SoundFromSynth::getDuration()
{
	return duration_ms;
}

void SoundFromSynth::setNumAdditiveSynthWaves(float num)
{
	numAdditiveSynthWaves = num;
}
float SoundFromSynth::getNumAdditiveSynthWaves()
{
	return numAdditiveSynthWaves;
}

float SoundFromSynth::getValueFromSeries(float var, vector<float> & series)
{
	float rV = 0;
	int vecSize = series.size();
	for(int i = 0; i < vecSize; i++)
	{
		//coeff * value ^0
		rV += series[i] * pow(var,i);
	}
	return rV;
}

void SoundFromSynth::end()
{
	isRequestingSynthAudio = false;
}
bool SoundFromSynth::isPlaying()
{
	return isRequestingSynthAudio;
}

float SoundFromSynth::getVolume()
{
	return volume;
}
void SoundFromSynth::setVolume(float vol)
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
}

void SoundFromSynth::setPos(int pos)
{
	position = pos;
}
int SoundFromSynth::getPos()
{
	return position;
}

void SoundFromSynth::setFrequency(float freq)
{
	//DO DISCONTINUITY FIXING HERE!
	float oldF = getFrequency();
	float newF = freq;

	if(autoUpdateMIDINumber)
	{
		//Do a search in MIDI number to FREQ map
		midiNum = getMIDINumFromFreq(newF);
	}



	float newPos = getPos()*(oldF/newF);
	setPos(newPos);

	if(freq < 0)
	{
		freq = 0;
	}
	frequency = freq;
}
/*
float SoundFromSynth::getInvSine(int position, float frequency, float sampleRate)
{
	
	
	//Sample
	//return sin( position * frequency / sampleRate * TWO_PI);
}
float SoundFromSynth::getInvSquare(int position, float frequency, float sampleRate)
{
}
float SoundFromSynth::getInvTriangleSampl(int position, float frequency, float sampleRate)
{
}
float SoundFromSynth::getInvSaw(int position, float frequency, float sampleRate)
{
}
*/


float SoundFromSynth::getFrequency()
{
	return frequency;
}


void SoundFromSynth::synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers)
{
	//Correct to avoid by 0 divide
	if(numSoundActionsPlaying == 0)
	{
		numSoundActionsPlaying = 1;
	}

	//Correct incorrect frequency values
	if(getFrequency() > 22000 || getFrequency() < 0)
	{
		setFrequency(0);
	}

	//Determine if sampling loop should run
	//Has been running for too long?
	bool loopShouldRun = true;
	if(duration_ms > 0) // Duration is not negative (negative means infinite duration)
	{
		//Detemine if loop should run
		if(iterationsToMilliseconds(position,sampleRate) <= duration_ms)
		{
			loopShouldRun = true;
		}
		else
		{
			loopShouldRun = false;
		}
	}
	//Debug
	if(!loopShouldRun)
	{
		cout << "Synth sound ending - past specified duration" << endl;
	}


	if(loopShouldRun)
	{
		for (int i = 0; i < bufferSize; i++)
		{
			float sample = 0;

			if(numAdditiveSynthWaves > 1)
			{
				sample = getAdditiveSynthSample(position,frequency,sampleRate,(int)numAdditiveSynthWaves);
			}
			else //Single wave
			{
				//Get sample once
				sample = getSynthSample(position,frequency,sampleRate);
			}

			//Output to speakers
			position++;
			output[i*nChannels] += sample * volume * SYSTEM_VOLUME_SCALER / numSoundActionsPlaying;
			output[i*nChannels +1] += sample * volume * SYSTEM_VOLUME_SCALER / numSoundActionsPlaying;
		}
	}
}

float SoundFromSynth::getAdditiveSynthSample(int position, float fundamentalFrequency, float sampleRate, int numSynthIterations)
{
	float sample = 0;
	//Loop through freq multiples and weights -> 1 1/2 1/3 1/4 ...
	for(int i = 1; i <= numSynthIterations + 1; i++)
	{
		float weight = (1.0/(float)(i));
		float partialSample = getSynthSample(position,fundamentalFrequency * pow(2.0, i),sampleRate);

		sample += (partialSample * weight);
	}
	return sample * (2/PI);
}

float SoundFromSynth::getSynthSample(int position, float frequency, float sampleRate)
{
	//Get the proper sample given wave type
	if(waveShape == SoundFromSynth::WAVE_SHAPE::SAW)
	{
		return getSawSample(position,frequency,sampleRate);
	}
	else if(waveShape == SoundFromSynth::WAVE_SHAPE::SQUARE)
	{
		return getSquareSample(position,frequency,sampleRate);
	}
	else if(waveShape == SoundFromSynth::WAVE_SHAPE::TRIANGLE)
	{
		return getTriangleSample(position,frequency,sampleRate);
	}
	else
	{
		//Default to sine
		return getSineSample(position,frequency,sampleRate);
	}
	return 0;
}

float SoundFromSynth::getSineSample(int position, float frequency, float sampleRate)
{
	//cout << "Sine sample: " << frequency << endl;

	return sin( position * frequency / sampleRate * TWO_PI);
}
float SoundFromSynth::getSquareSample(int position, float frequency, float sampleRate)
{
	//Fix this!
	return sin( position * frequency / sampleRate * TWO_PI);
}
float SoundFromSynth::getTriangleSample(int position, float frequency, float sampleRate)
{
	//Fix this!
	return sin( position * frequency / sampleRate * TWO_PI);
}
float SoundFromSynth::getSawSample(int position, float frequency, float sampleRate)
{
	//Fix this!
	return sin( position * frequency / sampleRate * TWO_PI);
}

float SoundFromSynth::iterationsToMilliseconds(int iterations, float sampleRate)
{
	//FIX THIS! (PROBABLY WRONG!)
	return (iterations/sampleRate) * 1000.0;
}

void SoundFromSynth::emptyOutput(float * output, int bufferSize, int nChannels)
{
	//Do nothing blank sound
	for (int i = 0; i < bufferSize; i++)
	{
		output[i*nChannels] = 0;
		output[i*nChannels +1] = 0;
    }
}