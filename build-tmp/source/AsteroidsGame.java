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
public void setup() 
{
  size(500,500);
  for(int i = 0; i < fire.length; i++){
    fire[i] = new Star();
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i < fire.length; i++){
    fire[i].shine();
  }
  reaper.show();
  reaper.move();
  reaper.keyPressed();
}
class Star
{
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
class SpaceShip extends Floater  
{ 
  public SpaceShip() {
    corners = 6;
    xCorners = new int [corners];
    yCorners = new int [corners];
      xCorners[0] = -5;
      yCorners[0] = 7;
      xCorners[1] = 18;
      yCorners[1] = 0;
      xCorners[2] = -5;
      yCorners[2] = -7;
      xCorners[3] = -5;
      yCorners[3] = -4;
      xCorners[4] = 12;
      yCorners[4] = 0;
      xCorners[5] = -5;
      yCorners[5] = 4;
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

  public void keyPressed() {
    if (keyPressed) {
      if(keyCode == RIGHT){reaper.rotate(5);}
      if(keyCode == LEFT){reaper.rotate(-5);}
      if(keyCode == UP){reaper.accelerate(0.07f);}
      if(keyCode == DOWN){reaper.accelerate(-0.07f);}
      if(key == '0'){
        reaper.setDirectionX(0);
        reaper.setDirectionY(0);
        reaper.setCenterX((int)(Math.random()*(500-20))+10);
        reaper.setCenterY((int)(Math.random()*(500-20))+10);
        reaper.setPointDirection((int)(Math.random()*360));
      }
    }
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
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
    fill(100);   
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
