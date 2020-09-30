//Nadia's sketch

/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */
 
import java.util.Random;

Game game = new Game(30, 20, 2, 4); // width /  height / enemies number / food number
PFont font;
int points1 = 0;
int points2 = 0;
int winPoints = 10;

void setup()
{
  size(1201, 801);
  frameRate(10);
  font = createFont("Arial",20);
  textFont(font);
}

void keyReleased()
{
  game.onKeyReleased(key); //w a s d
  game.onKey2Released(keyCode); //pile-tasterne pil op, ned, venstre, højre
}

void keyPressed()
{
  game.onKeyPressed(key);
  game.onKey2Pressed(keyCode);
}

void draw()
{
  game.update();
  background(0); //Black
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  int[][] board = game.getBoard();
  for (int y = 0; y < game.getHeight(); y++)
  {
    for (int x = 0; x < game.getWidth(); x++)
    {
      if(board[x][y] == 0) //background
      {
        fill(0);
      }
      else if(board[x][y] == 1) //player 1
      {
        fill(0,0,255);
      }
      else if(board[x][y] == 2) //enemy
      {
        fill(255,0,0);
      }
      else if(board[x][y] == 3) //food
      {
        fill(0,255,0);
      }
      else if(board[x][y] == 4) //player 2
      {
        fill(255,182,193); //lyserød
      }
      stroke(100,100,100);
      rect(x*40, y*40, 40, 40);
    }
  }
  fill(255);
  textSize(25);
  textAlign(CENTER,BOTTOM);
  text("P1 Life: "+game.getPlayerLife(), 100,30);
  text("P2 Life: "+game.getPlayer2Life(), 100,60);
  text("P1 Points: "+points1+"/"+winPoints,width-115,30);
  text("P2 Points: "+points2+"/"+winPoints,width-115,60);
  
  //game over!
  gameOver();
  //you win!
  win();
}

void win()
{
  if(points1 >= winPoints){ //hvis points er højere eller lig med winPoints
    fill(0,0,255,150);
    rect(0,0,width,height);
    fill(255);
    textSize(80);
    textAlign(CENTER,BOTTOM);
    text("PLAYER ONE WINS",width/2,height/2);
    
    noLoop(); //"noLoop()" stopper hele programmet
  }
  if(points2 >= winPoints){ //hvis points er højere eller lig med winPoints
    fill(255,182,193,150);
    rect(0,0,width,height);
    fill(255);
    textSize(80);
    textAlign(CENTER,BOTTOM);
    text("PLAYER TWO WINS",width/2,height/2);
    
    noLoop(); //"noLoop()" stopper hele programmet
  }
}

void gameOver()
{
  if(game.getPlayerLife() <= 0){ //hvis liv er mindre end 0
    fill(255,182,193,150);
    rect(0,0,width,height);
    fill(255);
    textSize(80);
    textAlign(CENTER,BOTTOM);
    text("PLAYER TWO WINS",width/2,height/2);
    
    noLoop(); //"noLoop()" stopper hele programmet
  }
  if(game.getPlayer2Life() <= 0){ //hvis liv er mindre end 0
    fill(0,0,255,150);
    rect(0,0,width,height);
    fill(255);
    textSize(80);
    textAlign(CENTER,BOTTOM);
    text("PLAYER ONE WINS",width/2,height/2);
    
    noLoop(); //"noLoop()" stopper hele programmet
  }
}
