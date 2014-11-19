SpaceShip reaper = new SpaceShip();
Star[] fire = new Star[100];
Asteroid[] boo = new Asteroid[5];

public void setup() {
  size(500,500);
  for(int i = 0; i < fire.length; i++){
    fire[i] = new Star();
  }
  for(int i = 0; i < boo.length; i++){
    boo[i] = new Asteroid();
  }
}

public void keyPressed() {
  if (keyPressed) {
    if(keyCode == RIGHT){reaper.rotate(10);}
    if(keyCode == LEFT){reaper.rotate(-10);}
    if(keyCode == UP){reaper.accelerate(0.12);}
    if(keyCode == DOWN){reaper.accelerate(-0.12);}
    if(key == ' '){
      reaper.setDirectionX(0);
      reaper.setDirectionY(0);
      reaper.setCenterX((int)(Math.random()*(500-20))+10);
      reaper.setCenterY((int)(Math.random()*(500-20))+10);
      reaper.setPointDirection((int)(Math.random()*360));
    }
  }
}

public void draw() {
  background(0);
  for(int i = 0; i < fire.length; i++){
    fire[i].shine();
  }
  reaper.show();
  reaper.move();
  for(int i = 0; i < boo.length; i++){
    boo[i].show();
    boo[i].move();
  }
}

class Star {
  private int xPos, yPos;
  public Star() {
    xPos = (int)(Math.random()*500);
    yPos = (int)(Math.random()*500);
  }
  public void shine(){
    stroke(255);
    fill(255);
    ellipse(xPos, yPos, 2, 2);
  }
}

class SpaceShip extends Floater  { 
  public SpaceShip() {
    corners = 6;
    int[] shipX = {16, -6, -6, 8, -6, -6};
    int[] shipY = {0, 6, 3, 0, -3, -6};
    xCorners = shipX;
    yCorners = shipY;
    myColor = color(0, 255, 0);
    myCenterX = (500/2);
    myCenterY = (500/2);
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }  
  public void setCenterX(int x) {myCenterX = x;}
  public int getCenterX() {return (int)myCenterX;}
  public void setCenterY(int y) {myCenterY = y;}
  public int getCenterY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

class Asteroid extends Floater {
  private int astSpin;
  Asteroid()
  {
    corners = 8;
    int[] astX = {20, 5, 0, -5, -20, -5, 0, 5};
    int[] astY = {0, 5, 20, 5, 0, -5, -20, -5};
    xCorners = astX;
    yCorners = astY;
    myColor = color(255);
    myCenterX = ((int)(Math.random()*500));
    myCenterY = ((int)(Math.random()*500));
    myDirectionX = ((int)(Math.random()*5)-2);
    myDirectionY = ((int)(Math.random()*5)-2);
    myPointDirection = ((int)(Math.random()*5)-2);
    astSpin = ((int)(Math.random()*8)-4);
  }
  public void setCenterX(int x) {myCenterX = x;}
  public int getCenterX() {return (int)myCenterX;}
  public void setCenterY(int y) {myCenterY = y;}
  public int getCenterY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}

  public void move() 
  {
    rotate(astSpin);
    super.move();
  }
}


abstract class Floater { //Do NOT modify the Floater class! Make changes in the SpaceShip class   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setCenterX(int x);  
  abstract public int getCenterX();   
  abstract public void setCenterY(int y);   
  abstract public int getCenterY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    noFill();   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }  
}