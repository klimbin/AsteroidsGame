Asteroid [] asteroids;
SpaceShip spaceship;
Star [] stars;
boolean left, right, accel;
public void setup() 
{
  background(0);
  size(700,700);
  colorMode(HSB, 100);
  spaceship = new SpaceShip();
  asteroids = new Asteroid[7];
  stars = new Star[50];
  for(int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
  for(int i = 0; i < asteroids.length; i++)
  {
    asteroids[i] = new Asteroid();
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
  for(int i = 0; i < asteroids.length; i++)
  {
    asteroids[i].move();
    asteroids[i].show();
  }
  if(left == true)
  {
    spaceship.rotate(-6);
  }
  if(right == true)
  {
    spaceship.rotate(6);
  }
  if(accel == true)
  {
    spaceship.accelerate(.069);
    if(dist((int)(spaceship.getDirectionX()), 0, 0, (int)(spaceship.getDirectionY())) > 4)
    {
      spaceship.setDirectionX(spaceship.getDirectionX() * .9);
      spaceship.setDirectionY(spaceship.getDirectionY() * .9);
    }
    if(Math.random() < .7)
    {
      spaceship.rocket();
    }
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
  private int sX, sY, sC;
  public Star()
  {
    sX = (int)(Math.random()*701);
    sY = (int)(Math.random()*801)-100;
    sC = color((int)(Math.random()*101), 70, 70);
  }
  public void move()
  {
    sY++;
    if(sY > 700)
    {
      sY = 0;
    }
  }
  public void show()
  {
    fill(sC);
    stroke(sC);
    ellipse(sX, sY, 2, 2);
  }
}
class Asteroid extends Floater
{
  private int rSpeed;
  public Asteroid()
  {
    rSpeed = (int)(Math.random() * 3) + 3;
    corners = 5;
    int[] xS = {-12, 5, 7, 15, 9, -2};
    int[] yS = {-12, -11, 0, 7, 12, -3};
    xCorners = xS;
    yCorners = yS;
    myColor = color(27, 0, 67);
    if((int)(Math.random() * 2) == 0)
    {
      myCenterX = (int)(Math.random()*251);
    }
    else
    {
      myCenterX = (int)(Math.random()*251) + 450;
    }
    if((int)(Math.random() * 2) == 0)
    {
      myCenterY = (int)(Math.random()*251);
    }
    else
    {
      myCenterY = (int)(Math.random()*251) + 450;
    }
    if((int)(Math.random()*2) == 0)
    {
      myDirectionX = (int)(Math.random() * 2) + 1;
    }
    else
    {
      myDirectionX = -1 * (int)(Math.random() * 2) - 1;
    }
    if((int)(Math.random()*2) == 0)
    {
      myDirectionY = (int)(Math.random() * 2) + 1;
    }
    else
    {
      myDirectionY = -1 * (int)(Math.random() * 2) - 1; 
    }
  }
  public void move()
  {
    rotate(rSpeed);
    super.move();
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
    int[] xS = {-12, -3, 4, 22, 4, -3, -12, -3};
    int[] yS = {-12, -11, -7, 0, 7, 11, 12, 0};
    int[] xR = {-17, -3, -3};
    int[] yR = {0, -9, 9};
    xCorners = xS;
    yCorners = yS;
    xRocketCorners = xR;
    yRocketCorners = yR;
    myColor = color(0, 0, 100);
    myCenterX = 350;
    myCenterY = 350;
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
    fill(5, 70, 100, 30);
    stroke(100, 70, 100);
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
