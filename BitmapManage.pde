/* Drawing */
void BitmapInit()
{
  //Init Image
  img = createGraphics(res_x, res_y);
  img_undo = createGraphics(res_x, res_y);
  bg = createGraphics(res_x, res_y);
  BitmapErase();
}

void BitmapErase()
{
  img.beginDraw();
  img.loadPixels();
  //Empty Bitmap
  for (int i = 0; i < res_x * res_y; i++)
    img.pixels[i] = pal[pal.length - 1];
  img.updatePixels();
  img.endDraw();
}

void BitmapLineRandom()
{
  //Requires Insects to be initialized first
  img.beginDraw();
  img.loadPixels();
  
  int random = 0;
  for (int i = 0; i < res_x; i++)
  {
    random = int(random(0, pal.length + 10));
    if (random >= pal.length - 4)
      random = pal.length - 1;
    img.pixels[i + res_x * (res_y / 2)] = pal[random];
  }
  
  img.updatePixels();
  img.endDraw();  
}

void BitmapMultiLineRandom()
{
  //Requires Insects to be initialized first
  img.beginDraw();
  img.loadPixels();
  
  int random = 0;
  for (int id = 0; id < Insects.length; id++) 
    for (int i = 0; i < res_x; i++)
    {
      random = int(random(0, pal.length + 10));
      if (random >= pal.length - 4)
        random = pal.length - 1;
      img.pixels[i + res_x * ((res_y / (Insects.length + 1)) * (id + 1))] = pal[random];
    }
  
  img.updatePixels();
  img.endDraw();  
}

void BitmapPatternRandom(int space_x, int space_y)
{
  //Requires Insects to be initialized first
  img.beginDraw();
  img.loadPixels();
  
  int random = 0;
  for (int y = 0; y < res_y; y += space_y)
    for (int x = 0; x < res_x; x += space_x)
    {
      random = int(random(0, pal.length - 1));
      img.pixels[x + res_x * (y)] = pal[random];
    }
  
  img.updatePixels();
  img.endDraw();  
}

void BitmapSwapUndo()
{
  //Undo/Redo
  PGraphics img_temp = createGraphics(res_x, res_y);
  img_temp.beginDraw();
  img.beginDraw();
  img_undo.beginDraw();
  
  img_temp.loadPixels();
  img.loadPixels();
  img_undo.loadPixels();
  
  //img_temp = img;
  //img_temp.image(img.get(), 0, 0, res_x, res_y);
  for (int i = 0; i < (res_x * res_y); i++)
    img_temp.pixels[i] = img.pixels[i];
  
  
  //img = img_undo;
  //img.image(img_undo.get(), 0, 0, res_x, res_y);
  for (int i = 0; i < (res_x * res_y); i++)
    img.pixels[i] = img_undo.pixels[i];

  //img_undo = img_temp;
  //img_undo.image(img_temp.get(), 0, 0, res_x, res_y);
  for (int i = 0; i < (res_x * res_y); i++)
    img_undo.pixels[i] = img_temp.pixels[i];
    
  img_temp.updatePixels();
  img.updatePixels();
  img_undo.updatePixels();
  
  img_temp.endDraw();
  img.endDraw();
  img_undo.endDraw();
}

void BitmapKeepUndo()
{
  //img_undo = img;
  img_undo.beginDraw();
  img.loadPixels();
  img_undo.loadPixels();
  
  //img_undo.image(img.get(), 0, 0, res_x, res_y);
  for (int i = 0; i < (res_x * res_y); i++)
    img_undo.pixels[i] = img.pixels[i];
  
  img_undo.updatePixels();
  img_undo.endDraw();
}

void BitmapManage()
{
  //Bitmap
  image(bg, GetLeft(), 0, res_x * scale, res_y * scale);
  image(img, GetLeft(), 0, res_x * scale, res_y * scale);
}

void BitmapBackgroundUpdate()
{
  switch (bgtype)
  {
    case 0:
      BitmapBackgroundBlack();
      break;
    case 1:
      BitmapBackgroundChecker();
      break;
  }
}

void BitmapBackgroundBlack()
{
  bg.beginDraw();
  bg.loadPixels();
  //Empty Bitmap
  for (int i = 0; i < res_x * res_y; i++)
    bg.pixels[i] = palbg[0];
  bg.updatePixels();
  bg.endDraw();
}

void BitmapBackgroundChecker()
{
  bg.beginDraw();
  bg.loadPixels();
  //Empty Bitmap
  for (int y = 0; y < res_y; y++)
  {
    for (int x = 0; x < res_x; x++)
    {
      if (((x & 8) != 8) ^ ((y & 8) == 8))
        bg.pixels[x + y * res_x] = palbg[1];
      else
        bg.pixels[x + y * res_x] = palbg[0];
    }
  }
  bg.updatePixels();
  bg.endDraw();
}

boolean IsCursorOnBitmap()
{
  return (cursorX >= GetLeft() && cursorY >= 0 && (cursorX - GetLeft()) < (res_x * scale) && cursorY < (res_y * scale));
}

void BitmapInput()
{
  img.beginDraw();
  if (IsCursorOnBitmap()) {
    if (mouseButton == LEFT)
    {
      if (curcolor_id == (pal.length - 1))
        img.strokeWeight(3);
      else
        img.strokeWeight(1);
      
      if (curcolor_id < pal.length)
      {
        img.stroke(curcolor);
      }
      else
      {
        img.stroke(pal[rainbow]);
        rainbow++;
        if (rainbow >= pal.length - 4)
          rainbow = 0;
      }
    }
    else
    {
      img.stroke(pal[pal.length - 1]);
    }
    img.line(((cursorX - GetLeft()) - (scale / 2)) / scale, (cursorY - (scale / 2)) / scale, ((cursorpX - GetLeft()) - (scale / 2)) / scale, (cursorpY - (scale / 2)) / scale);
    img.loadPixels();
    //Make sure to make black pixels transparent (not really optimized)
    for (int i = 0; i < (res_x * res_y); i++)
      if (img.pixels[i] == #000000)
        img.pixels[i] = 0x00000000;
    img.updatePixels();
  }
  img.endDraw();
}