#pragma message ("\tAttempting to open SoundFromSynth Header...")
#pragma once
#pragma message ("\tOpened SoundFromSynth Header.")
#include "SoundAction.h"
#include "ofMath.h"

class SoundFromSynth : public SoundAction
{
public:
	SoundFromSynth(void);
	~SoundFromSynth(void);

	//Params that can be modified using modify event
	//Volume
	//Duration
	//Freqeuncy
	//NumAdditiveSynthWaves


	void setVolume(float vol);
	float getVolume();

	void setPos(int pos);
	int getPos();

	void setDuration(float _duration_ms);
	float getDuration();

	void setNumAdditiveSynthWaves(float num);
	float getNumAdditiveSynthWaves();

	
	bool touchPostionChangesProperties;
	bool autoUpdateMIDINumber;
	//Properties that can be modified freely
	
	void setFrequency(float freq);
	float getFrequency();

	

	string getNoteNameFromFreq(float freq);
	int getMIDINumFromFreq(float freq);
	

	enum WAVE_SHAPE { 
		SINE, 
		SQUARE,
		TRIANGLE,
		SAW
	};
	WAVE_SHAPE waveShape;

	enum ADDITIVE_SYNTH_WEIGHT_TYPE{
		DECREASING_HARMONIC_SERIES,
		INCREASING_HARMONIC_SERIES,
		EQUAL_WEIGHTS
	};
	ADDITIVE_SYNTH_WEIGHT_TYPE additiveSynthWeightType;

	enum ADDITIVE_SYNTH_FREQ_SELECTION{
		OCTAVES,
		HARMONICS,
	};
	ADDITIVE_SYNTH_FREQ_SELECTION additiveSynthFreqSelection;

	enum CONTROL_PARAM{
		VOLUME,
		DURATION,
		FREQUENCY,
		NUM_WAVES
	};
	CONTROL_PARAM xAxisControlParam;
	CONTROL_PARAM yAxisControlParam;
	vector<float> xAxisTaylorSeries;
	vector<float> yAxisTaylorSeries;
	void setValue(SoundFromSynth::CONTROL_PARAM controlParam, float value);


	//IMplmentations of abstract items from SoundAction class
	void start(int touchID);
	void modify(float percentX, float percentY);
	void end();
	bool isPlaying();
	//All SAs request synth - only from syth SAs respond
	void synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers);
	


protected:
	int position;
	float getSynthSample(int position, float frequency, float sampleRate);
	//float getHarmonicSeriesSynthSample(int position, float fundamentalFrequency, float sampleRate, int numSynthIterations);
	//float getHarmonicSeriesOctavesIncreasingSynthSample(int position, float fundamentalFrequency, float sampleRate, int numSynthIterations);

	float getAdditiveSynthSample(int position, float fundamentalFrequency, float sampleRate, int numSynthIterations);

	float getSineSample(int position, float frequency, float sampleRate); 
	float getSquareSample(int position, float frequency, float sampleRate);
	float getTriangleSample(int position, float frequency, float sampleRate);
	float getSawSample(int position, float frequency, float sampleRate);

	/*
	float getInvSine(int position, float frequency, float sampleRate); 
	float getInvSquare(int position, float frequency, float sampleRate);
	float getInvTriangleSampl(int position, float frequency, float sampleRate);
	float getInvSaw(int position, float frequency, float sampleRate);
	*/

	float _continousFrequency;
	float iterationsToMilliseconds(int iterations, float sampleRate);
	void emptyOutput(float * output, int bufferSize, int nChannels);
	

	float getValueFromSeries(float var, vector<float> & series);

private:
	float frequency;
	float SYSTEM_VOLUME_SCALER; //Writing to buffer is much louder than playing clips
	float duration_ms;
	float numAdditiveSynthWaves; //Single wave default

};

