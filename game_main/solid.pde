class solid extends object
{
  solid(float _x, float _y, float _xsize, float _ysize, int _coli, int _stage)
  {
    super(_x, _y, _xsize, _ysize, _coli, _stage);
  }
  
  void _draw()
  {
    rect(x, y, xsize, ysize);
    update();
  }
  
  void update()
  {
    if (trigger == 1)
    {
      y -= 1;
      yend = y + ysize;
      
    }
  }
}