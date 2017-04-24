class Dragon extends object
{
  float Dragon_X;
  float Dragon_Y;
  
  float xpos;
  float ypos;
  
  float pm;

  float xspeed;
  float yspeed;

  float H;

  Dragon(float _x, float _y, float _xsize, float _ysize, int _stage)
  {
    super(_x, _y, _xsize, _ysize, _stage);

    xpos = _x;
    ypos = _y;

    H = 67;

    xspeed = 10;
    yspeed = 10;
  }
  
  void _draw()
  {
    noStroke();
    
    pushMatrix();

    translate(Dragon_X-223, Dragon_Y-221);

    //neck shadow
    fill(#050505, 100);
    ellipse(244,285,27,43);
    
    //neck
    fill(#fcefd1);
    ellipse(241,285,27,43);
    
    //body shadow
    fill(0, 100);
    ellipse(244,358,86,128);
    
    //leg
    fill(0, 100);
    //left
    ellipse(224,434,20,78);
    //right
    ellipse(267,436,20,78);
    
    //leg
    fill(#fcefd1, 255);
    //left
    ellipse(220,432,20,78);
    //right
    ellipse(263,434,20,78);
    
    //body
    colorMode(HSB, 100);
    fill(H, 30, 100);
    ellipse(241,357,86,128);
    colorMode(RGB, 255);
    
    // face
    fill(#010101, 100);
    ellipse(246,171,174,226);
    
    // face
    fill(#fcefd1, 255);
    ellipse(241,169,174,226);
    
    // eyeline
    fill(0);
    strokeWeight(7);
    //left
    line(183,158,209,158);
    //right
    line(266,158,291,158);
    strokeWeight(1);
    
    //left eye
    pushMatrix();
    fill(0);
    ellipse(195,193,45,45);
    fill(255);
    ellipse(190,188,20,20);
    ellipse(206,198,10,10);
    ellipse(195,206,10,10);
    popMatrix();
    
    //right eye
    fill(0);
    ellipse(279,193,45,45);
    fill(255);
    ellipse(190+84,188,20,20);
    ellipse(206+84,198,10,10);
    ellipse(195+84,206,10,10);
    
    //홍조
    fill(#FF9898, 120);
    ellipse(278,228,33,10);
    ellipse(195,228,33,10);
    
    //mouth
    fill(#FFCD8B, 200);
    ellipse(237,248,20,33);
    
    //hair shadow
    fill(#010101, 101);
    beginShape(); 
    vertex(146,185);
    vertex(127,146);
    vertex(110,138);
    vertex(126,128);
    vertex(158,83); // 5
    vertex(185,60);
    vertex(236,45); // 6
    vertex(318,63);
    vertex(375,131); // 7
    vertex(326,214); // 8
    vertex(291,151); // 9
    vertex(237,120);
    vertex(148,190);
    endShape();
    
    //hair
    colorMode(HSB, 100);
    fill(H, 30, 100);
    beginShape(); 
    vertex(148,181);
    vertex(134,148);
    vertex(110,138);
    vertex(126,128);
    vertex(158,83); // 5
    vertex(185,60);
    vertex(236,45); // 6
    vertex(313,63);
    vertex(370,131); // 7
    vertex(326,205); // 8
    vertex(291,141); // 9
    vertex(237,113);
    vertex(148,181);
    endShape();
    
    colorMode(RGB, 255);
    //arm left shadow
    fill(0, 100);
    beginShape();
    curveVertex(216, 306);
    curveVertex(214, 307);
    curveVertex(197, 301);
    curveVertex(193, 254);
    curveVertex(176, 254);
    curveVertex(176, 311);
    curveVertex(204, 331);
    curveVertex(198, 320);
    endShape();
    
    //arm left
    fill(#fcefd1);
    beginShape();
    curveVertex(230, 311);
    curveVertex(214, 311);
    curveVertex(194, 304);
    curveVertex(190, 254);
    curveVertex(176, 254);
    curveVertex(176, 311);
    curveVertex(204, 331);
    curveVertex(198, 320);
    endShape();
   
    //arm right shadow
    fill(0, 100);
    beginShape();
    curveVertex(270, 264);
    curveVertex(271, 311);
    curveVertex(298, 308);
    curveVertex(300, 254);
    curveVertex(322, 254);
    curveVertex(315, 316);
    curveVertex(281, 336);
    curveVertex(274, 320);
    endShape();
    
    //arm right
    fill(#fcefd1);
    beginShape();
    curveVertex(270, 311);
    curveVertex(271, 311);
    curveVertex(298, 304);
    curveVertex(300, 254);
    curveVertex(318, 254);
    curveVertex(313, 311);
    curveVertex(281, 331);
    curveVertex(274, 320);
    endShape();
    
    popMatrix();
  }
    void move()
  {
    if ((Dragon_X > width))
    {
      xpos = -1;
    }
    else if (Dragon_X < 0)
    {
      xpos = 1;
    }
    
    if ((Dragon_Y > height))
    {
      ypos = -1;
    }
    else if (Dragon_Y < 0)
    {
      ypos = 1;
    }

      Dragon_X = Dragon_X + xspeed * xpos;
      Dragon_Y = Dragon_Y + yspeed * ypos;
    
    // Dragon_X = Dragon_X - (Dragon_X - mouseX)/20;
    // Dragon_Y = Dragon_Y - (Dragon_Y - mouseY)/20;
  }
}