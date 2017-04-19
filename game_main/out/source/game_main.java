import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class game_main extends PApplet {

nemo character;
solid plat;
int room = 0;

public void setup()
{
  
  frameRate(60);
  
  character = new nemo(width/2, height/2, 50);
  plat = new solid(0, 0, 0, 0);
}

public void draw()
{
  background(0xffB0B8FC);
  if (room==0)
  {
    textSize(20);
    text("Basic Modeling and Practice", 0, 0);
  }
  else if (room==1)
  {
    character._draw();
    character.x_move();
    plat._draw();
  }
  
}
class nemo extends object
{
  float xspeed;
  float yspeed;
  float xaccel;
  float yaccel;
  float xend;
  float yend;

  boolean jump=false;
  
  final int max_speed = 15;
  final int jump_speed = 10;
  final float accel = 0.1f;
  final float gravity = 0.5f;
  final float frict = 0.9f;

  nemo(float _x, float _y, float _size)
  {
    super(_x, _y, _size);
    xspeed = 0;
    xaccel = 0;
    
  }
  
  public void _draw()
  {
    rect(x, y, size, size);
    update();
  }
  
  public void update()
  {
    physics();
  }
  
  public void x_move()
  {
    x += xspeed;
  }

  public void physics()
  {
    if (abs(xspeed) > 0)
    {
      xspeed *= frict;
      xaccel *= frict;
    }

    if (xspeed > max_speed)
    {
      xspeed = max_speed;
      xaccel = 0;
    }
    else if (xspeed < -max_speed)
    {
      xspeed = -max_speed;
      xaccel = 0;
    }
    else
    {
      if (key_a) xaccel -= accel;
      if (key_d) xaccel += accel;
    }

    xspeed += xaccel;
    
    y += yspeed;
    
    
    
    yend = y + size;

    if (yend > height) y=0;

    yspeed += gravity;

        if (jump==true)
    {
        
      if (yend >= plat.y)
      {
        jump=false;
      }
    }
    else if (jump==false)
    {
      if (yend >= plat.y)
      {
        yspeed=0;
        y = plat.y - size;
      }
      else
      {
        
      }
      
      if (key_w)
      {
        jump=true;
        yspeed += -jump_speed;
      }
      
    }
  }
}
class object
{
  float x;
  float y;
  float size;
  float xsize;
  float ysize;
  
  object(float _x, float _y, float _size)
  {
    x = _x;
    y = _y;
    size = _size;
  }
  
  object(float _x, float _y, float _xsize, float _ysize)
  {
    x = _x;
    y = _y;
    xsize = _xsize;
    ysize = _ysize;
  }
  
  public void _draw()
  {

  }
  
  public void update()
  {
    
  }
}
class solid extends object
{
  
  
  solid(float _x, float _y, float _xsize, float _ysize)
  {
    super(_x, _y, _xsize, _ysize);
  }
  
  public void _draw()
  {
    rect(x, y, xsize, ysize);
    update();
  }
  
  public void update()
  {
    x = -2;
    y = 643;
    xsize = 1209;
    ysize = 81;
  }
}
boolean key_a, key_d, key_w, key_s;

public void keyPressed() {
  checkey(key, true);
}
 
public void keyReleased() {
  checkey(key, false);
}

public boolean checkhit_rect( float x1s, float x1size, float y1s, float y1size, float x2s, float x2size, float y2s, float y2size)
{
  float x1e = x1s + x1size;
  float y1e = y1s + y1size;
  float x2e = x2s + x2size;
  float y2e = y2s + y2size;
  
  //if ( (x1s > x2e) && (x1e < x2s)
  
  /*
  
  for( float x1 = x1s; x1 != x1e; x1 += 1)
  {
    if (x1 > x1e)
    {
      x1 = x1e;
    }
    for( float y1 = y1s; y1 != y1e; y1 += 1)
    {
      if (y1 > y1e)
      {
        y1 = y1e;
      }
      for( float x2 = x2s; x2 != x2e; x2 += 1)
      {
        if (x2 > x2e)
        {
          x2 = x2e;
        }
        for( float y2 = y2s; y2 != y2e; y2 += 1)
        {
          if (y2 > y2e)
          {
            y2 = y2e;
          }
          
          if (((int)x1 == (int)x2) && ((int)y1 == (int)y2))
          {
            return true;
          }
          
        }
      }
    }
  }
  */
  return false;
  
}

public boolean checkey(char k, boolean b) 
{
  switch (k) 
  {
    case 'a':
    case 'A':
      return key_a = b;
 
    case 'd':
    case 'D':
      return key_d = b;
 
    case 's':
    case 'S':
      return key_s = b;
 
    case 'w':
    case 'W':
      return key_w = b;
 
    default:
      return b;
  }
}
  public void settings() {  size(1200, 800, P2D);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "game_main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
