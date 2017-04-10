//Effect class
public class Effect {
  public int type;
  public int frame;
  public float x;
  public float y;
  
  public Effect() {
    Reset();
  }
  
  public void Set(int _type, float _x, float _y) {
    this.type = _type;
    this.frame = 0;
    this.x = _x;
    this.y = _y;
  }
  
  public void Reset()
  {
    this.type = 0;
    this.frame = 0;
    this.x = 0;
    this.y = 0;
  }
}

Effect[] Effects;

/* Effects */
void EffectInit(int nb)
{
  //Init Effect
  Effects = new Effect[nb];
  for (int i = 0; i < Effects.length; i++)
    Effects[i] = new Effect();
}

void EffectManage()
{
  for (int i = 0; i < Effects.length; i++)
  {
    switch (Effects[i].type)
    {
      case 1:
        //Circle Echo
        if (Effects[i].frame > (frameRate / 2))
        {
          Effects[i].Reset();
          break;
        }
        noFill();
        
        stroke(pal[(Effects[i].frame / 3) & (pal.length - 1)]);
        strokeWeight((frameRate / 2) - Effects[i].frame);
        float effectsize = (Effects[i].frame / (frameRate / 30)) * scale;
        ellipse(Effects[i].x, Effects[i].y, effectsize, effectsize);
        Effects[i].frame++;
        Effects[i].frame++;
        break;
      case 2:
        //Square Echo
        if (Effects[i].frame > (frameRate / 2))
        {
          Effects[i].Reset();
          break;
        }
        noFill();
        
        stroke(pal[(Effects[i].frame / 3) & (pal.length - 1)]);
        strokeWeight((frameRate / 2) - Effects[i].frame);
        effectsize = (Effects[i].frame / (frameRate / 30)) * scale;
        rect(Effects[i].x - effectsize / 2, Effects[i].y - effectsize / 2, effectsize, effectsize);
        Effects[i].frame++;
        Effects[i].frame++;
        break;
      case 3:
        //Triangle Echo
        if (Effects[i].frame > (frameRate / 2))
        {
          Effects[i].Reset();
          break;
        }
        noFill();
        
        stroke(pal[(Effects[i].frame / 3) & (pal.length - 1)]);
        strokeWeight((frameRate / 2) - Effects[i].frame);
        effectsize = (Effects[i].frame / (frameRate / 30)) * scale;
        triangle(Effects[i].x + (scale / 2), Effects[i].y - (scale / 2) - effectsize / 2, Effects[i].x + (scale / 2) - effectsize / 2, Effects[i].y - (scale / 2) + effectsize / 2, Effects[i].x + (scale / 2) + effectsize / 2, Effects[i].y - (scale / 2) + effectsize / 2);
        Effects[i].frame++;
        Effects[i].frame++;
        break;
    }
  }
}

void StartEffect(int id, int type, float x, float y)
{
  //Types:
  //0 = None
  //1 = Circle Echo
  //2 = Square Echo
  //3 = Triangle Echo
  Effects[id].Set(type, x, y);
}