import processing.sound.*;

nemo character;
solid[] plat = new solid[28];
triang[] tri = new triang[44];
Table map;
int room = -1;
int plat_num = 0;
int tri_num = 0;
int score = 2000000000;

Timer[] timer = new Timer[3];
// timer[0] = stage4 triangle
// timer[1] = character die
// timer[2] = start

SoundFile sound_intro_bgm;
SoundFile sound_ending;
SoundFile sound_game_bgm;

PImage image_ending;
PImage image_ending_text;

Dragon dragon;

boolean hard = false;

boolean intro_bgm_play = false, ending_play = false, game_bgm_play = false;

final int PLAT=1, TRI=2;
final int coli_up = 1, coli_left = 2, coli_right = 3, coli_down = 4;

boolean key_a, key_d, key_w, key_s, key_r;

void keyPressed() {
  checkey(key, true);
}
 
void keyReleased() {
  checkey(key, false);
}


boolean checkey(char k, boolean b) 
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

    case 'r':
    case 'R':
      return key_r = b;
 
    default:
      return b;
  }
}

class Timer
{
  int savedtime; // When Timer started
  int totaltime; // How long Timer should last

  Timer()
  {
    totaltime = 0;
  }

  void start()
  {
    savedtime = millis();
  }

  boolean isFinished()
  {
    int passedtime = millis() - savedtime;
    return (passedtime >= totaltime) ? true : false;
  }
}

void stage_check(int _x, int _y, int _check)
{
  if ( (character.stage != room) && _check == 1 )
    {
      character.x = _x;
      character.y = _y;
      character.stage = room;
      if (room == 4) timer[0].start();
    }
  else if (_check == 0)
  {
    character.x = _x;
    character.y = _y;
    character.stage = room;
    character.show = 1;
    character.play_die = false;
    fill(255, 255, 255, 255);
  }

    
    
}

boolean checkhit_point( float x1, float y1, float x2, float y2, float dist )
{
  if ( ( abs(x1 - x2) < dist ) && ( abs(y1 - y2) < dist ) ) 
  {
    return true;
  }
  
  return false;
}

/*
boolean checkhit_rect( float x1s, float x1size, float y1s, float y1size, float x2s, float x2size, float y2s, float y2size)
{
  float x1e = x1s + x1size;
  float y1e = y1s + y1size;
  float x2e = x2s + x2size;
  float y2e = y2s + y2size;
  
  //if ( (x1s > x2e) && (x1e < x2s)
  
  
  
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
  
  return false;
  
}
*/