nemo character;
solid[] plat = new solid[20];
triang[] tri = new triang[10];
Table map;
int room = 0;
int plat_num = 0;
int tri_num = 0;

// commit test

void setup()
{
  size(1200, 800, P2D);
  frameRate(60);
  smooth();
  
  noStroke();
  
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

  
}

void draw()
{
  background(#B0B8FC);
  if (room==0)
  {
    fill(255);
    textSize(70);
    textAlign(CENTER);
    text("Basic Modeling and Practice", width/2, height/2 + -143);
    
    
    rectMode(CENTER);
    rect(width/2, height/2 + 101, 238, 78);
    textSize(50);
    fill(0);
    text("Start", width/2, height/2 + 127);
    
    if (mousePressed)
    {
      if ((mouseX > width/2 - 238/2) && (mouseX < width/2 + 238/2) && (mouseY > height/2 + 101 - 78/2) && (mouseY < height/2 + 101 + 78/2))
      {
        room=1;
      }
    }
  }
  else if (room==1)
  {
    fill(255);
    rectMode(CORNER);
    
    textSize(70);
    textAlign(CENTER);
    text("Press A or D or W", width/2, height/2 + -143);
    
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    
    character._draw();
  }
  else if (room==2)
  {
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    
    stage_check(width/8, height/2 + 300);
    character._draw();
  }
  else if (room == 3) // 테스트2
  {
    for ( int i=0 ; i < plat_num ; i++)
    {
      if (plat[i].stage == room) plat[i]._draw();
    }
    for ( int i=0 ; i < tri_num ; i++)
    {
      if (tri[i].stage == room) 
      tri[i]._draw();
    }
    stage_check(100, 200);
    character._draw();
  }
  
  if (character.show == 0)
  {
    background(255, 0, 0, 128);
  }
  
}