int grabbedInsect;            //Grabbed Insect (-1 = None)
int selectedInsect;           //Selected Insect

color[] insectColorDefault = {
  #FFFF00,
  #00FF00,
  #5080FF,
  #FF0000,
};

//Insect class
public class Insect {
  public boolean enable;
  
  public float x;
  public float y;
  public float speed;   //Pixel per second
  public int direction; //0 = Down, 1 = Right, 2 = Up, 3 = Left
  public color colorbug;
  
  public int px;
  public int py;
  
  public float col_x;
  public float col_y;
  
  public int soundType;
  public int soundInst;
  public int soundNoteID;
  
  public Insect(color _color) {
    this.enable = false;
    this.x = 0;
    this.y = 0;
    this.speed = 0;
    this.direction = 0;
    this.colorbug = _color;
    
    this.px = 0;
    this.py = 0;
    
    this.col_x = 0;
    this.col_y = 0;
    
    this.soundType = 0;
    this.soundInst = 0;
    this.soundNoteID = 0;
  }
  
  public void Set(float _x, float _y, float _speed, int _direction, int _soundType, int _soundInst, int _soundNoteID, color _color)
  {
    this.enable = true;
    this.x = _x;
    this.y = _y;
    this.speed = _speed;
    this.direction = _direction;
    this.soundType = _soundType;
    this.soundInst = _soundInst;
    this.soundNoteID = _soundNoteID;
    this.colorbug = _color;
  }
  
  public void Set(float _x, float _y, float _speed, int _direction, color _color)
  {
    this.enable = true;
    this.x = _x;
    this.y = _y;
    this.speed = _speed;
    this.direction = _direction;
    this.colorbug = _color;
  }
  
  public void SetSound(int _soundType, int _soundInst, int _soundNoteID)
  {
    this.enable = true;
    this.soundType = _soundType;
    this.soundInst = _soundInst;
    this.soundNoteID = _soundNoteID;
  }
  
  public void Turn(int _turn)
  {
    if (_turn == D_LEFT)
    {
      this.direction++;
    }
    else if (_turn == D_RIGHT)
    {
      this.direction--;
    }
    else
    {
      this.direction++;
      this.direction++;
    }
    
    this.direction &= 3;
  }
}

Insect[] Insects;

/* Insect */
void InsectInit(int nb)
{
  //Init Insect
  Insects = new Insect[nb];
  for (int i = 0; i < Insects.length; i++)
  {
    Insects[i] = new Insect(insectColorDefault[i & 3]);
  }
  
  grabbedInsect = -1;
  selectedInsect = 0;
}

void InsectDefault(int nb)
{
  if (nb == 0)
  {
    return;
  }
  else if (nb == 1)
  {
    Insects[0].x = (res_x / 2f) * scale;
    Insects[0].y = (res_y / 2f) * scale;
    Insects[0].speed = 0.25;
    Insects[0].direction = int(random(D_DOWN, D_LEFT));
  }
  else if (nb == 2)
  {
    Insects[0].x = (res_x / 4f) * scale;
    Insects[0].y = (res_y / 4f) * scale;
    Insects[0].speed = 0.25;
    Insects[0].direction = int(random(D_DOWN, D_RIGHT));
    
    Insects[1].x = (res_x * (3f / 4f)) * scale;
    Insects[1].y = (res_y * (3f / 4f)) * scale;
    Insects[1].speed = 0.25;
    Insects[1].direction = int(random(D_UP, D_LEFT));
  }
  else if (nb == 3)
  {
    Insects[0].x = (res_x / 4f) * scale;
    Insects[0].y = (res_y / 4f) * scale;
    Insects[0].speed = 0.25;
    Insects[0].direction = int(random(D_DOWN, D_RIGHT));
    
    Insects[1].x = (res_x * (3f / 4f)) * scale;
    Insects[1].y = (res_y * (3f / 4f)) * scale;
    Insects[1].speed = 0.25;
    Insects[1].direction = int(random(D_UP, D_LEFT));
    
    Insects[2].x = (res_x / 2f) * scale;
    Insects[2].y = (res_y / 2f) * scale;
    Insects[2].speed = 0.25;
    Insects[2].direction = int(random(D_DOWN, D_LEFT));
  }
  else if (nb == 4)
  {
    Insects[0].x = (res_x / 4f) * scale;
    Insects[0].y = (res_y / 4f) * scale;
    Insects[0].speed = 0.25;
    Insects[0].direction = D_LEFT;
    
    Insects[1].x = (res_x / 4f) * scale;
    Insects[1].y = (res_y / 4f) * scale;
    Insects[1].speed = 0.25;
    Insects[1].direction = D_UP;
    
    Insects[2].x = (res_x * (3f / 4f)) * scale;
    Insects[2].y = (res_y * (3f / 4f)) * scale;
    Insects[2].speed = 0.25;
    Insects[2].direction = D_RIGHT;
    
    Insects[3].x = (res_x * (3f / 4f)) * scale;
    Insects[3].y = (res_y * (3f / 4f)) * scale;
    Insects[3].speed = 0.25;
    Insects[3].direction = D_DOWN;
  }
}

void InsectLineRandom()
{
  int space = int(random(1, res_x / 4));
  for (int i = 0; i < Insects.length; i++)
  {
    Insects[i].Set((space * i) * scale + scale / 2, (res_y / 2) * scale + scale / 2, 0.25, D_RIGHT, insectColorDefault[i & 3]);
  }
}

void InsectMultiLineRandom()
{
  for (int i = 0; i < Insects.length; i++)
  {
    Insects[i].Set(0 * scale + scale / 2, ((res_y / (Insects.length + 1)) * (i + 1)) * scale + scale / 2, 0.25, D_RIGHT, insectColorDefault[i & 3]);
  }
}

void InsectPatternRandom(int space_x, int space_y)
{
  for (int i = 0; i < Insects.length; i++)
  {
    Insects[i].Set(((res_x / space_x / 2) * space_x) * scale + scale / 2, ((res_y / space_y / 2) * space_y) * scale + scale / 2, 0.25, i & 3, insectColorDefault[i & 3]);
  }
}

void InsectDisplay()
{
  for (int id = 0; id < Insects.length; id++)
  {
    if (id != selectedInsect)
      noStroke();
    else
      stroke(255);
    fill(Insects[id].colorbug);
    ellipse(GetLeft() + Insects[id].x, Insects[id].y, 15, 15);
  }
}

void InsectDisplay(int id)
{
  if (id != selectedInsect)
    noStroke();
  else
    stroke(255);
  fill(Insects[id].colorbug);
  ellipse(GetLeft() + Insects[id].x, Insects[id].y, 15, 15);
}

void InsectManage()
{
  //Insect Management
  for (int id = 0; id < Insects.length; id++)
  {
    if (!Insects[id].enable)
      continue;
    
    //Wrap around
    if (Insects[id].x >= (res_x * scale) - 1)
      Insects[id].x = 0;
    else if (Insects[id].x < 0)
      Insects[id].x = (res_x * scale) - 1;
      
    if (Insects[id].y >= (res_y * scale) - 1)
      Insects[id].y = 0;
    else if (Insects[id].y < 0)
      Insects[id].y = (res_y * scale) - 1;
    
    //Movement
    switch (Insects[id].direction) {
      case D_DOWN:
        Insects[id].y += Insects[id].speed * scale / (frameRate / 30);
        Insects[id].col_x = Insects[id].x;
        Insects[id].col_y = Insects[id].y - (scale / 2);
        if (Insects[id].col_y < 0)
          Insects[id].col_y += res_y * scale; 
        break;
      case D_RIGHT:
        Insects[id].x += Insects[id].speed * scale / (frameRate / 30);
        Insects[id].col_x = Insects[id].x - (scale / 2);
        Insects[id].col_y = Insects[id].y;
        if (Insects[id].col_x < 0)
          Insects[id].col_x += res_x * scale; 
        break;
      case D_UP:
        Insects[id].y -= Insects[id].speed * scale / (frameRate / 30);
        Insects[id].col_x = Insects[id].x;
        Insects[id].col_y = Insects[id].y + (scale / 2);
        if (Insects[id].col_y >= (res_y * scale))
          Insects[id].col_y -= res_y * scale;
        break;
      case D_LEFT:
        Insects[id].x -= Insects[id].speed * scale / (frameRate / 30);
        Insects[id].col_x = Insects[id].x + (scale / 2);
        Insects[id].col_y = Insects[id].y;
        if (Insects[id].col_x >= (res_x * scale))
          Insects[id].col_x -= res_x * scale;
        break;
    }

    InsectDisplay(id);
    
    //Pixel Detection
    img.loadPixels();
  
    color insectColor = img.get((int)(Insects[id].col_x / scale), (int)(Insects[id].col_y / scale));
    int insectColorID = 0;
    
    for (int i = 0; i < pal.length; i++)
      if (insectColor == pal[i])
      {
        insectColorID = i;
        break;
      }
    
    //Check Pixel (compare with previous so it doesn't repeat)
    if ((Insects[id].px != (int)(Insects[id].col_x / scale) || (Insects[id].py != (int)(Insects[id].col_y / scale))))
    {
      //Play Effect and Sound
      if (insectColor != pal[pal.length - 1])
      {
        StartEffect(id, (Insects[id].soundInst % 3) + 1, GetLeft() + Insects[id].x, Insects[id].y);
        StartSound(id, Insects[id].soundType, Insects[id].soundInst, (int)frameRate / 12, notelist[Insects[id].soundNoteID][insectColorID], insectColorID);
      }
      
      if (insectColor == pal[pal.length - 4])
      {
        //Turn Left
        Insects[id].Turn(D_LEFT);
      }
      else if (insectColor == pal[pal.length - 3])
      {
        //Turn Right
        Insects[id].Turn(D_RIGHT);
      }
      else if (insectColor == pal[pal.length - 2])
      {
        //Turn Back
        Insects[id].Turn(D_DOWN);
      }
    }
    
    //Constant X/Y position if vertical/horizontal movement, insect should be snapped to grid
    switch (Insects[id].direction)
    {
      case D_UP:
      case D_DOWN:
        Insects[id].x = (int)(Insects[id].x / scale) * scale + (scale / 2);
        break;
      case D_LEFT:
      case D_RIGHT:
        Insects[id].y = (int)(Insects[id].y / scale) * scale + (scale / 2);
        break;
    }
    
    //Keep previous X/Y pixel position
    Insects[id].px = (int)(Insects[id].col_x / scale);
    Insects[id].py = (int)(Insects[id].col_y / scale);
  }
}

int IsCursorOnInsect()
{
  for (int i = 0; i < Insects.length; i++)
  {
    if (((mouseX - GetLeft()) >= (Insects[i].x - (15f / 2f))) && ((mouseX - GetLeft()) <= (Insects[i].x + (15f / 2f)))
     && (mouseY >= (Insects[i].y - (15f / 2f))) && (mouseY <= (Insects[i].y + (15f / 2f))))
    {
      return i;
    }
  }
  return -1;
}

void GrabInsect(int id)
{
  if (id >= 0)
  {
    Insects[id].enable = false;
    grabbedInsect = id;
    selectedInsect = id;
  }
}

void UngrabInsect()
{
  //Snap to Grid
  if (grabbedInsect >= 0)
  {
    Insects[grabbedInsect].x = (int)(Insects[grabbedInsect].x / scale) * scale + (scale / 2);
    Insects[grabbedInsect].y = (int)(Insects[grabbedInsect].y / scale) * scale + (scale / 2);
    Insects[grabbedInsect].enable = true;
    grabbedInsect = -1;
  }
}

void GrabInsectDraw()
{
  if (grabbedInsect >= 0)
  {
    Insects[grabbedInsect].x = mouseX - GetLeft();
    Insects[grabbedInsect].y = mouseY;
    InsectDisplay(grabbedInsect);
  }
}