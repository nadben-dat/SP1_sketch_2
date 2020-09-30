class Keys2
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  
  public Keys2(){}
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  
  
  void onKeyPressed(int ch)
  {
    if(ch == UP) //UP == pil op
    {
      wDown = true;
    }
    else if (ch == LEFT) //LEFT == pil venstre
    {
      aDown = true;
    }
    else if(ch == DOWN) //DOWN == pil ned
    {
      sDown = true;
    }
    else if(ch == RIGHT) //RIGHT == pil højre
    {
      dDown = true;
    }
  }
  
  void onKeyReleased(int ch)
  {
    if(ch == UP) //UP == pil op
    {
      wDown = false;
    }
    else if (ch == LEFT) //LEFT == pil venstre
    {
      aDown = false;
    }
    else if(ch == DOWN) //DOWN == pil ned
    {
      sDown = false;
    }
    else if(ch == RIGHT) //RIGHT == pil højre
    {
      dDown = false;
    }
  }
}
