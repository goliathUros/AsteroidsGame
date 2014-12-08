SpaceShip ship = new SpaceShip();
Star[] fire = new Star[150];
ArrayList <Asteroid> meteor = new ArrayList <Asteroid>();
//Asteroid[] boo = new Asteroid[6];
ArrayList <Bullet> shoot = new ArrayList <Bullet>();
//Bullet shoot = new Bullet(ship);

boolean[] keyz = new boolean[6];

public void setup()
{
  size(700,700);
  smooth();

  for(int i = 0; i < fire.length; i++){
    fire[i] = new Star();
  }

  for(int i = 0; i <= 6; i++) {
    meteor.add(i, new Asteroid());
  }

  /*for(int i = 0; i < boo.length; i++){
    boo[i] = new Asteroid();
  }*/
}

public void draw()
{
  background(0);
  for(int i = 0; i < fire.length; i++){
    fire[i].shine();
  }
  ship.show();
  ship.move();

  for(int i = 0; i < meteor.size(); i++){
    meteor.get(i).show();
    meteor.get(i).move();

    for(int j = 0; j < shoot.size(); j++){
      if (dist(shoot.get(j).getCenterX(), shoot.get(j).getCenterY(), meteor.get(i).getCenterX(), meteor.get(i).getCenterY()) < meteor.get(i).getAstSize()){
        meteor.remove(i);
        meteor.add(new Asteroid());
        shoot.remove(j);
      }
    }

    // if (dist(ship.getCenterX(), ship.getCenterY(), (meteor.get(i)).getCenterX(), (meteor.get(i)).getCenterY()) < meteor.get(i).getAstSize()) {
    //   meteor.remove(i);
    //   meteor.add(new Asteroid());
    // }
  }

  for(int i = 1; i < meteor.size(); i++){
    if (meteor.get(i).getCenterX() < meteor.get(i-1).getCenterX() || meteor.get(i).getCenterY() < meteor.get(i-1).getCenterY()) {
      // meteor.remove(i);
      // meteor.remove(i-1);
      // meteor.add(0, new Asteroid());
      // meteor.add(1, new Asteroid());
      meteor.get(i).setDirectionX(-(meteor.get(i).getDirectionX()));
      meteor.get(i).setDirectionY(-(meteor.get(i).getDirectionY()));
      meteor.get(i-1).setDirectionX(-(meteor.get(i-1).getDirectionX()));
      meteor.get(i-1).setDirectionY(-(meteor.get(i-1).getDirectionY()));
    }

    if (dist(ship.getCenterX(), ship.getCenterY(), meteor.get(i).getCenterX(), meteor.get(i).getCenterY()) < meteor.get(i).getAstSize()) {
      ship.setDirectionX(0);
      ship.setDirectionY(0);
      meteor.get(i).setDirectionX(0);
      meteor.get(i).setDirectionY(0);
      textAlign(CENTER);
      textSize(50);
      stroke(255);
      text("GAME OVER \n Press button to continue", width/2, height/2);
    }
  }

  // for(int i = 0; i < boo.length; i++){
  //   boo[i].show();
  //   boo[i].move();
  // }

  for(int i = 0; i < shoot.size(); i++) {
    shoot.get(i).show();  
    shoot.get(i).move();
  }

  if(keyz[0]) {ship.rotate(4);}
  if(keyz[1]) {ship.rotate(-4);}
  if(keyz[2]) {ship.accelerate(0.12);}
  if(keyz[3]) {ship.accelerate(-0.12);} 
  if(keyz[4]) {
      ship.setDirectionX(0);
      ship.setDirectionY(0);
      ship.setCenterX((int)(Math.random()*(700-20))+10);
      ship.setCenterY((int)(Math.random()*(700-20))+10);
      ship.setPointDirection((int)(Math.random()*360));
  }
  if(keyz[5]) {shoot.add(new Bullet(ship));}
}

public void keyPressed() {
  if (keyCode == RIGHT)  keyz[0] = true;
  if (keyCode == LEFT)  keyz[1] = true;
  if (keyCode == UP)  keyz[2] = true;
  if (keyCode == DOWN)  keyz[3] = true;
  if (key == 'a')  keyz[4] = true;
  if (key == 's')  keyz[5] = true;
}
 
public void keyReleased() {
  if (keyCode == RIGHT)  keyz[0] = false;
  if (keyCode == LEFT)  keyz[1] = false;
  if (keyCode == UP)  keyz[2] = false;
  if (keyCode == DOWN)  keyz[3] = false;
  if (key == 'a')  keyz[4] = false;
  if (key == 's')  keyz[5] = false;
}



class Star
{
  private int xPos, yPos;
  public Star() {
    xPos = (int)(Math.random()*700);
    yPos = (int)(Math.random()*700);
  }
  public void shine(){
    stroke(0, 255, 255);
    fill(0, 255, 255);
    ellipse(xPos, yPos, 2, 2);
  }
}

class SpaceShip extends Floater
{ 
  public SpaceShip() {
    corners = 6;
    int[] shipX = {16, -6, -6, 8, -6, -6};
    int[] shipY = {0, 6, 3, 0, -3, -6};
    xCorners = shipX;
    yCorners = shipY;
    myColor = color(0, 255, 0);
    myCenterX = (700/2);
    myCenterY = (700/2);
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

class Asteroid extends Floater
{
  private int astSpin;
  private int astSize;
  Asteroid()
  {
    corners = 8;
    astSize = ((int)(Math.random()*60)+20);
    int[] astX = {astSize, (astSize/4), 0, -(astSize/4), -astSize, -(astSize/4), 0, (astSize/4)};
    int[] astY = {0, (astSize/4), astSize, (astSize/4), 0, -(astSize/4), -astSize, -(astSize/4)};
    xCorners = astX;
    yCorners = astY;
    myColor = color(255);
    myCenterX = ((int)(Math.random()*700));
    myCenterY = ((int)(Math.random()*700));
    myDirectionX = ((int)(Math.random()*3)-1);
    myDirectionY = ((int)(Math.random()*3)-1);
    myPointDirection = ((int)(Math.random()*360));
    astSpin = ((int)(Math.random()*7)-3 );
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

  public double getAstSize() {return astSize;}

  public void move() 
  {
    rotate(astSpin);
    super.move();
  }
}

class Bullet extends Floater
{
  public Bullet(SpaceShip ship) {
    myCenterX = ship.getCenterX();
    myCenterY = ship.getCenterY();
    myPointDirection = ship.getPointDirection();
    myColor =color(0, 255, 0);

    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();
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

  public void show()
  {
    stroke(myColor);
    fill(myColor);
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);
  }

  public void move()
  {
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
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