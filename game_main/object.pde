class object
{
  float x;
  float y;
  float size;
  float xsize;
  float ysize;
  float xend;
  float yend;
  int angle;
  int coli;
  int stage;
  int show=1;
  
  object(float _x, float _y, float _size)
  {
    x = _x;
    y = _y;
    size = _size;

    xsize = size;
    ysize = size;

    xend = x + size;
    yend = y + size;
  }
  
  object(float _x, float _y, float _xsize, float _ysize)
  {
    x = _x;
    y = _y;
    xsize = _xsize;
    ysize = _ysize;

    xend = x + xsize;
    yend = y + ysize;
  }
  
  object(float _x, float _y, float _xsize, float _ysize, int _stage)
  {
    x = _x;
    y = _y;
    xsize = _xsize;
    ysize = _ysize;
    stage = _stage;

    xend = x + xsize;
    yend = y + ysize;
  }
  
  object(float _x, float _y, float _xsize, float _ysize, int _coli, int _stage)
  {
    x = _x;
    y = _y;
    xsize = _xsize;
    ysize = _ysize;
    coli = _coli;
    stage = _stage;

    xend = x + xsize;
    yend = y + ysize;
  }
  
  void _draw()
  {

  }
  
  void update()
  {
    
  }
}