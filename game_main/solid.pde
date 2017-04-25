class solid extends object
{
  PImage plat;
  PImage plat_up;
  
  float xspeed;
  
  int dir=1;
  
  solid(float _x, float _y, float _xsize, float _ysize, int _coli, int _stage)
  {
    super(_x, _y, _xsize, _ysize, _coli, _stage);
    
    plat = loadImage("plat.png");
    plat_up = loadImage("plat_up.png");
  }
  
  void _draw()
  {
    if (coli == coli_up) image(plat_up, x, y, xsize, ysize);
    else image(plat, x, y, xsize, ysize);
    //fill(0, 255 * 75 / 100);
    //rect(x, y, xsize, ysize);
    update();
  }
  
  void update()
  {
    if (trigger == 1)
    {
      y -= 1;
      yend = y + ysize;
      
    }
    else if (trigger == 2)
    {
      xspeed = random(1, 10)*dir;
      x += xspeed;
      xend = x + xsize;
      
      if ( ( x > width - 100 ) )
      {
        dir = -1;
      }
      else if ( xend < 0 + 100 )
      {
        dir = 1;
      }
    }
  }
}