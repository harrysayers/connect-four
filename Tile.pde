 class Tile
  {

    color basecolor;
    int Xpos; 
    int Ypos;
    int w;
    int h;
    color currentColour;
  
    Tile(int tempx, int tempy, int tempH, int tempW, int colour)
    {
      Xpos = tempx;
      Ypos = tempy;
      h = tempH;
      w = tempW;
     currentColour = colour;

    }
 
 // math to work out when the mouse is over a button 
// remember recursion 
    boolean overPiece()
    {
      if (sqrt(sq(mouseY/2*2  - Ypos-10 )) < w   && 
          sqrt(sq(mouseX/2*2 - Xpos-10)) < w) 
          {
          return true;
      }
        else{
          return false;
        }
    }
    
// set colours
    void setColour(color tempColour) {
     currentColour = tempColour;
    }

// get colours
    color getColour() {
      return currentColour;
    }

 void show() {
      smooth();
      stroke(currentColour);
      fill(currentColour);
      ellipse(Xpos, Ypos, w, h);
    }
    
  }