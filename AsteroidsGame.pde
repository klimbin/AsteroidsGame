ArrayList <Asteroid> asteroids;
SpaceShip spaceship;
Star [] stars;
boolean left, right, accel, ready, hold;
int opac;
int d = 60;
int counter = 500;
int h = 1; //hue of hyperspace ring
int a = 1;
public void setup() 
{
  size(700,700);
  colorMode(HSB, 100);
  spaceship = new SpaceShip();
  asteroids = new ArrayList <Asteroid>();
  stars = new Star[40];
  for(int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
  for(int i = 0; i < 9; i++)
  {
    asteroids.add(new Asteroid());
  }
}
public void draw() 
{
  background(0);
  for(Star temp : stars){temp.show();}
  for(Asteroid temp : asteroids)
  {
    temp.move();
    temp.show();
  }
  for(int i = 0; i < asteroids.size(); i++)
  {
    if(dist(spaceship.getX(), spaceship.getY(), asteroids.get(i).getX(), asteroids.get(i).getY()) < 20)
    {
      asteroids.remove(i);
      i--;
    }
  }
  if(left == true){spaceship.rotate(-4);}
  if(right == true){spaceship.rotate(4);}
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
  if(opac > 0){opac--;}
  if(ready == true)
  {
    if(hold == true && d > 0)
    {
      noFill();
      strokeWeight(2);
      stroke(h, 70, 90);
      h = h + a;
      ellipse(spaceship.getX(), spaceship.getY(), d, d);
      d--;
      if(d == 0)
      {
        opac = 100;
        spaceship.setDirectionX(0);
        spaceship.setDirectionY(0);
        spaceship.setPointDirection((int)(Math.random()*361));
        spaceship.setX((int)(Math.random()*601) + 50);
        spaceship.setY((int)(Math.random()*601) + 50);
        spaceship.accelerate(0);
        counter = 0;
      }
      if(h == 100 || h == 0)
      {
        a = a * -1;
      }
    }
  }
  spaceship.show();
  spaceship.move();
  fill(0, opac);
  noStroke();
  rect(-1, -1, 701, 701);
  counter++;
  if(counter < 500){ready = false;}
  else{ready = true;}
}
public void keyPressed()
{
  if(key == 'a'){left = true;}
  if(key == 'd'){right = true;}
  if(key == 'w'){accel = true;}
  if(key == 'h')
  {
    hold = true;
    d = 60;
  }
}
public void keyReleased()
{
  if(key == 'a'){left = false;}
  if(key == 'd'){right = false;}
  if(key == 'w'){accel = false;}
  if(key == 'h'){hold = false;}
}
class Star
{
  private int sX, sY, sC;
  public Star()
  {
    sX = (int)(Math.random()*700);
    sY = (int)(Math.random()*700);
    sC = color((int)(Math.random()*101), 70, 70);
  }
  public void show()
  {
    fill(sC);
    stroke(sC);
    strokeWeight(1);
    ellipse(sX, sY, 2, 2);
  }
}
public int varyNum(int num)
{
  num = num + (int)(Math.random()*9 - 4);
  return num;
}
class Asteroid extends Floater
{
  private int rSpeed;
  public Asteroid()
  {
    rSpeed = (int)(Math.random() * 3) + 2;
    corners = 7;
    int[] xS = {varyNum(-24), varyNum(-16), varyNum(1), varyNum(16), varyNum(24), varyNum(11), varyNum(-16)};
    int[] yS = {varyNum(0), varyNum(-13), varyNum(-19), varyNum(-16), varyNum(0), varyNum(19), varyNum(14)};
    xCorners = xS;
    yCorners = yS;
    myColor = color(27, 0, 67);
    myCenterX = (int)(Math.random()*701);
    myCenterY = (int)(Math.random()*701);
    myDirectionX = Math.random() * 4 - 2;
    myDirectionY = Math.random() * 4 - 2;
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
    int[] xS = {-10, -2, 3, 18, 3, -2, -10, -2};
    int[] yS = {-10, -9, -6, 0, 6, 9, 10, 0};
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
