AudioOutput out;
Minim minim;
Oscil[] wave;

MidiBus midi;

//Notes (MIDI)
//final int BASE_NOTE = 40;  //~261Hz C-4
final int BASE_NOTE = 60;
final int NOTE_C = 0;
final int NOTE_CS = 1;
final int NOTE_D = 2;
final int NOTE_DS = 3;
final int NOTE_E = 4;
final int NOTE_F = 5;
final int NOTE_FS = 6;
final int NOTE_G = 7;
final int NOTE_GS = 8;
final int NOTE_A = 9;
final int NOTE_AS = 10;
final int NOTE_B = 11;
final int OCTAVE = 12;

//Note List
int[][] notelist = {
  {  //Regular Notes
    BASE_NOTE + OCTAVE * -1 + NOTE_C,
    BASE_NOTE + OCTAVE * -1 + NOTE_D,
    BASE_NOTE + OCTAVE * -1 + NOTE_E,
    BASE_NOTE + OCTAVE * -1 + NOTE_F,
    BASE_NOTE + OCTAVE * -1 + NOTE_G,
    BASE_NOTE + OCTAVE * -1 + NOTE_A,
    BASE_NOTE + OCTAVE * -1 + NOTE_B,
    BASE_NOTE + OCTAVE * 0 + NOTE_C,
    BASE_NOTE + OCTAVE * 0 + NOTE_D,
    BASE_NOTE + OCTAVE * 0 + NOTE_E,
    BASE_NOTE + OCTAVE * 0 + NOTE_F,
    BASE_NOTE + OCTAVE * 0 + NOTE_G,
    BASE_NOTE + OCTAVE * 0 + NOTE_A,
    BASE_NOTE + OCTAVE * 0 + NOTE_B,
    BASE_NOTE + OCTAVE * 1 + NOTE_C,
  },
  {  //Drum Kit
    40, //Snare 2
    36, //Kick
    35, //Kick
    38, //Snare 4
    40, //Snare 3
    38, //Snare 1
    50, //High Tom
    48, //Hi-Mid Tom
    45, //Low Tom
    41, //Low Floor Tom
    37, //Side Stick
    44, //Pedal Hi-hat
    38,
    40,
    75, //Woodblock
  },
};

//Program Number of each drum
int[] drumkits = {
  0,
  0,
  0,
  16,
  25,
  24,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
};

//Frequency of Notes
float[] notefreq = {
  261.6,
  293.7,
  329.6,
  349.2,
  392.0,
  440.0,
  493.9,
  523.3,
  587.3,
  659.3,
  698.5,
  784.0,
  880.0,
  987.8,
  1047.0,
};

public class SoundChannel {
  public int type;    //0 = Synth, 1 = MIDI, 2 = MIDI Drum
  public int inst;    //Synth: 0 = None, 1 = Square, 2 = Triangle, 3 = Saw, 4 = Sine, 5 = Pulse
                      //MIDI:  Instrument Program
  public int frame;
  public int curframe;
  public float freq;
  public int note;
  public int color_id;
  
  public SoundChannel() {
    Reset();
  }
  
  public void Set(int _type, int _inst, int _duration, float _freq, int _color_id) {
    this.type = _type;
    this.inst = _inst;
    this.frame = _duration;
    this.curframe = 0;
    this.freq = _freq;
    this.color_id = _color_id;
  }
  
  public void Set(int _type, int _inst, int _duration, float _freq, int _note, int _color_id) {
    this.type = _type;
    this.inst = _inst;
    this.frame = _duration;
    this.curframe = 0;
    this.freq = _freq;
    this.note = _note;
    this.color_id = _color_id;
  }
  
  public void Set(int _type, int _inst, int _duration, int _note, int _color_id) {
    this.type = _type;
    this.inst = _inst;
    this.frame = _duration;
    this.curframe = 0;
    this.note = _note;
    this.color_id = _color_id;
  }
  
  public void Reset() {
    this.type = 0;
    this.inst = 0;
    this.frame = -1;
    this.curframe = -1;
    this.freq = 0;
    this.note = 0;
    this.color_id = 0;
  }
}

SoundChannel[] Sounds;

/* Sound */
void SoundInit(int nb)
{
  //Init Sound
  minim = new Minim( this );
  out = minim.getLineOut();
  
  wave = new Oscil[nb];
  for (int i = 0; i < nb; i++)
    wave[i] = new Oscil(0, 0);
  
  Sounds = new SoundChannel[nb];
  for (int i = 0; i < Sounds.length; i++)
    Sounds[i] = new SoundChannel();
  
  selectedMIDI = "Microsoft GS Wavetable Synth";
  midi = new MidiBus(this, -1, selectedMIDI);  //Windows MIDI by default
}

void SoundManage()
{
  for (int id = 0; id < Sounds.length; id++)
  {
    if (Sounds[id].frame != -1)
    {
      if (Sounds[id].type == 0)
      {
        //Synth
        if (Sounds[id].curframe >= Sounds[id].frame)
        {
          Sounds[id].Reset();
          wave[id].unpatch(out);
        }
        wave[id].setFrequency(Sounds[id].freq * 2);
        if (Sounds[id].curframe == 0)
        {
          wave[id].unpatch(out);
          wave[id].patch(out);
        }        
        Sounds[id].curframe++;
      }
      else if (Sounds[id].type == 1)
      {
        //MIDI
        if (Sounds[id].curframe >= Sounds[id].frame)
        {
          midi.sendNoteOff(id, Sounds[id].note, 0);
          Sounds[id].Reset();
        }
            
        if (Sounds[id].curframe == 0)
        {
          midi.sendNoteOff(id, Sounds[id].note, 0);
          midi.sendMessage(0xC0+id, Sounds[id].inst);  //Program Change
          midi.sendNoteOn(id, Sounds[id].note, 127);
        }        
        Sounds[id].curframe++;
      }
      else if (Sounds[id].type == 2)
      {
        //MIDI Drum Kit
        if (Sounds[id].curframe >= Sounds[id].frame)
        {
          midi.sendNoteOff(9, Sounds[id].note, 127);
          Sounds[id].Reset();
        }
            
        if (Sounds[id].curframe == 0)
        {
          midi.sendNoteOff(9, Sounds[id].note, 127);
          midi.sendMessage(0xC9, drumkits[Sounds[id].color_id]);  //Program Change
          midi.sendNoteOn(9, Sounds[id].note, 127);
        }        
        Sounds[id].curframe++;
      }
    }
  }
}

void StartSound(int id, int type, int inst, int duration, int note, int color_id)
{
  if (type == 0)
  {
    StopSound(id);
    switch (inst)
    {
      case 0:
        //None
        wave[id] = new Oscil(0, 0);
        break;
      case 1:
        //Square
        wave[id] = new Oscil(440, 0.5f, Waves.SQUARE);
        break;
      case 2:
        //Triangle
        wave[id] = new Oscil(440, 0.5f, Waves.TRIANGLE);
        break;
      case 3:
        //Saw
        wave[id] = new Oscil(440, 0.5f, Waves.SAW);
        break;
      case 4:
        //Sine
        wave[id] = new Oscil(440, 0.5f, Waves.SINE);
        break;
      case 5:
        //Pulse
        wave[id] = new Oscil(440, 0.5f, Waves.QUARTERPULSE);
        break;
    }
  }
  
  Sounds[id].Set(type, inst, duration, midiToFreq(note), note, color_id);
}

void StartSound(int id, int type, int inst, int duration, float freq, int color_id)
{
  Sounds[id].Set(type, inst, duration, freq, color_id);
}

void StopSound(int id)
{
  Sounds[id].Reset();
  wave[id].unpatch(out);
  
  midi.sendMessage(0xB0 + id, 123, 0); //All Notes Off
  midi.sendMessage(0xB0 + 9, 123, 0); //All Notes Off
}

void StopAllSounds()
{
  for (int id = 0; id < Sounds.length; id++)
  {
    Sounds[id].Reset();
    
    wave[id].unpatch(out);
    
    midi.sendMessage(0xB0 + id, 123, 0); //All Notes Off
  
    midi.sendMessage(0xB0 + 9, 123, 0); //All Notes Off
  }
}

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note) {
  return (pow(2, ((note-69)/12.0)))*440;
}