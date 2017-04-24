void setup()
{
  size(1200, 800, P2D);
  frameRate(60);
  smooth();
  
  noStroke();
  
  for(int i = 0 ; i < timer.length ; i++)
  {
    timer[i] = new Timer();
  }
  timer[0].totaltime = 250;
  timer[2].totaltime = 3000;
  
  timer[2].start();
  
  sound_intro_bgm = new SoundFile(game_main.this, "intro_bgm.mp3");
  sound_ending = new SoundFile(game_main.this, "ending.mp3");
  sound_game_bgm = new SoundFile(game_main.this, "Rendezvous_City.wav");
  
  image_ending = loadImage("ending.png");
  image_ending_text = loadImage("ending_text.png");
  
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

  character = new nemo(width/8, height/2 +300, 50);

  dragon = new Dragon( 1, 1, 0, 0, 1 );
}

void draw()
{
  background(#B0B8FC);
  
  if ( (intro_bgm_play == true) && (room > 0) )
    {
      sound_intro_bgm.stop();
      intro_bgm_play = false;
    }
  
  if (room==0)
  {
    fill(255);
    textSize(70);
    textAlign(CENTER);
    text("Basic Modeling and Practice", width/2, height/2 + -143);
    
    if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101) )
    {
      fill(0);
      rectMode(CENTER);
      rect(width/2, height/2 + 101, 238, 78);
      textSize(50);
      fill(255);
      text("Easy", width/2, height/2 + 127);
    }
    else
    {
      fill(255);
      rectMode(CENTER);
      rect(width/2, height/2 + 101, 238, 78);
      textSize(50);
      fill(0);
      text("Easy", width/2, height/2 + 127);
    }
    
    if ( (mouseX >= width/2 - 238/2) && (mouseX <=  width/2 + 238/2) && (mouseY >= height/2 + 10 - 78/2 + 101 + 101) && (mouseY <= height/2 + 10 + 78/2 + 101 + 101) )
    {
    fill(0);
    rect(width/2, height/2 + 101 + 101, 238, 78);
    textSize(50);
    fill(255);
    text("Hard", width/2, height/2 + 127 + 101);
    }
    else
    {
    fill(255);
    rect(width/2, height/2 + 101 + 101, 238, 78);
    textSize(50);
    fill(0);
    text("Hard", width/2, height/2 + 127 + 101);
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
  else if (room == -1)
  {
    if (intro_bgm_play == false)
    {
       sound_intro_bgm.loop();
       intro_bgm_play = true;
    }
    
    background(255);
    fill(#B0B8FC);
    rect(0, 0, 1200 * (abs(millis() - timer[2].savedtime)) / 3000, 800);
    if (timer[2].isFinished())
    {
      room = 0;
    }
  }
  else if (room==1)
  {
    fill(255);
    rectMode(CORNER);
    
    textSize(70);
    textAlign(CENTER);
    text("Press A or D or W", width/2, height/2 + -143);
    
    if ( (game_bgm_play == false) && (character.show == 1)) 
    {
      sound_game_bgm.loop();
      game_bgm_play = true;
    }

    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    
    character._draw();
  }
  else if (room==2)
  {
    fill(255);
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    
    stage_check(width/8, height/2 + 300, 1);
    character._draw();
  }
  else if (room == 3)
  {
    fill(255);
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    for ( int i=0 ; i < tri_num ; i++)
    {
      if (tri[i].stage == room) tri[i]._draw();
      if ( checkhit_point( (character.x + character.xend) / 2 , (character.y + character.yend) / 2 , (tri[i].x + tri[i].xend) / 2 , (tri[i].y + tri[i].yend) / 2 , 25 ) )
      {
        character.show = 0;
      }
    }
    stage_check(100, 200, 1);
    character._draw();
    // if (character.yend > 650)
    // {
    //   character.show = 0;
    // }
  }
  else if (room == 4)
  {
    fill(255);
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    for ( int i=0 ; i < tri_num ; i++)
    {
      if (tri[i].stage == room) tri[i]._draw();
      if ( ( checkhit_point( (character.x + character.xend) / 2 , (character.y + character.yend) / 2 , (tri[i].x + tri[i].xend) / 2 , (tri[i].y + tri[i].yend) / 2 , 25 ) ) && (tri[i].stage == room) )
      {
        character.show = 0;
      }
    }
    plat[26].trigger = 1;
    plat[27].trigger = 1;
    if (character.y < 0)
    {
      character.show = 0;
    }
    stage_check(100, 200, 1);
    if (timer[0].isFinished())
    {
      timer[0].start();
      int _random = (int)random(22, 44);
      if (_random == 44) _random = 43;
      tri[_random].trigger = 1;
    }
    character._draw();
    if (character.y > 800)
    {
      room = 5;
      if (hard == false) score = (int) ( 100000000 / millis() );
      else if (hard == true) score = (int) ( 2000000000 / millis() );
    }
  }
  else if (room == 5)
  {
    image(image_ending, 0, 0, width, height);
    image(image_ending_text, 200, 100, 800, 300);
    textAlign(CENTER);
    textSize(64);
    fill(0);
    text("Score : " + score, width/2, height/2 + 100);
    if ( ending_play == false)
    {
      if ( game_bgm_play == true )
      {
        sound_game_bgm.stop();
        game_bgm_play = false;
      }
      sound_ending.play();
      ending_play = true;
    }
  }
  
  if ( (room >= 1) && (room <= 4) )
  {
    if (hard == true)
    {
    dragon.move();
    dragon._draw();

    if ( checkhit_point( (character.x + character.xend) / 2 , (character.y + character.yend) / 2 , (dragon.Dragon_X) , dragon.Dragon_Y , 100 ) )
      {
        character.show = 0;
      }
    }
  }

  if (character.show == 0)
  {
    fill(255, 0, 0, 64);
    rect(0, 0, width, height);
    if ( (key_r) && (timer[1].isFinished()) )
    {
      if (room == 1)
      {
        stage_check(width/8, height/2 +300, 0);
        if ( game_bgm_play == false)
        {
          sound_game_bgm.loop();
          game_bgm_play = true;
        }
      }
      if (room == 2)
      {
        stage_check(width/8, height/2 +300, 0);
        if ( game_bgm_play == false)
        {
          sound_game_bgm.loop();
          game_bgm_play = true;
        }
      }
      if (room == 3)
      {
        stage_check(100, 200, 0);
        if ( game_bgm_play == false)
        {
          sound_game_bgm.loop();
          game_bgm_play = true;
        }
      }
      else if (room == 4)
      {
        stage_check(100, 200, 0);
        if ( game_bgm_play == false)
        {
          sound_game_bgm.loop();
          game_bgm_play = true;
        }
        for ( int i = 22; i < 44 ; i++)
        {
          tri[i].x = tri[i].x_ori;
          tri[i].y = tri[i].y_ori;
          tri[i].xend = tri[i].xend_ori;
          tri[i].yend = tri[i].yend_ori;
          tri[i].trigger = 0;
          tri[i].show = 1;
        }
        plat[26].x = plat[26].x_ori;
        plat[26].y = plat[26].y_ori;
        plat[26].trigger = 0;
        plat[26].show = 1;
        plat[27].x = plat[27].x_ori;
        plat[27].y = plat[27].y_ori;
        plat[27].trigger = 0;
        plat[27].show = 1;
      }
    }
  }
  
}