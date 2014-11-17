import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

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
    if(keyCode == UP){reaper.accelerate(0.12f);}
    if(keyCode == DOWN){reaper.accelerate(-0.12f);}
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
    xCorners = new int [corners];
    yCorners = new int [corners];
      xCorners[0] = 16;
      yCorners[0] = 0;
      xCorners[1] = -6;
      yCorners[1] = 6;
      xCorners[2] = -6;
      yCorners[2] = 3;
      xCorners[3] = 8;
      yCorners[3] = 0;
      xCorners[4] = -6;
      yCorners[4] = -3;
      xCorners[5] = -6;
      yCorners[5] = -6;
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
    xCorners = new int [corners];
    yCorners = new int [corners];
      xCorners[0] = 20;
      yCorners[0] = 0;
      xCorners[1] = 5;
      yCorners[1] = 5;
      xCorners[2] = 0;
      yCorners[2] = 20;
      xCorners[3] = -5;
      yCorners[3] = 5;
      xCorners[4] = -20;
      yCorners[4] = 0;
      xCorners[5] = -5;
      yCorners[5] = -5;
      xCorners[6] = 0;
      yCorners[6] = -20;
      xCorners[7] = 5;
      yCorners[7] = -5;
    myColor = color(255);
    myCenterX = ((int)(Math.random()*500));
    myCenterY = ((int)(Math.random()*500));
    myDirectionX = 2;
    myDirectionY = 2;
    myPointDirection = 0;
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
    accelerate((int)((Math.random()*5)+1));
    myCenterX += 1;
    myCenterY += 1;
    myPointDirection += astSpin;

    if(myCenterX > width + 20) {
      myCenterX = -20;
      myCenterX -= -1; 
    }    
    else if (myCenterX < -20) {myCenterX = width + 20;}    
    if(myCenterY > height + 20) {myCenterY = -20;}   
    else if (myCenterY < -20) {myCenterY = height + 20;} 
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
