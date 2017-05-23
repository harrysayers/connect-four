

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


boolean connect4 = true;
String red = ("Red Wins!");
String yellow = ("Yellow Wins!");
String click = ("Click to restart");
String menu = ("Connect 4");
int rows = 6;
int cols = 7;
boolean mousePiece = true;
int whoWon = 0;
int counter = 0;
Tile[][] piece = new Tile[cols][rows];
color counter1 = color(255, 0, 0);
color counter2 = color(255, 255, 0);
//rows cols
int[][] pieceChecker = new int[cols][rows];
Minim coin;
Minim winner;

AudioSample sound;
AudioPlayer won;
//Title start;
PFont text; // font for whoose the whoWon 



void setup()
{
  size(800, 800, P2D);
  frameRate(60);
  background(0, 0, 255);
  coin = new Minim(this);
  winner = new Minim(this);
  sound = coin.loadSample("coin.wav", 100);  
  won = winner.loadFile("ta.wav");
  // make pieceChecker == 0
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      pieceChecker[i][j] = 0;
    }
  }
  // create tile
  for ( int i = 0; i< cols; i++) {
    for ( int j = 0; j< rows; j++) {
      // xpos, ypos, w, h, colour and mouse over colour

      piece[i][j] = new Tile(100*i + 90, 100*j + 120, 50, 50, color(255));
    }
  }
}

void decs() {
  fill(0);
  textSize(24);
  text("Connect 4", 340, 40);
  fill(0, 0, 240);
  stroke(41, 85, 255);
  strokeWeight(10);
  rect(50, 80, 680, 590);
  fill(41, 85, 255);
  rect(30, 450, 20, 280);
  rect(730, 450, 20, 280);
}

void draw() {
  background(22, 188, 54);
  // game board bckgrd
  decs();
  changeColour(mouseX, mouseY);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      piece[i][j].show();
      // piece[1][5].setColour(color(0));
    }

    if (whooseWon() == true) {

      text = loadFont("Tahoma-Bold-50.vlw");
      textFont(text, 40);
      fill(255, 0, 0);
      connect4 = false;
      if (whoWon == 1) {
        text(red, width/2-120, height/4);
        text(click, 200, height/2);
        fill(0);
        text(menu, 260, height/2+60);


        won.play();
      } else if (whoWon == 2) {
        fill(255, 255, 0);
        text(yellow, width/2-125, height/4);
        text(click, 200, height/2);
        fill(0);
        text(menu, 260, height/2+60);


        won.play();
      }
    }
  }
  mousePiece();
}


void mousePiece() {
  if (mousePiece == true) {
    noStroke();
    fill(counter2);
    ellipse(mouseX, mouseY, 60, 60);
  } else {
    noStroke();
    fill(counter1);
    ellipse(mouseX, mouseY, 60, 60);
  }
}



// click to play again functionality
void mousePressed() {
  if (connect4 == false) {
    connect4 = true;
    setup();
  }
  // triggers the coins sound;
  sound.trigger();
}


/// check for the winner

boolean whooseWon() {

  // horizontalCheck 
  for (int j = 0; j<rows -3; j++ ) {
    for (int i = 0; i<cols; i++) {
      if (piece[i][j].getColour() == color(counter1)  && piece[i][j+1].getColour() == color(counter1) && 
        piece[i][j+2].getColour() == color(counter1) && piece[i][j+3].getColour() == color(counter1))
      {
        whoWon = 1;
        return true;
      }           
      if (piece[i][j].getColour() == color(counter2)  && piece[i][j+1].getColour() == color(counter2) && 
        piece[i][j+2].getColour() == color(counter2) && piece[i][j+3].getColour() == color(counter2)) {
        whoWon = 2;
        return true;
      }
    }
  }
  // verticalCheck
  for (int i = 0; i< cols -3; i++ ) {
    for (int j = 0; j< rows; j++) {
      if (piece[i][j].getColour() == color(counter1)  && piece[i+1][j].getColour() == color(counter1) && 
        piece[i+2][j].getColour() == color(counter1) && piece[i+3][j].getColour() == color(counter1)) {
        whoWon = 1;
        return true;
      } 
      if (piece[i][j].getColour() == color(counter2)  && piece[i+1][j].getColour() == color(counter2) && 
        piece[i+2][j].getColour() == color(counter2) && piece[i+3][j].getColour() == color(counter2)) {
        whoWon = 2;
        return true;
      }
    }
  }
  // ascendingDiagonalCheck 
  for (int i = 3; i< cols; i++) {
    for (int j = 0; j < rows -3; j++) {
      if (piece[i][j].getColour() == color(counter1)  && piece[i-1][j+1].getColour() == color(counter1) && 
        piece[i-2][j+2].getColour() == color(counter1) && piece[i-3][j+3].getColour() == color(counter1)) {
        whoWon = 1;
        return true;
      }       
      if (piece[i][j].getColour() == color(counter2)  && piece[i-1][j+1].getColour() == color(counter2) && 
        piece[i-2][j+2].getColour() == color(counter2) && piece[i-3][j+3].getColour() == color(counter2)) {
        whoWon = 2;
        return true;
      }
    }
  }
  // descendingDiagonalCheck
  for (int i = 0; i < cols -3; i++) {
    for (int j = 0; j< rows -3; j++)
    {
      if (piece[i][j].getColour() == color(counter1)  && piece[i+1][j+1].getColour() == color(counter1) && 
        piece[i+2][j+2].getColour() == color(counter1) && piece[i+3][j+3].getColour() == color(counter1)) {
        whoWon = 1;
        return true;
      }           
      if (piece[i][j].getColour() == color(counter2)  && piece[i+1][j+1].getColour() == color(counter2) && 
        piece[i+2][j+2].getColour() == color(counter2) && piece[i+3][j+3].getColour() == color(counter2)) {
        whoWon = 2;
        return true;
      }
    }
  }
  return false;
}


///changeColour connect4 state

void changeColour(double positionX, double positionY)
{
/*
  if the tile is white then tile is empty. 
   if the piecechecker = 1 or 2 
   */
if (mousePressed && connect4 && positionX == mouseX && positionY == mouseY ) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        // if j == 5 which is the bottom row or == to red or yellow.
        if (j == 5 || piece[i][j+1].getColour() == color(counter1) || piece[i][j+1].getColour() == color(counter2)) {
          if (piece[i][j].overPiece() && (piece[i][j].getColour() == color(255)||
            piece[i][j].getColour() == color(0, 255, 0))) {   
            counter++;

            // alternate turn mechanism 
            // 1 modulo anything equals 0 
            // 2 modulo does not equal 0 unless ofcourse it is 2 || 1
            if (counter % 2 == 0 ) 
            {
              piece[i][j].setColour(color(counter1));
              mousePiece = true;
              pieceChecker[i][j] = 1;
            } else
            {
              piece[i][j].setColour(color(counter2));
              mousePiece = false;
              pieceChecker[i][j] = 2;
            }
          }
        }
      }
    }
  }
}            