class object
{
  float x;
  float y;
  float x_ori;
  float y_ori;
  float xend_ori;
  float yend_ori;
  float size;
  float xsize;
  float ysize;
  float xend;
  float yend;
  int angle;
  int coli;
  int stage;
  int show=1;
  int trigger=0;
  
  object(float _x, float _y, float _size)
  {
    x = _x;
    y = _y;
    size = _size;

    xsize = size;
    ysize = size;

    xend = x + size;
    yend = y + size;

    x_ori = x;
    y_ori = y;
    xend_ori = xend;
    yend_ori = yend;
  }
  
  object(float _x, float _y, float _xsize, float _ysize)
  {
    x = _x;
    y = _y;
    xsize = _xsize;
    ysize = _ysize;

    xend = x + xsize;
    yend = y + ysize;

    x_ori = x;
    y_ori = y;
    
    xend_ori = xend;
    yend_ori = yend;
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

    x_ori = x;
    y_ori = y;
    
    xend_ori = xend;
    yend_ori = yend;
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


    x_ori = x;
    y_ori = y;
    
    xend_ori = xend;
    yend_ori = yend;
  }
  
  void _draw()
  {

  }
  
  void update()
  {
    
  }
}