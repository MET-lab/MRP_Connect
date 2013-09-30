#include "SoundAction.h"
#include "ofMath.h"


SoundAction::SoundAction(void)
{
	//Initialize variables
	isRequestingSynthAudio = false;
	volume = 1;
	associatedTouchID = -1;
	acceptableFrequencyErrorPercent = 1.0;
	midiNum = -1;

	//Initialize list of note frequencies
	noteNameToFrequency.insert(make_pair("C1",32.7));
	noteNameToFrequency.insert(make_pair("Db1",34.65));
	noteNameToFrequency.insert(make_pair("D1",36.71));
	noteNameToFrequency.insert(make_pair("Eb1",38.89));
	noteNameToFrequency.insert(make_pair("E1",41.2));
	noteNameToFrequency.insert(make_pair("F1",43.65));
	noteNameToFrequency.insert(make_pair("Gb1",46.25));
	noteNameToFrequency.insert(make_pair("G1",49));
	noteNameToFrequency.insert(make_pair("Ab1",51.91));
	noteNameToFrequency.insert(make_pair("A1",55));
	noteNameToFrequency.insert(make_pair("Bb1",58.27));
	noteNameToFrequency.insert(make_pair("B1",61.74));
	noteNameToFrequency.insert(make_pair("C2",65.41));
	noteNameToFrequency.insert(make_pair("Db2",69.3));
	noteNameToFrequency.insert(make_pair("D2",73.42));
	noteNameToFrequency.insert(make_pair("Eb2",77.78));
	noteNameToFrequency.insert(make_pair("E2",82.41));
	noteNameToFrequency.insert(make_pair("F2",87.31));
	noteNameToFrequency.insert(make_pair("Gb2",92.5));
	noteNameToFrequency.insert(make_pair("G2",98));
	noteNameToFrequency.insert(make_pair("Ab2",103.83));
	noteNameToFrequency.insert(make_pair("A2",110));
	noteNameToFrequency.insert(make_pair("Bb2",116.54));
	noteNameToFrequency.insert(make_pair("B2",123.47));
	noteNameToFrequency.insert(make_pair("C3",130.81));
	noteNameToFrequency.insert(make_pair("Db3",138.59));
	noteNameToFrequency.insert(make_pair("D3",146.83));
	noteNameToFrequency.insert(make_pair("Eb3",155.56));
	noteNameToFrequency.insert(make_pair("E3",164.81));
	noteNameToFrequency.insert(make_pair("F3",174.61));
	noteNameToFrequency.insert(make_pair("Gb3",185));
	noteNameToFrequency.insert(make_pair("G3",196));
	noteNameToFrequency.insert(make_pair("Ab3",207.65));
	noteNameToFrequency.insert(make_pair("A3",220));
	noteNameToFrequency.insert(make_pair("Bb3",233.08));
	noteNameToFrequency.insert(make_pair("B3",246.94));
	noteNameToFrequency.insert(make_pair("C4",261.63));
	noteNameToFrequency.insert(make_pair("Db4",277.18));
	noteNameToFrequency.insert(make_pair("D4",293.66));
	noteNameToFrequency.insert(make_pair("Eb4",311.13));
	noteNameToFrequency.insert(make_pair("E4",329.63));
	noteNameToFrequency.insert(make_pair("F4",349.23));
	noteNameToFrequency.insert(make_pair("Gb4",369.99));
	noteNameToFrequency.insert(make_pair("G4",392));
	noteNameToFrequency.insert(make_pair("Ab4",415.3));
	noteNameToFrequency.insert(make_pair("A4",440));
	noteNameToFrequency.insert(make_pair("Bb4",466.16));
	noteNameToFrequency.insert(make_pair("B4",493.88));
	noteNameToFrequency.insert(make_pair("C5",523.25));
	noteNameToFrequency.insert(make_pair("Db5",554.37));
	noteNameToFrequency.insert(make_pair("D5",587.33));
	noteNameToFrequency.insert(make_pair("Eb5",622.25));
	noteNameToFrequency.insert(make_pair("E5",659.26));
	noteNameToFrequency.insert(make_pair("F5",698.46));
	noteNameToFrequency.insert(make_pair("Gb5",739.99));
	noteNameToFrequency.insert(make_pair("G5",783.99));
	noteNameToFrequency.insert(make_pair("Ab5",830.61));
	noteNameToFrequency.insert(make_pair("A5",880));
	noteNameToFrequency.insert(make_pair("Bb5",932.33));
	noteNameToFrequency.insert(make_pair("B5",987.77));
	noteNameToFrequency.insert(make_pair("C6",1046.5));
	noteNameToFrequency.insert(make_pair("Db6",1108.73));
	noteNameToFrequency.insert(make_pair("D6",1174.66));
	noteNameToFrequency.insert(make_pair("Eb6",1244.51));
	noteNameToFrequency.insert(make_pair("E6",1318.51));
	noteNameToFrequency.insert(make_pair("F6",1396.91));
	noteNameToFrequency.insert(make_pair("Gb6",1479.98));
	noteNameToFrequency.insert(make_pair("G6",1567.98));
	noteNameToFrequency.insert(make_pair("Ab6",1661.22));
	noteNameToFrequency.insert(make_pair("A6",1760));
	noteNameToFrequency.insert(make_pair("Bb6",1864.66));
	noteNameToFrequency.insert(make_pair("B6",1975.53));
	noteNameToFrequency.insert(make_pair("C7",2093));
	noteNameToFrequency.insert(make_pair("Db7",2217.46));
	noteNameToFrequency.insert(make_pair("D7",2349.32));
	noteNameToFrequency.insert(make_pair("Eb7",2489.02));
	noteNameToFrequency.insert(make_pair("E7",2637.02));
	noteNameToFrequency.insert(make_pair("F7",2793.83));
	noteNameToFrequency.insert(make_pair("Gb7",2959.96));
	noteNameToFrequency.insert(make_pair("G7",3135.96));
	noteNameToFrequency.insert(make_pair("Ab7",3322.44));
	noteNameToFrequency.insert(make_pair("A7",3520));
	noteNameToFrequency.insert(make_pair("Bb7",3729.31));
	noteNameToFrequency.insert(make_pair("B7",3951.07));
	noteNameToFrequency.insert(make_pair("C8",4186.01));
	noteNameToFrequency.insert(make_pair("Db8",4434.92));
	noteNameToFrequency.insert(make_pair("D8",4698.64));
	noteNameToFrequency.insert(make_pair("Eb8",4978.03));
	//Also include sharps
	noteNameToFrequency.insert(make_pair("C#1",34.65));
	noteNameToFrequency.insert(make_pair("D#1",38.89));
	noteNameToFrequency.insert(make_pair("F#1",46.25));
	noteNameToFrequency.insert(make_pair("G#1",51.91));
	noteNameToFrequency.insert(make_pair("A#1",58.27));
	noteNameToFrequency.insert(make_pair("C#2",69.3));
	noteNameToFrequency.insert(make_pair("D#2",77.78));
	noteNameToFrequency.insert(make_pair("F#2",92.5));
	noteNameToFrequency.insert(make_pair("G#2",103.83));
	noteNameToFrequency.insert(make_pair("A#2",116.54));
	noteNameToFrequency.insert(make_pair("C#3",138.59));
	noteNameToFrequency.insert(make_pair("D#3",155.56));
	noteNameToFrequency.insert(make_pair("F#3",185));
	noteNameToFrequency.insert(make_pair("G#3",207.65));
	noteNameToFrequency.insert(make_pair("A#3",233.08));
	noteNameToFrequency.insert(make_pair("C#4",277.18));
	noteNameToFrequency.insert(make_pair("D#4",311.13));
	noteNameToFrequency.insert(make_pair("F#4",369.99));
	noteNameToFrequency.insert(make_pair("G#4",415.3));
	noteNameToFrequency.insert(make_pair("A#4",466.16));
	noteNameToFrequency.insert(make_pair("C#5",554.37));
	noteNameToFrequency.insert(make_pair("D#5",622.25));
	noteNameToFrequency.insert(make_pair("F#5",739.99));
	noteNameToFrequency.insert(make_pair("G#5",830.61));
	noteNameToFrequency.insert(make_pair("A#5",932.33));
	noteNameToFrequency.insert(make_pair("C#6",1108.73));
	noteNameToFrequency.insert(make_pair("D#6",1244.51));
	noteNameToFrequency.insert(make_pair("F#6",1479.98));
	noteNameToFrequency.insert(make_pair("G#6",1661.22));
	noteNameToFrequency.insert(make_pair("A#6",1864.66));
	noteNameToFrequency.insert(make_pair("C#7",2217.46));
	noteNameToFrequency.insert(make_pair("D#7",2489.02));
	noteNameToFrequency.insert(make_pair("F#7",2959.96));
	noteNameToFrequency.insert(make_pair("G#7",3322.44));
	noteNameToFrequency.insert(make_pair("A#7",3729.31));
	noteNameToFrequency.insert(make_pair("C#8",4434.92));
	noteNameToFrequency.insert(make_pair("D#8",4978.03));



	//Include midi number map
	midiNumberToFrequency.insert(make_pair(0,8.1757989156));
	midiNumberToFrequency.insert(make_pair(1,8.661957218));
	midiNumberToFrequency.insert(make_pair(2,9.1770239974));
	midiNumberToFrequency.insert(make_pair(3,9.7227182413));
	midiNumberToFrequency.insert(make_pair(4,10.3008611535));
	midiNumberToFrequency.insert(make_pair(5,10.9133822323));
	midiNumberToFrequency.insert(make_pair(6,11.5623257097));
	midiNumberToFrequency.insert(make_pair(7,12.2498573744));
	midiNumberToFrequency.insert(make_pair(8,12.9782717994));
	midiNumberToFrequency.insert(make_pair(9,13.75));
	midiNumberToFrequency.insert(make_pair(10,14.5676175474));
	midiNumberToFrequency.insert(make_pair(11,15.4338531643));
	midiNumberToFrequency.insert(make_pair(36,65.4063913251));
	midiNumberToFrequency.insert(make_pair(37,69.2956577442));
	midiNumberToFrequency.insert(make_pair(38,73.4161919794));
	midiNumberToFrequency.insert(make_pair(39,77.7817459305));
	midiNumberToFrequency.insert(make_pair(40,82.4068892282));
	midiNumberToFrequency.insert(make_pair(41,87.3070578583));
	midiNumberToFrequency.insert(make_pair(42,92.4986056779));
	midiNumberToFrequency.insert(make_pair(43,97.9988589954));
	midiNumberToFrequency.insert(make_pair(44,103.826174395));
	midiNumberToFrequency.insert(make_pair(45,110));
	midiNumberToFrequency.insert(make_pair(46,116.5409403795));
	midiNumberToFrequency.insert(make_pair(47,123.470825314));
	midiNumberToFrequency.insert(make_pair(72,523.2511306012));
	midiNumberToFrequency.insert(make_pair(73,554.3652619537));
	midiNumberToFrequency.insert(make_pair(74,587.3295358348));
	midiNumberToFrequency.insert(make_pair(75,622.2539674442));
	midiNumberToFrequency.insert(make_pair(76,659.2551138257));
	midiNumberToFrequency.insert(make_pair(77,698.456462866));
	midiNumberToFrequency.insert(make_pair(78,739.9888454233));
	midiNumberToFrequency.insert(make_pair(79,783.9908719635));
	midiNumberToFrequency.insert(make_pair(80,830.6093951599));
	midiNumberToFrequency.insert(make_pair(81,880));
	midiNumberToFrequency.insert(make_pair(82,932.3275230362));
	midiNumberToFrequency.insert(make_pair(83,987.7666025122));
	midiNumberToFrequency.insert(make_pair(108,4186.0090448096));
	midiNumberToFrequency.insert(make_pair(109,4434.92209563));
	midiNumberToFrequency.insert(make_pair(110,4698.6362866785));
	midiNumberToFrequency.insert(make_pair(111,4978.0317395533));
	midiNumberToFrequency.insert(make_pair(112,5274.0409106059));
	midiNumberToFrequency.insert(make_pair(113,5587.6517029281));
	midiNumberToFrequency.insert(make_pair(114,5919.9107633862));
	midiNumberToFrequency.insert(make_pair(115,6271.926975708));
	midiNumberToFrequency.insert(make_pair(116,6644.8751612791));
	midiNumberToFrequency.insert(make_pair(117,7040));
	midiNumberToFrequency.insert(make_pair(118,7458.6201842894));
	midiNumberToFrequency.insert(make_pair(119,7902.132820098));
	midiNumberToFrequency.insert(make_pair(12,16.3515978313));
	midiNumberToFrequency.insert(make_pair(13,17.3239144361));
	midiNumberToFrequency.insert(make_pair(14,18.3540479948));
	midiNumberToFrequency.insert(make_pair(15,19.4454364826));
	midiNumberToFrequency.insert(make_pair(16,20.6017223071));
	midiNumberToFrequency.insert(make_pair(17,21.8267644646));
	midiNumberToFrequency.insert(make_pair(18,23.1246514195));
	midiNumberToFrequency.insert(make_pair(19,24.4997147489));
	midiNumberToFrequency.insert(make_pair(20,25.9565435987));
	midiNumberToFrequency.insert(make_pair(21,27.5));
	midiNumberToFrequency.insert(make_pair(22,29.1352350949));
	midiNumberToFrequency.insert(make_pair(23,30.8677063285));
	midiNumberToFrequency.insert(make_pair(48,130.8127826503));
	midiNumberToFrequency.insert(make_pair(49,138.5913154884));
	midiNumberToFrequency.insert(make_pair(50,146.8323839587));
	midiNumberToFrequency.insert(make_pair(51,155.563491861));
	midiNumberToFrequency.insert(make_pair(52,164.8137784564));
	midiNumberToFrequency.insert(make_pair(53,174.6141157165));
	midiNumberToFrequency.insert(make_pair(54,184.9972113558));
	midiNumberToFrequency.insert(make_pair(55,195.9977179909));
	midiNumberToFrequency.insert(make_pair(56,207.65234879));
	midiNumberToFrequency.insert(make_pair(57,220));
	midiNumberToFrequency.insert(make_pair(58,233.081880759));
	midiNumberToFrequency.insert(make_pair(59,246.9416506281));
	midiNumberToFrequency.insert(make_pair(84,1046.5022612024));
	midiNumberToFrequency.insert(make_pair(85,1108.7305239075));
	midiNumberToFrequency.insert(make_pair(86,1174.6590716696));
	midiNumberToFrequency.insert(make_pair(87,1244.5079348883));
	midiNumberToFrequency.insert(make_pair(88,1318.5102276515));
	midiNumberToFrequency.insert(make_pair(89,1396.912925732));
	midiNumberToFrequency.insert(make_pair(90,1479.9776908465));
	midiNumberToFrequency.insert(make_pair(91,1567.981743927));
	midiNumberToFrequency.insert(make_pair(92,1661.2187903198));
	midiNumberToFrequency.insert(make_pair(93,1760));
	midiNumberToFrequency.insert(make_pair(94,1864.6550460724));
	midiNumberToFrequency.insert(make_pair(95,1975.5332050245));
	midiNumberToFrequency.insert(make_pair(120,8372.0180896192));
	midiNumberToFrequency.insert(make_pair(121,8869.8441912599));
	midiNumberToFrequency.insert(make_pair(122,9397.272573357));
	midiNumberToFrequency.insert(make_pair(123,9956.0634791066));
	midiNumberToFrequency.insert(make_pair(124,10548.0818212118));
	midiNumberToFrequency.insert(make_pair(125,11175.3034058561));
	midiNumberToFrequency.insert(make_pair(126,11839.8215267723));
	midiNumberToFrequency.insert(make_pair(127,12543.853951416));
	midiNumberToFrequency.insert(make_pair(24,32.7031956626));
	midiNumberToFrequency.insert(make_pair(25,34.6478288721));
	midiNumberToFrequency.insert(make_pair(26,36.7080959897));
	midiNumberToFrequency.insert(make_pair(27,38.8908729653));
	midiNumberToFrequency.insert(make_pair(28,41.2034446141));
	midiNumberToFrequency.insert(make_pair(29,43.6535289291));
	midiNumberToFrequency.insert(make_pair(30,46.249302839));
	midiNumberToFrequency.insert(make_pair(31,48.9994294977));
	midiNumberToFrequency.insert(make_pair(32,51.9130871975));
	midiNumberToFrequency.insert(make_pair(33,55));
	midiNumberToFrequency.insert(make_pair(34,58.2704701898));
	midiNumberToFrequency.insert(make_pair(35,61.735412657));
	midiNumberToFrequency.insert(make_pair(60,261.6255653006));
	midiNumberToFrequency.insert(make_pair(61,277.1826309769));
	midiNumberToFrequency.insert(make_pair(62,293.6647679174));
	midiNumberToFrequency.insert(make_pair(63,311.1269837221));
	midiNumberToFrequency.insert(make_pair(64,329.6275569129));
	midiNumberToFrequency.insert(make_pair(65,349.228231433));
	midiNumberToFrequency.insert(make_pair(66,369.9944227116));
	midiNumberToFrequency.insert(make_pair(67,391.9954359817));
	midiNumberToFrequency.insert(make_pair(68,415.3046975799));
	midiNumberToFrequency.insert(make_pair(69,440));
	midiNumberToFrequency.insert(make_pair(70,466.1637615181));
	midiNumberToFrequency.insert(make_pair(71,493.8833012561));
	midiNumberToFrequency.insert(make_pair(96,2093.0045224048));
	midiNumberToFrequency.insert(make_pair(97,2217.461047815));
	midiNumberToFrequency.insert(make_pair(98,2349.3181433393));
	midiNumberToFrequency.insert(make_pair(99,2489.0158697766));
	midiNumberToFrequency.insert(make_pair(100,2637.020455303));
	midiNumberToFrequency.insert(make_pair(101,2793.825851464));
	midiNumberToFrequency.insert(make_pair(102,2959.9553816931));
	midiNumberToFrequency.insert(make_pair(103,3135.963487854));
	midiNumberToFrequency.insert(make_pair(104,3322.4375806396));
	midiNumberToFrequency.insert(make_pair(105,3520));
	midiNumberToFrequency.insert(make_pair(106,3729.3100921447));
	midiNumberToFrequency.insert(make_pair(107,3951.066410049));




}



SoundAction::~SoundAction(void)
{
}

void SoundAction::synthAudioRequested(float * output, int bufferSize, int nChannels, int numSoundActionsPlaying,int outputChannels,int inputChannels,int sampleRate,int numBuffers)
{
	//Bug?
	//Synth was being requested by pure virtual uninitialized SA objects
	//This function is now just virtual not pure virtual
	//This is called rather than an error being thrown
	cout << "Warning: Pure SoundAction Function Call!" << endl;
}

void SoundAction::start(int touchID)
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
}

void SoundAction::modify(float percentX, float percentY)
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
}

void SoundAction::end()
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
}
bool SoundAction::isPlaying()
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
	return false;
}
void SoundAction::setVolume(float vol)
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
}
float SoundAction::getVolume()
{
	cout << "Warning: Pure SoundAction Function Call!" << endl;
	return -1;
}


