
class nemo extends object
{
  PImage die;
  
  float xspeed;
  float yspeed;
  float xaccel;
  float yaccel;
  
  boolean jump=false;
  boolean play_die = false;
  
  final int max_speed = 15;
  final int jump_speed = 10;
  final float accel = 0.1;
  final float gravity = 0.5;
  final float frict = 0.9;
  
  SoundFile sound_jump;
  SoundFile sound_die;
  
  

  
  nemo(float _x, float _y, float _size)
  {
    super(_x, _y, _size);
    xspeed = 0;
    xaccel = 0;
    stage = 1;
    
   sound_jump = new SoundFile(game_main.this, "jump.wav");
   sound_die = new SoundFile(game_main.this, "die.mp3");
   
   die = loadImage("die.png");
  }
  
  void _draw()
  {
    if (show == 1)
    {
      rect(x, y, size, size);
      update();
    }
    else if ( show == 0 )
    {
      if (play_die == false)
      {
        if ( game_bgm_play == true)
        {
          sound_game_bgm.stop();
          game_bgm_play = false;
        }
        sound_die.play();
        timer[1].totaltime = 2000;
        timer[1].start();
        play_die = true;
      }
      else if ( timer[1].isFinished() )
      {
        image(die, 0, 0, 1200, 800);
      }
    }
  }
  
  void update()
  {
    physics();
    if (this.x > width)
    {
      room++;
    }
    
    
    
    // if (yend > height)
    // {
    //   show = 0;
    // } 
  }

  void physics()
  {
    move_basic();
    move_jump();
    
    xend = x + xsize;
    yend = y + ysize;
    
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (this.stage == plat[i].stage)
      {
        if ((plat[i].xend > this.x) && (plat[i].coli == coli_right) && (xspeed < 0))
        {
          xspeed = -xspeed;
          this.x = plat[i].xend;
        }
        else if ((plat[i].x < this.x + xsize) && (plat[i].yend > y) && (plat[i].y < yend) && (plat[i].coli == coli_left) && (xspeed > 0))
        {
          xspeed = -xspeed;
          this.x = plat[i].x - xsize;
        }
      }
    }
    
  }
  
  void move_basic()
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
    
    x += xspeed;
    
    yend = y + size;

    

    yspeed += gravity;
  }

  void move_jump()
  {
    for ( int i=0 ; i < plat_num ; i++)
      {
        if (this.stage == plat[i].stage)
        {
          if ((yend >= plat[i].y) && (xend > plat[i].x) && (x < plat[i].xend) && (yend < plat[i].yend) && plat[i].coli == coli_up)  
          {
            if ( (jump==true) && (yspeed >= 0) )
            {
              jump=false;
            }
            if ( (jump==false))
            {
              yspeed=0;
              y = plat[i].y - size;
            }
          }
        }
      }
    
    if (jump==false)
    {
      
      
      if (key_w)
      {
        jump=true;
        yspeed += -jump_speed;
        sound_jump.play();
      }
      
    }
  }
}