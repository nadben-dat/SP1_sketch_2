import java.util.Random;

class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private Dot player;
  private Keys2 keys2;
  private int player2Life;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  
   
  Game(int width, int height, int numberOfEnemies, int numberOfFood) //constructor
  {
    if(width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if(numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    
    keys = new Keys();
    player = new Dot(0,0,width-1, height-1); // x, y, max x, max y (starter i venstre top hjørne)
    keys2 = new Keys2();
    player2 = new Dot(0,height-1,width-1,height-1); //(starter i venstre bund hjørne)
    
    enemies = new Dot[numberOfEnemies]; //lav antal af fjender
    for(int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1); // Dot(x start, y start, max x, max y)
    }
    
    food = new Dot[numberOfFood];
    for(int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot(width-1, 1+i*3, width-1, height-1); // Dot(x start, y start, max x, max y)
    }
    
    this.playerLife = 100;
    this.player2Life = 100;
  }
  
  public int getWidth()
  {
    return width;
  }
  
  public int getHeight()
  {
    return height;
  }
  
  public int getPlayerLife()
  {
    return playerLife;
  }
  
  public int getPlayer2Life()
  {
    return player2Life;
  }
  
  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }
  
  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }
  
  public void onKey2Released(int ch)
  {
    keys2.onKeyReleased(ch);
  }
  
  public void onKey2Pressed(int ch)
  {
    keys2.onKeyPressed(ch);
  }
  
  public void update()
  {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    checkForCollisions();
    clearBoard();
    populateBoard();
    updateFood();
  }
  
  
  
  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }
  
  private void clearBoard()
  {
    for(int y = 0; y < height; ++y)
    {
      for(int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }
  
  private void updatePlayer()
  {
    //Update player
    if(keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if(keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if(keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if(keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }  
  }
  
  private void updatePlayer2()
  {
    //Update player
    if(keys2.wDown() && !keys2.sDown())
    {
      player2.moveUp();
    }
    if(keys2.aDown() && !keys2.dDown())
    {
      player2.moveLeft();
    }
    if(keys2.sDown() && !keys2.wDown())
    {
      player2.moveDown();
    }
    if(keys2.dDown() && !keys2.aDown())
    {
      player2.moveRight();
    }  
  }
  
  private void updateEnemies()
  {
    for(int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = 0, dy = 0, dx2 = 0, dy2 = 0;
        if(i < enemies.length/2){ //hvis i er mindre end halvdelen af nummeret af enemies, 
                                  //så giver vi dem til player 2
          dx2 = player2.getX() - enemies[i].getX();
          dy2 = player2.getY() - enemies[i].getY();
        }else{                    //ellers så giver vi dem til player 1
          dx = player.getX() - enemies[i].getX();
          dy = player.getY() - enemies[i].getY();
        }
        
        if(abs(dx) > abs(dy) || abs(dx2) > abs(dy2))
        {
          if(dx > 0 || dx2 > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          }
          else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        }
        else if(dy > 0 || dy2 > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        }
        else
        {//Player is up;
          enemies[i].moveUp();
        }
      }
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if(move == 0)
        {
          //Move right
          enemies[i].moveRight();
        }
        else if(move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        }
        else if(move == 2)
        {
          //Move up
          enemies[i].moveUp();
        }
        else if(move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }
  
  private void updateFood()
  {
    for(int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = 0, dy = 0, dx2 = 0, dy2 = 0;
        if(i < food.length/2){ //hvis i er mindre end halvdelen af nummeret af enemies, 
                               //så giver vi dem til player 2
          dx2 = player2.getX() - food[i].getX();
          dy2 = player2.getY() - food[i].getY();
        }else{                 //ellers så giver vi dem til player 1
          dx = player.getX() - food[i].getX();
          dy = player.getY() - food[i].getY();
        }
        
        if(abs(dx) < abs(dy) || abs(dx2) < abs(dy2))
        {
          if(dx < 0 || dx2 < 0)
          {
            //Player is to the right
            food[i].moveRight();
          }
          else
          {
            //Player is to the left
            food[i].moveLeft();
          }
        }
        else if(dy < 0 || dy2 < 0)
        {
          //Player is down;
          food[i].moveDown();
        }
        else
        {//Player is up;
          food[i].moveUp();
        }
      }
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if(move == 0)
        {
          //Move right
          food[i].moveRight();
        }
        else if(move == 1)
        {
          //Move left
          food[i].moveLeft();
        }
        else if(move == 2)
        {
          //Move up
          food[i].moveUp();
        }
        else if(move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
  
  private void populateBoard()
  {
    //Insert player 1
    board[player.getX()][player.getY()] = 1;
    //Insert player 2
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for(int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for(int i = 0; i < food.length; ++i){
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }
   
  private void checkForCollisions()
  {
    //Check enemy collisions
    for(int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        playerLife -= 5; //du mister 10 liv hvis du rør enemy
        if(playerLife <= 0){
          playerLife = 0;
        }
      }
    }
    for(int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a collision
        player2Life -= 5; //du mister 10 liv hvis du rør enemy
        if(player2Life <= 0){
          player2Life = 0;
        }
      }
    }
    //Check food collisions
    for(int i = 0; i < food.length; ++i)
    {
      if(food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        //We have a collision
        playerLife += 10; //du får 10 liv hvis du rør food
        if(playerLife >= 100){ //hvis liv bliver størrere end 100 sæt det tilbage til 100
          playerLife = 100;
        }
        points1 += 1;
        food[i] = new Dot((int)random(1,width-1), (int)random(1,height-1), width-1, height-1);
      }
    }
    for(int i = 0; i < food.length; ++i)
    {
      if(food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        //We have a collision
        player2Life += 10; //du får 10 liv hvis du rør food
        if(player2Life >= 100){ //hvis liv bliver størrere end 100 sæt det tilbage til 100
          player2Life = 100;
        }
        points2 += 1;
        food[i] = new Dot((int)random(1,width-1), (int)random(1,height-1), width-1, height-1);
      }
    }
  }
}
