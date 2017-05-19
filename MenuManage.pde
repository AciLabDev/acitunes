int menutype = 0; //0 = Mouse, 1 = TUIO
int menuTUIOpage = 0;

/* Manage */
void MenuManage()
{
  drawIntImage(buttonIconCircle, 16, 16, pal[0],  width - 40, height - 40, 2);
  switch (menutype)
  {
    case 0:
      //Mouse
      MenuManageMouse();
      drawIntImage(mouseIcon, 12, 12, pal[0],  width - 40 + 4, height - 40 + 4, 2);
      break;
    case 1:
      //TUIO
      MenuManageTUIO();
      drawIntImage(tuioIcon, 12, 12, pal[0],  width - 40 + 4, height - 40 + 4, 2);
      break;
  }
  
  //in all cases, render this button
}

void MenuInput()
{
  switch (menutype)
  {
    case 0:
      //Mouse
      MenuInputMouse();
      break;
    case 1:
      //TUIO
      MenuInputTUIO();
      break;
  }
  
  //in all cases, this button must switch between menu modes
  if (cursorX >= width - 40 && cursorX < width - 40 + 32
  && cursorY >= height - 40 && cursorY < height - 40 + 32)
  {
    menuTUIOpage = 0;
    menutype ^= 1;
  }
}

/* Regular Menu (Mouse) */
void MenuManageMouse()
{
  ColorManage();
  
  noStroke();
  fill(pal[0]);
  
  //1st line - Main Settings
  drawIntImage(buttonIcon, 16, 16, pal[0], GetLeft() + 20 + 0 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[0], GetLeft() + 20 + 1 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[0], GetLeft() + 20 + 2 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[2], GetLeft() + 20 + 3 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[2], GetLeft() + 20 + 4 * 20, (res_y * scale) + 50, 1);
  
  drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 6 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 7 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 8 * 20, (res_y * scale) + 50, 1);
  
  drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 10 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 11 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 12 * 20, (res_y * scale) + 50, 1);
  
  drawIntImage(buttonIcon, 16, 16, #FFFFFF, GetLeft() + 20 + 14 * 20, (res_y * scale) + 50, 1);
  drawIntImage(buttonIcon, 16, 16, #FFFFFF, GetLeft() + 20 + 15 * 20, (res_y * scale) + 50, 1);
  
  drawIntImage(buttonIconCircle, 16, 16, #FFFFFF, GetLeft() + 20 + 17 * 20, (res_y * scale) + 50, 1);
  
  //1st line Icons
  drawIntImage(newIcon, 12, 12, pal[0], GetLeft() + 22 + 0 * 20, (res_y * scale) + 52, 1);
  drawIntImage(loadIcon, 12, 12, pal[0], GetLeft() + 22 + 1 * 20, (res_y * scale) + 52, 1);
  drawIntImage(saveIcon, 12, 12, pal[0], GetLeft() + 22 + 2 * 20, (res_y * scale) + 52, 1);
  drawIntImage(clearIcon, 12, 12, pal[2], GetLeft() + 22 + 3 * 20, (res_y * scale) + 52, 1);
  drawIntImage(undoIcon, 12, 12, pal[2], GetLeft() + 22 + 4 * 20, (res_y * scale) + 52, 1);
  
  drawIntImage(auto1Icon, 12, 12, pal[2], GetLeft() + 22 + 6 * 20, (res_y * scale) + 52, 1);
  drawIntImage(auto2Icon, 12, 12, pal[2], GetLeft() + 22 + 7 * 20, (res_y * scale) + 52, 1);
  drawIntImage(auto3Icon, 12, 12, pal[2], GetLeft() + 22 + 8 * 20, (res_y * scale) + 52, 1);
  
  if (globalspeed == 0) 
    drawIntImage(pauseIcon, 12, 12, pal[7], GetLeft() + 22 + 10 * 20, (res_y * scale) + 52, 1);
  else
    drawIntImage(pauseEmptyIcon, 12, 12, pal[7], GetLeft() + 22 + 10 * 20, (res_y * scale) + 52, 1);
    
  if (globalspeed == 1)
    drawIntImage(playIcon, 12, 12, pal[7], GetLeft() + 22 + 11 * 20, (res_y * scale) + 52, 1);
  else
    drawIntImage(playEmptyIcon, 12, 12, pal[7], GetLeft() + 22 + 11 * 20, (res_y * scale) + 52, 1);
    
  if (globalspeed == 2)
    drawIntImage(playfastIcon, 12, 12, pal[7], GetLeft() + 22 + 12 * 20, (res_y * scale) + 52, 1);
  else
    drawIntImage(playfastEmptyIcon, 12, 12, pal[7], GetLeft() + 22 + 12 * 20, (res_y * scale) + 52, 1);
    
  drawIntImage(blackIcon, 12, 12, #000000, GetLeft() + 22 + 14 * 20, (res_y * scale) + 52, 1);
  drawIntImage(checkerIcon, 12, 12, #000000, GetLeft() + 22 + 15 * 20, (res_y * scale) + 52, 1);
  
  drawIntImage(midiOutputIcon, 12, 12, #FFFFFF, GetLeft() + 22 + 17 * 20, (res_y * scale) + 52, 1);
  
  //---------------------------------------------
  //2nd line - Insect Setting
  drawIntImage(buttonIconCircle, 16, 16, insectColorDefault[selectedInsect & 3], GetLeft() + 20 + 0 * 20, (res_y * scale) + 70, 1);
  stroke(insectColorDefault[selectedInsect & 3]);
  strokeWeight(1);
  drawIntImage(buttonIcon, 16, 16, pal[8], GetLeft() + 20 + 7 * 20, (res_y * scale) + 70, 1);
  drawIntImage(buttonIcon, 16, 16, pal[pal.length - 2], GetLeft() + 20 + 8 * 20, (res_y * scale) + 70, 1);
  
  //2nd line Icons  
  switch (selectedInsect)
  {
    case 0:
      drawIntImage(oneIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 0 * 20, (res_y * scale) + 72, 1);
      break;
    case 1:
      drawIntImage(twoIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 0 * 20, (res_y * scale) + 72, 1);
      break;
    case 2:
      drawIntImage(threeIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 0 * 20, (res_y * scale) + 72, 1);
      break;
    case 3:
      drawIntImage(fourIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 0 * 20, (res_y * scale) + 72, 1);
      break;
  }
  
  if (Insects[selectedInsect].speed == 0)
    drawIntImage(pauseIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 2 * 20, (res_y * scale) + 72, 1);
  else
    drawIntImage(pauseEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 2 * 20, (res_y * scale) + 72, 1);
    
  if (Insects[selectedInsect].speed >= 0.25)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 3 * 20, (res_y * scale) + 72, 1);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 3 * 20, (res_y * scale) + 72, 1);
    
  if (Insects[selectedInsect].speed >= 0.5)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 4 * 20, (res_y * scale) + 72, 1);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 4 * 20, (res_y * scale) + 72, 1);
  
  if (Insects[selectedInsect].speed >= 0.75)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 5 * 20, (res_y * scale) + 72, 1);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 5 * 20, (res_y * scale) + 72, 1);
  
  if (Insects[selectedInsect].speed >= 1)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 6 * 20, (res_y * scale) + 72, 1);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 22 + 6 * 20, (res_y * scale) + 72, 1);
  
  switch (Insects[selectedInsect].direction)
  {
    case D_UP:
      drawIntImage(upArrow, 12, 12, pal[8], GetLeft() + 22 + 7 * 20, (res_y * scale) + 72, 1);
      break;
    case D_DOWN:
      drawIntImage(downArrow, 12, 12, pal[8], GetLeft() + 22 + 7 * 20, (res_y * scale) + 72, 1);
      break;
    case D_LEFT:
      drawIntImage(leftArrow, 12, 12, pal[8], GetLeft() + 22 + 7 * 20, (res_y * scale) + 72, 1);
      break;
    case D_RIGHT:
      drawIntImage(rightArrow, 12, 12, pal[8], GetLeft() + 22 + 7 * 20, (res_y * scale) + 72, 1);
      break;
  }
  
  switch (Insects[selectedInsect].soundType)
  {
    case 0:
      drawIntImage(oscIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 8 * 20, (res_y * scale) + 72, 1);
      break;
    case 1:
      drawIntImage(midiIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 8 * 20, (res_y * scale) + 72, 1);
      break;
    case 2:
      drawIntImage(midiDrumIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 8 * 20, (res_y * scale) + 72, 1);
      break;
  }
  
  if (Insects[selectedInsect].soundType == 0)
  {
    //Wave Oscillator
    drawIntImage(buttonIcon, 16, 16, pal[pal.length - 2], GetLeft() + 20 + 9 * 20, (res_y * scale) + 70, 1);
    switch (Insects[selectedInsect].soundInst)
    {
      case 1:
        //Square
        drawIntImage(squareIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
      case 2:
        //Triangle
        drawIntImage(triangleIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
      case 3:
        //Saw
        drawIntImage(sawIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
      case 4:
        //Sine
        drawIntImage(sineIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
      case 5:
        //Pulse
        drawIntImage(pulseIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
      default:
        //None
        drawIntImage(noneIcon, 12, 12, pal[pal.length - 2], GetLeft() + 22 + 9 * 20, (res_y * scale) + 72, 1);
        break;
    }
  }
  else if (Insects[selectedInsect].soundType == 1)
  {
    //MIDI
    textSize(12);
    noFill();
    stroke(pal[pal.length - 2]);
    rect(GetLeft() + 20 + 9 * 20, (res_y * scale) + 70, 24, 15);
    
    //number
    noStroke();
    fill(pal[pal.length - 2]);
    text(Insects[selectedInsect].soundInst, GetLeft() + 22 + 9 * 20, (res_y * scale) + 83);
    
    //instrument name
    text(GeneralMIDI[Insects[selectedInsect].soundInst], GetLeft() + 28 + 10 * 20, (res_y * scale) + 83);
  }
}

void MenuInputMouse()
{
  ColorInput();
  
  //Mouse Check
  if (cursorY >= ((res_y * scale) + 50) && cursorY <= (res_y * scale) + 50 + 16)
  {
    switch (((cursorX - GetLeft()) - 20) / 20)
    {
       case 0:
         //New
         StopAllSounds();
         mode = 1;
         set = 0;
         break;
       case 1:
         //Load
         globalspeed = 0;
         selectInput("Load JSON file", "fileLoad");
         break;
       case 2:
         //Save
         globalspeed = 0;
         selectInput("Save JSON file", "fileSave");
         break;
       case 3:
         //Clear
         BitmapKeepUndo();
         BitmapErase();
         break;
       case 4:
         //Undo/Redo
         BitmapSwapUndo();
         break;
       case 6:
         //Auto (Single Line)
         StopAllSounds();
         BitmapKeepUndo();
         BitmapLineRandom();
         InsectLineRandom();
         break;
       case 7:
         //Auto (Multi Lines)
         StopAllSounds();
         BitmapKeepUndo();
         BitmapMultiLineRandom();
         InsectMultiLineRandom();
         break;
       case 8:
         //Auto (Random Pattern)
         StopAllSounds();
         BitmapKeepUndo();
         BitmapErase();
         int space_x = int(random(2, res_x / 10));
         int space_y = int(random(2, res_y / 10));
         BitmapPatternRandom(space_x, space_y);
         InsectPatternRandom(space_x, space_y);
         break;
       case 10:
         //Pause
         StopAllSounds();
         globalspeed = 0;
         break;
       case 11:
         //Play
         globalspeed = 1;
         break;
       case 12:
         //Play Fast
         globalspeed = 2;
         break;
       case 14:
         //Black BG
         bgtype = 0;
         BitmapBackgroundUpdate();
         break;
       case 15:
         //Checker BG
         bgtype = 1;
         BitmapBackgroundUpdate();
         break;
       case 17:
         //MIDI output setup
         StopAllSounds();
         mode = 2;
         set = 0;
         break;
    }
  }
  else if (cursorY >= ((res_y * scale) + 70) && cursorY <= (res_y * scale) + 70 + 16)
  {
    switch (((cursorX - GetLeft()) - 20) / 20)
    {
      case 0:
        //Select Insect
        if (mouseButton == LEFT)
          selectedInsect++;
        else
          selectedInsect--;
        
        if (selectedInsect >= Insects.length)
          selectedInsect = 0;
        else if (selectedInsect < 0)
          selectedInsect = Insects.length - 1;
        break;
      case 2:
        //Speed 0
        Insects[selectedInsect].speed = 0;
        break;
      case 3:
        //Speed 0.25
        Insects[selectedInsect].speed = 0.25;
        break;
      case 4:
        //Speed 0.5
        Insects[selectedInsect].speed = 0.5;
        break;
      case 5:
        //Speed 0.75
        Insects[selectedInsect].speed = 0.75;
        break;
      case 6:
        //Speed 1
        Insects[selectedInsect].speed = 1;
        break;
      case 7:
        //Direction Change
        Insects[selectedInsect].Turn(D_RIGHT);
        break;
      case 8:
        //Sound Type
        StopSound(selectedInsect);
        if (mouseButton == LEFT)
          Insects[selectedInsect].soundType++;
        else
          Insects[selectedInsect].soundType--;
        
        if (Insects[selectedInsect].soundType >= 3)
          Insects[selectedInsect].soundType = 0;
        else if (Insects[selectedInsect].soundType < 0)
          Insects[selectedInsect].soundType = 2;
        
        if (Insects[selectedInsect].soundType == 2)
          Insects[selectedInsect].soundNoteID = 1;
        else
          Insects[selectedInsect].soundNoteID = 0;
        break;
      case 9:
        //Sound Instrument
        if (Insects[selectedInsect].soundType < 2)
        {
          StopSound(selectedInsect);
          if (mouseButton == LEFT)
            Insects[selectedInsect].soundInst++;
          else
            Insects[selectedInsect].soundInst--;
          
          if (Insects[selectedInsect].soundType == 0 && Insects[selectedInsect].soundInst > 5)
            Insects[selectedInsect].soundInst = 0;
          else if (Insects[selectedInsect].soundType == 0 && Insects[selectedInsect].soundInst < 0)
            Insects[selectedInsect].soundInst = 5;
          else if (Insects[selectedInsect].soundType == 1 && Insects[selectedInsect].soundInst > 127)
            Insects[selectedInsect].soundInst = 0;
          else if (Insects[selectedInsect].soundType == 1 && Insects[selectedInsect].soundInst < 0)
            Insects[selectedInsect].soundInst = 127;
        }
    }
  }
}

/* Regular Color Menu (Mouse) */
void ColorManage()
{
  //Color Select
  for (int i = 0; i < pal.length; i++)
  {
    noStroke();
    fill(pal[i]);
    rect(GetLeft() + 20 + i * 20, (res_y * scale) + 5, 15, 30);
    if (curcolor_id == i)
    {
      noFill();
      stroke(255);
      strokeWeight(3);
      rect(GetLeft() + 20 + i * 20, (res_y * scale) + 5, 15, 30);
      strokeWeight(1);
    }
  }
  
  for (int i = 0; i < pal.length - 1; i++)
  {
    noStroke();
    fill(pal[i]);
    rect(GetLeft() + 20 + pal.length * 20, (res_y * scale) + 5 + (i * 2), 15, 2);
  }
  if (curcolor_id == pal.length)
  {
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(GetLeft() + 20 + pal.length * 20, (res_y * scale) + 5, 15, 30);
    strokeWeight(1);
  }
}

void ColorInput()
{
  if (mouseButton == LEFT && focused) {
    if (cursorY >= ((res_y * scale) + 5) && cursorY <= (res_y * scale) + 5 + 30)
    {
      
      if (((cursorX - GetLeft()) - 20) / 20 <= pal.length && ((cursorX - GetLeft()) - 20) / 20 >= 0)
      {
        curcolor_id = ((cursorX - GetLeft()) - 20) / 20;
      }
      
      if (curcolor_id < pal.length)
      {
        curcolor = pal[curcolor_id];
      }
      
      if (curcolor_id < pal.length - 1)
      {
        StartSound(selectedInsect, Insects[selectedInsect].soundType, Insects[selectedInsect].soundInst, (int)frameRate / 12, notelist[Insects[selectedInsect].soundNoteID][curcolor_id], curcolor_id);
      }
    }
  }
}

/* Regular Menu (TUIO) */
void MenuManageTUIO()
{
  //Render Page Number
  drawIntImage(buttonIcon, 16, 16, pal[5], GetLeft() + 22 + 18 * 31, (res_y * scale) + 4, 2);
  switch (menuTUIOpage)
  {
    case 0:
      drawIntImage(oneIcon, 12, 12, pal[5], GetLeft() + 26 + 18 * 31, (res_y * scale) + 8, 2);
      break;
    case 1:
      drawIntImage(twoIcon, 12, 12, pal[5], GetLeft() + 26 + 18 * 31, (res_y * scale) + 8, 2);
      break;
    case 2:
      drawIntImage(threeIcon, 12, 12, pal[5], GetLeft() + 26 + 18 * 31, (res_y * scale) + 8, 2);
      break;
    case 3:
      drawIntImage(fourIcon, 12, 12, pal[5], GetLeft() + 26 + 18 * 31, (res_y * scale) + 8, 2);
      break;
  }
  
  if (menuTUIOpage == 0)
  {
    //Color Page
    for (int i = 0; i < pal.length; i++)
    {
      noStroke();
      fill(pal[i]);
      rect(GetLeft() + 20 + i * 31, (res_y * scale) + 5, 30, 30);
      if (curcolor_id == i)
      {
        noFill();
        stroke(255);
        strokeWeight(3);
        rect(GetLeft() + 20 + i * 31, (res_y * scale) + 5, 30, 30);
        strokeWeight(1);
      }
    }
    
    for (int i = 0; i < pal.length - 1; i++)
    {
      noStroke();
      fill(pal[i]);
      rect(GetLeft() + 20 + pal.length * 31, (res_y * scale) + 5 + (i * 2), 30, 2);
    }
    if (curcolor_id == pal.length)
    {
      noFill();
      stroke(255);
      strokeWeight(3);
      rect(GetLeft() + 20 + pal.length * 31, (res_y * scale) + 5, 30, 30);
      strokeWeight(1);
    }
  }
  else if (menuTUIOpage == 1)
  {
    //1st line - Main Settings
    drawIntImage(buttonIcon, 16, 16, pal[2], GetLeft() + 20 + 0 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, pal[2], GetLeft() + 20 + 1 * 34, (res_y * scale) + 4, 2);
    
    drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 3 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 4 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, pal[4], GetLeft() + 20 + 5 * 34, (res_y * scale) + 4, 2);
    
    drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 7 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 8 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, pal[7], GetLeft() + 20 + 9 * 34, (res_y * scale) + 4, 2);
    
    drawIntImage(buttonIcon, 16, 16, #FFFFFF, GetLeft() + 20 + 11 * 34, (res_y * scale) + 4, 2);
    drawIntImage(buttonIcon, 16, 16, #FFFFFF, GetLeft() + 20 + 12 * 34, (res_y * scale) + 4, 2);
    
    //1st line Icons
    drawIntImage(clearIcon, 12, 12, pal[2], GetLeft() + 24 + 0 * 34, (res_y * scale) + 8, 2);
    drawIntImage(undoIcon, 12, 12, pal[2], GetLeft() + 24 + 1 * 34, (res_y * scale) + 8, 2);
    
    drawIntImage(auto1Icon, 12, 12, pal[2], GetLeft() + 24 + 3 * 34, (res_y * scale) + 8, 2);
    drawIntImage(auto2Icon, 12, 12, pal[2], GetLeft() + 24 + 4 * 34, (res_y * scale) + 8, 2);
    drawIntImage(auto3Icon, 12, 12, pal[2], GetLeft() + 24 + 5 * 34, (res_y * scale) + 8, 2);
    
    if (globalspeed == 0) 
      drawIntImage(pauseIcon, 12, 12, pal[7], GetLeft() + 24 + 7 * 34, (res_y * scale) + 8, 2);
    else
      drawIntImage(pauseEmptyIcon, 12, 12, pal[7], GetLeft() + 24 + 7 * 34, (res_y * scale) + 8, 2);
      
    if (globalspeed == 1)
      drawIntImage(playIcon, 12, 12, pal[7], GetLeft() + 24 + 8 * 34, (res_y * scale) + 8, 2);
    else
      drawIntImage(playEmptyIcon, 12, 12, pal[7], GetLeft() + 24 + 8 * 34, (res_y * scale) + 8, 2);
      
    if (globalspeed == 2)
      drawIntImage(playfastIcon, 12, 12, pal[7], GetLeft() + 24 + 9 * 34, (res_y * scale) + 8, 2);
    else
      drawIntImage(playfastEmptyIcon, 12, 12, pal[7], GetLeft() + 24 + 9 * 34, (res_y * scale) + 8, 2);
      
    drawIntImage(blackIcon, 12, 12, #000000, GetLeft() + 24 + 11 * 34, (res_y * scale) + 8, 2);
    drawIntImage(checkerIcon, 12, 12, #000000, GetLeft() + 24 + 12 * 34, (res_y * scale) + 8, 2);
  }
  
  //2nd line - Insect Setting
  drawIntImage(buttonIconCircle, 16, 16, insectColorDefault[selectedInsect & 3], GetLeft() + 20 + 0 * 34, (res_y * scale) + 44, 2);
  stroke(insectColorDefault[selectedInsect & 3]);
  strokeWeight(1);
  drawIntImage(buttonIcon, 16, 16, pal[8], GetLeft() + 20 + 7 * 34, (res_y * scale) + 44, 2);
  drawIntImage(buttonIcon, 16, 16, pal[pal.length - 2], GetLeft() + 20 + 8 * 34, (res_y * scale) + 44, 2);
  
  //2nd line Icons  
  switch (selectedInsect)
  {
    case 0:
      drawIntImage(oneIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 0 * 34, (res_y * scale) + 48, 2);
      break;
    case 1:
      drawIntImage(twoIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 0 * 34, (res_y * scale) + 48, 2);
      break;
    case 2:
      drawIntImage(threeIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 0 * 34, (res_y * scale) + 48, 2);
      break;
    case 3:
      drawIntImage(fourIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 0 * 34, (res_y * scale) + 48, 2);
      break;
  }
  
  if (Insects[selectedInsect].speed == 0)
    drawIntImage(pauseIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 2 * 34, (res_y * scale) + 48, 2);
  else
    drawIntImage(pauseEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 2 * 34, (res_y * scale) + 48, 2);
    
  if (Insects[selectedInsect].speed >= 0.25)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 3 * 34, (res_y * scale) + 48, 2);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 3 * 34, (res_y * scale) + 48, 2);
    
  if (Insects[selectedInsect].speed >= 0.5)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 4 * 34, (res_y * scale) + 48, 2);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 4 * 34, (res_y * scale) + 48, 2);
  
  if (Insects[selectedInsect].speed >= 0.75)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 5 * 34, (res_y * scale) + 48, 2);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 5 * 34, (res_y * scale) + 48, 2);
  
  if (Insects[selectedInsect].speed >= 1)
    drawIntImage(playIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 6 * 34, (res_y * scale) + 48, 2);
  else
    drawIntImage(playEmptyIcon, 12, 12, insectColorDefault[selectedInsect & 3], GetLeft() + 24 + 6 * 34, (res_y * scale) + 48, 2);
  
  switch (Insects[selectedInsect].direction)
  {
    case D_UP:
      drawIntImage(upArrow, 12, 12, pal[8], GetLeft() + 24 + 7 * 34, (res_y * scale) + 48, 2);
      break;
    case D_DOWN:
      drawIntImage(downArrow, 12, 12, pal[8], GetLeft() + 24 + 7 * 34, (res_y * scale) + 48, 2);
      break;
    case D_LEFT:
      drawIntImage(leftArrow, 12, 12, pal[8], GetLeft() + 24 + 7 * 34, (res_y * scale) + 48, 2);
      break;
    case D_RIGHT:
      drawIntImage(rightArrow, 12, 12, pal[8], GetLeft() + 24 + 7 * 34, (res_y * scale) + 48, 2);
      break;
  }
  
  switch (Insects[selectedInsect].soundType)
  {
    case 0:
      drawIntImage(oscIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 8 * 34, (res_y * scale) + 48, 2);
      break;
    case 1:
      drawIntImage(midiIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 8 * 34, (res_y * scale) + 48, 2);
      break;
    case 2:
      drawIntImage(midiDrumIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 8 * 34, (res_y * scale) + 48, 2);
      break;
  }
  
  if (Insects[selectedInsect].soundType == 0)
  {
    //Wave Oscillator
    drawIntImage(buttonIcon, 16, 16, pal[pal.length - 2], GetLeft() + 20 + 9 * 34, (res_y * scale) + 44, 2);
    switch (Insects[selectedInsect].soundInst)
    {
      case 1:
        //Square
        drawIntImage(squareIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
      case 2:
        //Triangle
        drawIntImage(triangleIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
      case 3:
        //Saw
        drawIntImage(sawIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
      case 4:
        //Sine
        drawIntImage(sineIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
      case 5:
        //Pulse
        drawIntImage(pulseIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
      default:
        //None
        drawIntImage(noneIcon, 12, 12, pal[pal.length - 2], GetLeft() + 24 + 9 * 34, (res_y * scale) + 48, 2);
        break;
    }
  }
  else if (Insects[selectedInsect].soundType == 1)
  {
    //MIDI
    textSize(12);
    noFill();
    stroke(pal[pal.length - 2]);
    rect(GetLeft() + 20 + 9 * 34, (res_y * scale) + 44, 31, 31);
    
    //number
    noStroke();
    fill(pal[pal.length - 2]);
    text(Insects[selectedInsect].soundInst, GetLeft() + 26 + 9 * 34, (res_y * scale) + 64);
    
    //instrument name
    text(GeneralMIDI[Insects[selectedInsect].soundInst], GetLeft() + 28 + 10 * 34, (res_y * scale) + 64);
  }
  strokeWeight(1);
}

void MenuInputTUIO()
{
  if (cursorY >= ((res_y * scale) + 4) && cursorY <= (res_y * scale) + 4 + 31)
  {
    //Page Change
    if (cursorX >= (GetLeft() + 22 + 18 * 31) && cursorX <= (GetLeft() + 22 + 31 + 18 * 31))
    {
      menuTUIOpage++;
      if (menuTUIOpage > 3)
        menuTUIOpage = 0;
    }
    else
    {
      if (menuTUIOpage == 0)
      {
        if (((cursorX - GetLeft()) - 20) / 31 <= pal.length && ((cursorX - GetLeft()) - 20) / 31 >= 0)
        {
          curcolor_id = ((cursorX - GetLeft()) - 20) / 31;
        }
        
        if (curcolor_id < pal.length)
        {
          curcolor = pal[curcolor_id];
        }
        
        if (curcolor_id < pal.length - 1)
        {
          StartSound(selectedInsect, Insects[selectedInsect].soundType, Insects[selectedInsect].soundInst, (int)frameRate / 12, notelist[Insects[selectedInsect].soundNoteID][curcolor_id], curcolor_id);
        }
      }
      else if (menuTUIOpage == 1)
      {
        switch (((cursorX - GetLeft()) - 20) / 34)
        {
           case 0:
             //Clear
             BitmapKeepUndo();
             BitmapErase();
             break;
           case 1:
             //Undo/Redo
             BitmapSwapUndo();
             break;
           case 3:
             //Auto (Single Line)
             StopAllSounds();
             BitmapKeepUndo();
             BitmapLineRandom();
             InsectLineRandom();
             break;
           case 4:
             //Auto (Multi Lines)
             StopAllSounds();
             BitmapKeepUndo();
             BitmapMultiLineRandom();
             InsectMultiLineRandom();
             break;
           case 5:
             //Auto (Random Pattern)
             StopAllSounds();
             BitmapKeepUndo();
             BitmapErase();
             int space_x = int(random(2, res_x / 10));
             int space_y = int(random(2, res_y / 10));
             BitmapPatternRandom(space_x, space_y);
             InsectPatternRandom(space_x, space_y);
             break;
           case 7:
             //Pause
             StopAllSounds();
             globalspeed = 0;
             break;
           case 8:
             //Play
             globalspeed = 1;
             break;
           case 9:
             //Play Fast
             globalspeed = 2;
             break;
           case 11:
             //Black BG
             bgtype = 0;
             BitmapBackgroundUpdate();
             break;
           case 12:
             //Checker BG
             bgtype = 1;
             BitmapBackgroundUpdate();
             break;
        }
      }
      else if (menuTUIOpage == 2)
      {
        
      }
      else if (menuTUIOpage == 3)
      {
        
      }
    }
  }
  
  if (cursorY >= ((res_y * scale) + 44) && cursorY <= (res_y * scale) + 44 + 31)
  {
    switch (((cursorX - GetLeft()) - 20) / 34)
    {
      case 0:
        //Select Insect
        if (mouseButton == LEFT)
          selectedInsect++;
        else
          selectedInsect--;
        
        if (selectedInsect >= Insects.length)
          selectedInsect = 0;
        else if (selectedInsect < 0)
          selectedInsect = Insects.length - 1;
        break;
      case 2:
        //Speed 0
        Insects[selectedInsect].speed = 0;
        break;
      case 3:
        //Speed 0.25
        Insects[selectedInsect].speed = 0.25;
        break;
      case 4:
        //Speed 0.5
        Insects[selectedInsect].speed = 0.5;
        break;
      case 5:
        //Speed 0.75
        Insects[selectedInsect].speed = 0.75;
        break;
      case 6:
        //Speed 1
        Insects[selectedInsect].speed = 1;
        break;
      case 7:
        //Direction Change
        Insects[selectedInsect].Turn(D_RIGHT);
        break;
      case 8:
        //Sound Type
        StopSound(selectedInsect);
        if (mouseButton == LEFT)
          Insects[selectedInsect].soundType++;
        else
          Insects[selectedInsect].soundType--;
        
        if (Insects[selectedInsect].soundType >= 3)
          Insects[selectedInsect].soundType = 0;
        else if (Insects[selectedInsect].soundType < 0)
          Insects[selectedInsect].soundType = 2;
        
        if (Insects[selectedInsect].soundType == 2)
          Insects[selectedInsect].soundNoteID = 1;
        else
          Insects[selectedInsect].soundNoteID = 0;
        break;
      case 9:
        //Sound Instrument
        if (Insects[selectedInsect].soundType < 2)
        {
          StopSound(selectedInsect);
          if (mouseButton == LEFT)
            Insects[selectedInsect].soundInst++;
          else
            Insects[selectedInsect].soundInst--;
          
          if (Insects[selectedInsect].soundType == 0 && Insects[selectedInsect].soundInst > 5)
            Insects[selectedInsect].soundInst = 0;
          else if (Insects[selectedInsect].soundType == 0 && Insects[selectedInsect].soundInst < 0)
            Insects[selectedInsect].soundInst = 5;
          else if (Insects[selectedInsect].soundType == 1 && Insects[selectedInsect].soundInst > 127)
            Insects[selectedInsect].soundInst = 0;
          else if (Insects[selectedInsect].soundType == 1 && Insects[selectedInsect].soundInst < 0)
            Insects[selectedInsect].soundInst = 127;
        }
    } 
  }
}

/* New Canvas Menu */
void NewMenuManage()
{
  //New Canvas
  stroke(0);
  strokeWeight(5);
  fill(80);
  rect(25, 25, 100, 200);
  rect(125, 25, 175, 25);
  rect(125, 50, 175, 25);
  rect(125, 75, 175, 25);
  
  strokeWeight(2);
  rect(30, 50, 20, 20);  //7
  rect(50, 50, 20, 20);  //8
  rect(70, 50, 20, 20);  //9
  rect(30, 70, 20, 20);  //4
  rect(50, 70, 20, 20);  //5
  rect(70, 70, 20, 20);  //6
  rect(30, 90, 20, 20);  //1
  rect(50, 90, 20, 20);  //2
  rect(70, 90, 20, 20);  //3
  rect(30, 110, 20, 20); //<
  rect(50, 110, 20, 20); //0
  rect(70, 110, 20, 20); //>
  rect(30, 130, 20 * 3, 20); //ENTER
  rect(30, 150, 20 * 3, 20); //CANCEL
  
  fill(255);
  text("x", 50 + 5, 42);
  
  if (set == 0)
    fill(255, 255, 0);
  
  text(newres_x, 30 + 2, 42);
  
  if (set == 1)
    fill(255, 255, 0);
  else
    fill(255);
    
  text(newres_y, 60 + 5, 42);
  
  fill(255);
  
  text("7", 30 + 8, 50 + 15);
  text("8", 50 + 8, 50 + 15);
  text("9", 70 + 8, 50 + 15);
  text("4", 30 + 8, 70 + 15);
  text("5", 50 + 8, 70 + 15);
  text("6", 70 + 8, 70 + 15);
  text("1", 30 + 8, 90 + 15);
  text("2", 50 + 8, 90 + 15);
  text("3", 70 + 8, 90 + 15);
  text("<", 30 + 8, 110 + 15);
  text("0", 50 + 8, 110 + 15);
  text(">", 70 + 8, 110 + 15);
  text("ENTER", 40, 130 + 15);
  text("CANCEL", 40, 150 + 15);
  
  text("104x104 (Default)", 135, 25 + 18);
  text("160x104 (SimTunes)", 135, 50 + 18);
  text("120x96  (Sound Fantasy)", 135, 75 + 18);
  
  strokeWeight(1);
}

void NewMenuInput()
{
  if (cursorX >= 30 && cursorX < 90 && cursorY >= 50 && cursorY < 170)
  {
    int select = (((cursorY - 50) / 20) * 3) + ((cursorX - 30) / 20);
    if (set == 0)
    {
      if (select <= 8 && newres_x < 100)
        newres_x = (newres_x * 10) + (7 + select % 3) - ((select / 3) * 3);
      else if (select == 10 && newres_x < 100)
        newres_x *= 10;
      else if (select == 9)
        newres_x /= 10;
      else if (select == 11)
        set = 1;
    }
    else
    {
      if (select <= 8 && newres_y < 100)
        newres_y = (newres_y * 10) + (7 + select % 3) - ((select / 3) * 3);
      else if (select == 10 && newres_y < 100)
        newres_y *= 10;
      else if (select == 9)
        newres_y /= 10;
      else if (select == 11)
        set = 0;
    }
    
    if (select >= 12 && select < 15 && newres_x > 0 && newres_y > 0)
    {
      //ENTER
      NewDrawing(newres_x, newres_y);
    }
    
    if (select >= 15)
      mode = 0;
  }
  else if (cursorX >= 125 && cursorX < 300 && cursorY >= 25 && cursorY < 100)
  {
    int select = (cursorY - 25) / 25;
    switch (select)
    {
      case 0:
        //104x104 (Default)
        NewDrawing(104, 104);
        break;
      case 1:
        //160*104 (SimTunes)
        NewDrawing(160, 104);
        break;
      case 2:
        //120*96  (Sound Fantasy)
        NewDrawing(120, 96);
        break;
    }
  }
}

/* MIDI Output Select Menu */
void MidiMenuManage()
{
  stroke(0);
  strokeWeight(5);
  fill(80);
  for (int i = 0; i < midi.availableOutputs().length; i++)
  {
    if (midi.availableOutputs()[i].equals(selectedMIDI))
      fill(128);
    else
      fill(80);
    rect(25, 25 + 25 * i, 250, 25);
    fill(255);
    text(midi.availableOutputs()[i], 32, 42 + 25 * i);
  }
  
  fill(80);
  rect(25, 25 + 25 * midi.availableOutputs().length, 250, 25);
  fill(255);
  text("EXIT", 32, 42 + 25 * midi.availableOutputs().length);
}

void MidiMenuInput()
{
  if (cursorX >= 25 && cursorX <= 250 && cursorY >= 25 && cursorY < 25 + 25 * (midi.availableOutputs().length + 1))
  {
    if ((cursorY - 25) / 25 < midi.availableOutputs().length)
    {
      selectedMIDI = midi.availableOutputs()[(cursorY - 25) / 25];
      midi = new MidiBus(this, -1, selectedMIDI);
      mode = 0;
    }
    else if ((cursorY - 25) / 25 == midi.availableOutputs().length)
    {
      mode = 0;
    }
  }
}

/* Cursor */
void CursorManage()
{
  //drawIntImage(cursorPen, 16, 16, pal[pal.length - 2], mouseX, mouseY, 2);
  //image(drawIntPImage(cursorPen, 16, 16, pal[pal.length - 2], 2), mouseX, mouseY);
  if (grabbedInsect < 0)
  {
    cursor(drawIntPImage(cursorPen, 16, 16, pal[pal.length - 2], 2), 0, 0);
  }
  else
    cursor(drawIntPImage(cursorPick, 16, 16, pal[pal.length - 2], 2), 0, 0);
}

/* Draw */
void drawIntImage(int[] imgdat, int _width, int _height, color col, float x, float y, float scale)
{
  PImage img = createImage(_width, _height, ARGB);
  img.loadPixels();
  for (int i = 0; i < imgdat.length; i++)
  {
    switch (imgdat[i])
    {
      case 1:
        img.pixels[i] = col;
        break;
      case 2:
        if (curcolor_id < pal.length)
          img.pixels[i] = pal[curcolor_id];
        else
          img.pixels[i] = pal[rainbow];
        break;
      case 3:
        img.pixels[i] = pal[i - ((i / (pal.length - 1)) * (pal.length - 1))];
        break;
    }
  }
  image(img, x, y, _width * scale, _height * scale);
}

PImage drawIntPImage(int[] imgdat, int _width, int _height, color col, int scale)
{
  PImage img = createImage(_width, _height, ARGB);
  img.loadPixels();
  for (int i = 0; i < imgdat.length; i++)
  {
    for (int k = 0; k < scale; k++)
    {
      for (int j = 0; j < scale; j++)
      {
        switch (imgdat[i])
        {
          case 1:
            img.pixels[i] = col;
            break;
          case 2:
            if (curcolor_id < pal.length)
              img.pixels[i] = pal[curcolor_id];
            else
              img.pixels[i] = pal[rainbow];
            break;
          case 3:
            img.pixels[i] = pal[i - ((i / pal.length) * pal.length)];
            break;
        }
      }
    }
  }
  if (scale != 1)
  {
    PGraphics img_scale = createGraphics(_width * scale, _height * scale);
    img_scale.beginDraw();
    img_scale.image(img, 0, 0, _width * scale, _height * scale);
    img_scale.endDraw();
    return img_scale.get();
  }
  else
    return img;
}