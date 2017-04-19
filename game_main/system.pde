boolean key_a, key_d, key_w, key_s;

final int PLAT=1, TRI=2;
final int coli_up = 1, coli_left = 2, coli_right = 3, coli_down = 4;

void keyPressed() {
  checkey(key, true);
}
 
void keyReleased() {
  checkey(key, false);
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
 
    default:
      return b;
  }
}