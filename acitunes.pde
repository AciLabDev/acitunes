/**
 * AciTunes - Music Insects Reimplementation
 * Original Concept by Toshio Iwai
 *
 * Developed by AciLab
 */

//TODO
/*
- New Canvas (set Size manually) [DONE, to be improved]
- MIDI output select (working, better interface needed)
- File Load/Save for touch/table screens

- New Effects
- Insect Designs
*/

import processing.sound.*;
import themidibus.*;
import javax.xml.bind.DatatypeConverter.*;

// Init
int version = 1;            //Current Version

PGraphics img;              //Canvas Image Buffer
PGraphics img_undo;         //Canvas Image Undo Buffer
PGraphics bg;               //Canvas Background
PFont font;                 //Font to use

color[] pal = {
  0xFFFFFF00,   //Yellow
  0xFFBEFF00,   //Lime
  0xFF7EFF00,   //Green
  0xFF40E09E,   //Turquoise
  0xFF00FFFF,   //Cyan
  0xFF0056FF,   //Blue
  0xFF9B56FF,   //Purple Blue
  0xFFFF1AC0,   //Purple
  0xFFFF76C3,   //Pink
  0xFFFF0000,   //Red
  0xFFFF8E00,   //Orange
  0xFFF9D3A5,   //Beige
  0xFF555555,   //Dark Grey  (Turn Left)
  0xFFC1C1C1,   //Light Grey (Turn Right)
  0xFFFFFFFF,   //White      (Turn Back)
  0x00000000,   //Black  
};

color[] palbg = {
  #000000,   //Black
  #202020,   //Very Dark Grey
};

color curcolor;             //Current Selected Color
int curcolor_id;            //Current Selected Color ID
int rainbow;                //Current Rainbow Color ID

int res_x;                  //Canvas Width
int res_y;                  //Canvas Height
float scale;                //Size of a canvas' pixel
int bgtype;                 //0 = Black, 1 = Checker

int newres_x, newres_y;     //New Canvas Size
int set;                    //What Canvas Size to Set

String selectedMIDI;        //MIDI output select

int nb_insect;              //Number of Insects
int mode;                   //0 = Normal, 1 = New Canvas, 2 = MIDI output select
boolean ignoreframeinput;   //Ignore Input in next frame
int globalspeed;            //Global Speed

boolean isDrawing;          //Is Drawing

int oldScreenWidth;         //Old Window Width  (Used for Resize)
int oldScreenHeight;        //Old Window Height (Used for Resize)

final int D_DOWN = 0;
final int D_RIGHT = 1;
final int D_UP = 2;
final int D_LEFT = 3;

// Start
void setup() {  
  size(800, 900);
  //fullScreen();
  surface.setResizable(true);
  frameRate(60);
  background(50);
  noSmooth();
  
  //Canvas Size
  newres_x = res_x = 104;
  newres_y = res_y = 104;
  set = 0;
  bgtype = 1;
  
  oldScreenWidth = width;
  oldScreenHeight = height;
  
  //Scale according to window size
  if (((float)width / res_x * res_y) > (height - 100))
    scale = (float)(height - 100) / res_y;
  else
    scale = (float)width / res_x;   
  
  font = loadFont("CodeNewRoman-12.vlw");
  textFont(font);
  
  Init(4);
  
  for (int i = 0; i < midi.availableOutputs().length; i++)
    println(midi.availableOutputs()[i]);
}

// Called every frame
void draw() {
  background(50);
  ResizeCheck();
  if (mode == 0)
  {
    //Regular Mode
    if (globalspeed > 0)
    {
      for (int i = 0; i < globalspeed; i++)
      {
        BitmapManage();
        ColorManage();
        InsectManage();
        EffectManage();
        SoundManage();
      }    
    }
    else
    {
      BitmapManage();
      ColorManage();
      InsectDisplay();
      SoundManage();
      EffectManage();
    }
    
    MenuManage();
    CursorManage();
    GrabInsectDraw();
  }
  else if (mode == 1)
  {
    //New Canvas Mode
    NewMenuManage();
  }
  else if (mode == 2)
  {
    //MIDI Output select
    MidiMenuManage();
  }
}

void mouseWheel(MouseEvent event) {
  if (mode == 0)
  {
    float e = event.getCount();
    curcolor_id -= (int)e;
    if (curcolor_id > pal.length)
      curcolor_id = 0;
    else if (curcolor_id < 0)
      curcolor_id = pal.length;
    
    if (curcolor_id < pal.length)
      curcolor = pal[curcolor_id];
  }
}

void mousePressed() {
  if (mode == 0)
  {
    if (!isDrawing && IsCursorOnInsect() != -1)
    {
      GrabInsect(IsCursorOnInsect());
    }
    else
    {  
      if (IsCursorOnBitmap())
        BitmapKeepUndo();
      if (!ignoreframeinput)
      {
        BitmapInput();
        isDrawing = true;
      }
      else
        ignoreframeinput = false;
    }
  }
}

void mouseReleased() {
  if (mode == 0)
  {
    ColorInput();
    MenuInput();
    UngrabInsect();
    isDrawing = false;
  }
  else if (mode == 1)
  {
    NewMenuInput();
  }
  else if (mode == 2)
  {
    MidiMenuInput();
  }
}

void mouseDragged() {
  if (mode == 0)
  {
    if (grabbedInsect >= 0)
      GrabInsectDraw();
    else
    {  
      if (!ignoreframeinput)
      {
        BitmapInput();
        isDrawing = true;
      }
      else
        ignoreframeinput = false;
    }
  }
}

void Init(int nb)
{
  //Insect Number
  nb_insect = nb;  //Limit = 56
  
  //Init Palette
  curcolor_id = pal.length - 2;
  curcolor = pal[curcolor_id];
  rainbow = 0;
  
  BitmapInit();
  BitmapBackgroundUpdate();
  InsectInit(nb_insect);
  EffectInit(nb_insect);
  SoundInit(nb_insect);
  
  Insects[0].SetSound(1, 0, 0);
  Insects[1].SetSound(1, 24, 0);
  Insects[2].SetSound(1, 36, 0);
  Insects[3].SetSound(2, 0, 1);
  
  InsectDefault(Insects.length);
  
  ignoreframeinput = false;
  globalspeed = 1;
  
  isDrawing = false;
}

void NewDrawing(int x, int y)
{
  mode = 0;
  newres_x = res_x = x;
  newres_y = res_y = y;
  Init(4);
  Resize();
}

void Resize()
{
  //Call when resized
  float oldScale = scale;
  //Scale according to window size
  if (((float)width / res_x * res_y) > (height - 100))
    scale = (float)(height - 100) / res_y;
  else
    scale = (float)width / res_x;
  
  //Move Insects accordingly
  for (int i = 0; i < Insects.length; i++)
  {
    Insects[i].x = Insects[i].x / oldScale * scale;
    Insects[i].y = Insects[i].y / oldScale * scale;
  }
  
  //Move Effects accordingly
  for (int i = 0; i < Effects.length; i++)
  {
    Effects[i].x = Effects[i].x / oldScale * scale;
    Effects[i].y = Effects[i].y / oldScale * scale;
  }
}

void ResizeCheck()
{
  if (oldScreenWidth != width || oldScreenHeight != height)
  {
    Resize();
  }
}

int GetLeft()
{
  //To center the Canvas
  if (width > (res_x * scale))
    return (width / 2) - (int)((res_x * scale) / 2);
  else
    return 0;
}