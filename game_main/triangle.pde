class triang extends object
{
  PImage enemy;
  
  triang(float _x, float _y, float _xsize, float _ysize, int _stage)
  {
    super(_x, _y, _xsize, _ysize, _stage);
    
    enemy = loadImage("enemy.png");
  }
  
  void _draw()
  {
    if (show == 1)
    {
      image(enemy, x, y, xsize, ysize);
      //triangle(x, yend, (x+xend)/2, y, xend, yend);
      update();
    }
  }
  
  void update()
  {
    if ( (yend < 0) || (x > width) || (xend < 0) )
    {
      show = 0;
    }
    if (trigger == 1)
    {
      
      if ( ( abs( ( yend - character.y ) ) < 50 ) && ( room==4 ) && random(0, 100) < 10 &&  ( hard == true) )
      {
        if ( x > character.x )
        {
          trigger = 2;
        }
        else
        {
          trigger = 3;
        }
      }
      else
      {
        y -= 20;
        yend -= 20;
      }

    }
    else if (trigger == 2)
    {
      x -= random(5, 10);
      xend = x + xsize;
    }
    else if (trigger == 3)
    {
      x += random(5, 10);
      xend = x + xsize;
    }
  }
}