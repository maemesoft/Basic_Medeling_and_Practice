import processing.sound.*;

final int PLAT=1, TRI=2;
final int coli_up = 1, coli_left = 2, coli_right = 3, coli_down = 4;

solid[] plat = new solid[28];
triang[] tri = new triang[44];
Timer[] timer = new Timer[3];
// timer[0] = stage3~4 triangle
// timer[1] = character die
// timer[2] = start

Dragon dragon;
nemo character;

Table map;

int init = 0;
int room = -1;
int plat_num = 0;
int tri_num = 0;
int score = 2000000000;
int start_time=0;

boolean hard = false;
boolean intro_bgm_play = false, ending_play = false, game_bgm_play = false;
boolean key_a, key_d, key_w, key_s, key_r;

SoundFile sound_intro_bgm;
SoundFile sound_ending;
SoundFile sound_game_bgm;

PImage image_start;
PImage image_ending;
PImage image_ending_text;
PImage image_bg1;
PImage image_Atext;
PImage image_Aon;
PImage image_Aoff;
PImage image_Wtext;
PImage image_Won;
PImage image_Woff;
PImage image_Dtext;
PImage image_Don;
PImage image_Doff;
PImage easyon;
PImage easyoff;
PImage hardon;
PImage hardoff;


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

void Create_plat(int s, int e)
{
    for ( int i=s ; i <= e ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
}

void Create_tri(int s, int e)
{
    for ( int i=s ; i <= e ; i++)
    {
      if (tri[i].stage == room) tri[i]._draw();
      if ( checkhit_point( (character.x + character.xend) / 2 , (character.y + character.yend) / 2 , (tri[i].x + tri[i].xend) / 2 , (tri[i].y + tri[i].yend) / 2 , 25 ) )
      {
        character.show = 0;
      }
    }
}

void Draw_key()
{
    if (key_a) image(image_Aon, 100, 100, 100, 100);
    else image(image_Aoff, 100, 100, 100, 100);
    image(image_Atext, 100, 210, 100, 50);

    if (key_w) image(image_Won, 100+150, 100, 100, 100);
    else image(image_Woff, 100+150, 100, 100, 100);
    image(image_Wtext, 100+150, 210, 100, 50);

    if (key_d) image(image_Don, 100+300, 100, 100, 100);
    else image(image_Doff, 100+300, 100, 100, 100);
    image(image_Dtext, 100+300, 210, 100, 50);
}

void Loading_texture()
{
    background(0);
    fill(255);
    rect(200, 600, 800, 100);
    fill(#B0B8FC);
    rect(200, 600, 800 / (5-init), 100);
    textAlign(CENTER);
    textSize(72);
    fill(0);
    text("Loading ( " + init + " / 4)", width/2, 675);
}

void Loading_Setup()
{
  if (init == 0)
    {
      noStroke();
      sound_intro_bgm = new SoundFile(game_main.this, "intro_bgm.mp3");
      sound_intro_bgm.play();
      intro_bgm_play = true;
      init = 1;
    }
    else if (init == 1)
    {
      timer_init();
      character = new nemo(width/8, height/2 +300, 50);
      dragon = new Dragon( 1, 1, 0, 0, 1 );
      init = 2;
    }
    else if (init == 2)
    {
      sound_ending = new SoundFile(game_main.this, "ending.mp3");
      sound_game_bgm = new SoundFile(game_main.this, "Rendezvous_City.wav");
      
      image_start = loadImage("start.png");
      image_ending = loadImage("ending.png");
      image_ending_text = loadImage("ending_text.png");
      image_bg1 = loadImage("bg1.png");
      image_Aoff = loadImage("Aoff.png");
      image_Aon = loadImage("Aon.png");
      image_Atext = loadImage("Atext.png");
      image_Woff = loadImage("Woff.png");
      image_Won = loadImage("Won.png");
      image_Wtext = loadImage("Wtext.png");
      image_Doff = loadImage("Doff.png");
      image_Don = loadImage("Don.png");
      image_Dtext = loadImage("Dtext.png");
      easyon = loadImage("easyon.png");
      easyoff = loadImage("easyoff.png");
      hardon = loadImage("hardon.png");
      hardoff = loadImage("hardoff.png");
      init = 3;
    }
    else if (init == 3)
    {
      Load_map();
      timer[2].start();
      init = 4;
    }
    else if (init == 4)
    {
      if (timer[2].isFinished())
      {
        room = 0;
      }
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
      if ( ((room == 3) && (hard == true)) || (room==4)) timer[0].start();
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

void Load_map()
{
  map = loadTable("map.csv", "header");
  
  for ( TableRow row : map.rows() ) 
  {
    int item = row.getInt("item");
    
    if (item == PLAT)
    {
      plat[plat_num] = new solid(row.getInt("x"), row.getInt("y"), row.getInt("xsize"), row.getInt("ysize"), row.getInt("coli"), row.getInt("stage"));
      plat_num++;
    }
    
    if (item == TRI)
    {
      tri[tri_num] = new triang(row.getInt("x"), row.getInt("y"), row.getInt("xsize"), row.getInt("ysize"),  row.getInt("stage"));
      tri_num++;
    }
  }
}

void room0_button()
{
    fill(255);
    textSize(70);
    textAlign(CENTER);
    if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101) )
    {
      image(easyon, width/2 - 238/2, height/2 + 10 - 78/2 + 101, 238, 78);
      // fill(0);
      // rectMode(CENTER);
      // rect(width/2, height/2 + 101, 238, 78);
      // textSize(50);
      // fill(255);
      // text("Easy", width/2, height/2 + 127);
    }
    else
    {
      image(easyoff, width/2 - 238/2, height/2 + 10 - 78/2 + 101, 238, 78);
      // fill(255);
      // rectMode(CENTER);
      // rect(width/2, height/2 + 101, 238, 78);
      // textSize(50);
      // fill(0);
      // text("Easy", width/2, height/2 + 127);
    }
    
    if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101 + 101) )
    {
      image(hardon, width/2 - 238/2, height/2 + 10 - 78/2 + 101 + 101, 238, 78);
      // fill(0);
      // rect(width/2, height/2 + 101 + 101, 238, 78);
      // textSize(50);
      // fill(255);
      // text("Hard", width/2, height/2 + 127 + 101);
    }
    else
    {
      image(hardoff, width/2 - 238/2, height/2 + 10 - 78/2 + 101 + 101, 238, 78);
      // fill(255);
      // rect(width/2, height/2 + 101 + 101, 238, 78);
      // textSize(50);
      // fill(0);
      // text("Hard", width/2, height/2 + 127 + 101);
    }
    
    
    
    if (mousePressed)
    {
      if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101) )
      {
        room=1;
      }
      else if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101 + 101) )
      {
        hard = true;
        room=1;
      }
    }
}

void timer_init()
{
  for(int i = 0 ; i < timer.length ; i++)
  {
    timer[i] = new Timer();
  }
  timer[0].totaltime = 250;
  timer[2].totaltime = 1000;
  
  timer[2].start();  
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