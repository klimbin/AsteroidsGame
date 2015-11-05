SpaceShip spaceship;
Star [] stars;
boolean accel, left, right;
int a = 1;
public void setup() 
{
  background(0);
  size(600,600);
  spaceship = new SpaceShip();
  stars = new Star[(int)(Math.random()*16)+15];
  for(int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
}
public void draw() 
{
  background(0);
  for(int i = 0; i < stars.length; i++)
  {
    stars[i].move();
    stars[i].show();
  }
  if(left == true)
  {
    spaceship.rotate(-10);
  }
  if(right == true)
  {
    spaceship.rotate(10);
  }
  if(accel == true)
  {
    spaceship.accelerate(.069);
    if(a == 1)
    {
      spaceship.rocket();
    }
    a *= -1;
  }
  spaceship.show();
  spaceship.move();
}
public void keyPressed()
{
  if(key == 'a')
  {
    left = true;
  }
  if(key == 'd')
  {
    right = true;
  }
  if(key == 'w')
  {
    accel = true;
  }
}
public void keyReleased()
{
  if(key == 'a')
  {
    left = false;
  }
  if(key == 'd')
  {
    right = false;
  }
  if(key == 'w')
  {
    accel = false;
  }
  if(key == 'h')
  {
    spaceship.setDirectionX(0);
    spaceship.setDirectionY(0);
    spaceship.setPointDirection((int)(Math.random()*361));
    spaceship.setX((int)(Math.random()*601));
    spaceship.setY((int)(Math.random()*601));
    spaceship.accelerate(0);
  }
}
class Star
{
  private int sX, sY;
  public Star()
  {
    sX = (int)(Math.random()*801)-100;
    sY = (int)(Math.random()*801)-100;
  }
  public void move()
  {
    sY++;
    if(sY > 600)
    {
      sY = 0;
    }
  }
  public void show()
  {
    ellipse(sX, sY, 2, 2);
  }
  public void setStarX(int x){sX = x;}
  public int getStarX(){return sX;}
  public void setStarY(int y){sY = y;}
  public int getStarY(){return sY;}
}
class SpaceShip extends Floater  
{
  private int vertices;
  private int[] xRocketCorners;
  private int[] yRocketCorners;
  public SpaceShip()
  {
    corners = 8;
    vertices = 3;
    int[] xS = {-8, -2, 2, 16, 2, -2, -8, -2};
    int[] yS = {-8, -8, -5, 0, 5, 8, 8, 0};
    int[] xR = {-8, -2, -2};
    int[] yR = {0, -4, 4};
    xCorners = xS;
    yCorners = yS;
    xRocketCorners = xR;
    yRocketCorners = yR;
    myColor = color(255);
    myCenterX = 300;
    myCenterY = 300;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
  public void rocket()
  {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRocketRotatedTranslated, yRocketRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < vertices; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRocketRotatedTranslated = (int)((xRocketCorners[nI]* Math.cos(dRadians)) - (yRocketCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRocketRotatedTranslated = (int)((xRocketCorners[nI]* Math.sin(dRadians)) + (yRocketCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRocketRotatedTranslated,yRocketRotatedTranslated);    
    }   
    endShape(CLOSE);  
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
  abstract public void setX(int x);
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
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
    fill(myColor);   
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
