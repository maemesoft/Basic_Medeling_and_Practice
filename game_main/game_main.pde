void setup()
{
  size(1200, 800, P2D);
  frameRate(60);

  // Go to Loading_Setup()
}

void draw()
{
  background(#B0B8FC); // Default background color

  if (init == 4)
  {
    image(image_bg1, 0, 0, 1200, 800);
  }

  if (room == -1) // Loading
  {
    Loading_texture();
    Loading_Setup();
  }

  else if (room == 0) // Select Level
  {
    image(image_start, 0, 0, 1200, 800);
    room0_button();
  }

  else if (room==1)
  {
    if (start_time == 0)
    {
      start_time = millis();
    }

    fill(255);
    rectMode(CORNER);
    
    Draw_key();

    if (intro_bgm_play == true)
    {
      sound_intro_bgm.stop();
      intro_bgm_play = false;
    }
    
    if ( (game_bgm_play == false) && (character.show == 1)) 
    {
      sound_game_bgm.loop();
      game_bgm_play = true;
    }

    Create_plat(0, 3);

    character._draw();
  }

  else if (room==2)
  {
    Draw_key();
    
    fill(255);

    Create_plat(4, 11);
    
    if (hard)
    {
      plat[8].trigger = 2;
      plat[9].trigger = 2;
      plat[10].trigger = 2;
    }
    
    stage_check(width/8, height/2 + 300, 1);
    character._draw();
  }

  else if (room == 3)
  {
    
    fill(255);

    Create_plat(12, 21);
    Create_tri(0, 21);

    stage_check(100, 200, 1);
    character._draw();
    
    if (hard)
    {
      if ( (timer[0].isFinished()) && (hard==true) )
      {
        timer[0].start();
        int _random = (int)random(0, 22);
        if (_random == 21) _random = 21;
        tri[_random].trigger = 1;
      }
    
      if (character.yend > 650)
      {
          character.show = 0;
      }
      
      plat[17].trigger = 2;
      plat[18].trigger = 2;
      plat[19].trigger = 2;
      plat[20].trigger = 2;
    }
  }

  else if (room == 4)
  {
    fill(255);

    Create_plat(22, 27);
    Create_tri(22, 43);

    plat[26].trigger = 1;
    plat[27].trigger = 1;

    if (character.yend < 0)
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
      if (hard == false) score = (int) ( 100000000 / ( millis() - start_time ) );
      else if (hard == true) score = (int) ( 2000000000 / ( millis() - start_time ) );
    }
    
  }

  else if (room == 5) // end
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

    if (character.show == 0)
    {
      fill(255, 0, 0, 64);
      rect(0, 0, width, height);
      if ( (key_r) && (timer[1].isFinished()) )
      {
        if ( game_bgm_play == false)
        {
          sound_game_bgm.loop();
          game_bgm_play = true;
        }

        if (room == 1)
        {
          stage_check(width/8, height/2 +300, 0);
          
        }
        if (room == 2)
        {
          stage_check(width/8, height/2 +300, 0);

        }
        if (room == 3)
        {
          stage_check(100, 200, 0);
          for ( int i = 0; i < 22 ; i++)
          {
            tri[i].x = tri[i].x_ori;
            tri[i].y = tri[i].y_ori;
            tri[i].xend = tri[i].xend_ori;
            tri[i].yend = tri[i].yend_ori;
            tri[i].trigger = 0;
            tri[i].show = 1;
          }

        }
        else if (room == 4)
        {
          stage_check(100, 200, 0);

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

  
  
}