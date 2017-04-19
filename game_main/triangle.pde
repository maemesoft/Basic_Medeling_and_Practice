class triang extends object
{
  triang(float _x, float _y, float _xsize, float _ysize, int _stage)
  {
    super(_x, _y, _xsize, _ysize, _stage);
  }
  
  void _draw()
  {
    triangle(x, yend, (x+xend)/2, y, xend, yend);
    update();
  }
  
  void update()
  {
    
  }
}