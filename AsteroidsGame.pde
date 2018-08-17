ArrayList <Asteroid> asteroids;
SpaceShip spaceship;
ArrayList <Bullet> bullets;
Star [] stars;
boolean left, right, accel, ready, hold, shoot;
int opac = 100;
int HYPER_DIAMETER = 60; // hyperspace ring size
int HYPER_COOLDOWN = 500; // hyperspace cooldown time
int BULLET_COOLDOWN = 8; //bullet cooldown
int hue = 1; //hue of hyperspace ring
int alpha = 1;
int NUM_ASTEROIDS = 5;
int waveNum = 1;
float textOpac = 100;
public void setup() 
{
  size(700,700);
  colorMode(HSB, 100);
  spaceship = new SpaceShip();
  asteroids = new ArrayList <Asteroid>();
  bullets = new ArrayList <Bullet>();
  stars = new Star[40];
  for(int i = 0; i < stars.length; i++){stars[i] = new Star();}
  for(int i = 0; i < NUM_ASTEROIDS; i++){asteroids.add(new Asteroid());}
}
public void draw() 
{
  background(0);
  drawWave();
  for(Star temp : stars){temp.show();}
  for(Asteroid temp : asteroids)
  {
    temp.move();
    temp.show();
  }
  for(Bullet temp : bullets)
  {
    temp.show();
    temp.move();
  }
  for(int i = 0; i < asteroids.size(); i++) {
    if(dist(spaceship.getX(), spaceship.getY(), asteroids.get(i).getX(), asteroids.get(i).getY()) < asteroids.get(i).getHitbox())
      {
        restart();
      }
  }
  
  // draw hitbox
  //for(int i = 0; i < asteroids.size(); i++) {
  //    stroke(35, 65, 100);
  //    noFill();
  //    rect(asteroids.get(i).getX() - (asteroids.get(i).getHitbox()/2), asteroids.get(i).getY() - (asteroids.get(i).getHitbox()/2), asteroids.get(i).getHitbox(), asteroids.get(i).getHitbox());
  //}

  // make asteroids split up to two pieces once
  for(int j = 0; j < asteroids.size(); j++)
  {
    for(int k = 0; k < bullets.size(); k++)
    {
      if(dist(bullets.get(k).getX(), bullets.get(k).getY(), asteroids.get(j).getX(), asteroids.get(j).getY()) < 30)
      {
        bullets.remove(k);
        int size = asteroids.get(j).getSize();
        if(size > 1) {
          Asteroid child1 = new Asteroid();
          child1.setX(asteroids.get(j).getX());
          child1.setY(asteroids.get(j).getY());
          child1.setSize(size-1);
          Asteroid child2 = new Asteroid();
          child2.setX(asteroids.get(j).getX());
          child2.setY(asteroids.get(j).getY());
          asteroids.add(child1);
          asteroids.add(child2);
          child2.setSize(size-1);
        }
        asteroids.remove(j);
        break;
      }
    }
  }
  
  for(int i = 0; i < bullets.size(); i++) {
    bullets.get(i).setTime(bullets.get(i).getTime() - 1);
    if(bullets.get(i).getTime() == 0) {
      bullets.remove(i);
    }
  }
  
  // new wave, increase difficulty
  if(asteroids.size() == 0) {
    waveNum++;
    NUM_ASTEROIDS++;
    textOpac = 100;
    opac = 80;
    for(int i = 0; i < NUM_ASTEROIDS; i++){asteroids.add(new Asteroid());}
  }
  
  if(textOpac > 0){textOpac = textOpac - 0.4;}
  if(opac > 0){opac--;}
  userActions();
  strokeWeight(1);
  spaceship.show();
  spaceship.move();
  fill(0, opac);
  rect(-1, -1, 701, 701);
  HYPER_COOLDOWN++;
  if(BULLET_COOLDOWN < 8){BULLET_COOLDOWN++;}
  if(HYPER_COOLDOWN < 500){ready = false;}
  else{ready = true;}
}
public void drawWave() {
  fill(35, 65, 100, textOpac);
  textAlign(CENTER);
  textSize(50);
  text("WAVE " + waveNum, 350, 475);
}
public void userActions() {
  if(left == true){spaceship.rotate(-5);}
  if(right == true){spaceship.rotate(5);}
  if(accel == true)
  {
    spaceship.accelerate(.1);
    if(dist((int)(spaceship.getDirectionX()), 0, 0, (int)(spaceship.getDirectionY())) > 4)
    {
      spaceship.setDirectionX(spaceship.getDirectionX() * .9);
      spaceship.setDirectionY(spaceship.getDirectionY() * .9);
    }
    if(Math.random() < .7){spaceship.rocket();}
  }
  if(shoot == true) {
    if(BULLET_COOLDOWN == 8 && hold != true)
    {
      bullets.add(new Bullet(spaceship));
      BULLET_COOLDOWN = 0;
    }
  }
  if(ready == true)
  {
    if(hold == true && HYPER_DIAMETER > 0)
    {
      noFill();
      strokeWeight(2);
      stroke(hue, 70, 90);
      hue = hue + alpha;
      ellipse(spaceship.getX(), spaceship.getY(), HYPER_DIAMETER, HYPER_DIAMETER);
      HYPER_DIAMETER--;
      if(HYPER_DIAMETER == 0)
      {
        opac = 100;
        spaceship.setDirectionX(0);
        spaceship.setDirectionY(0);
        spaceship.setPointDirection((int)(Math.random()*361));
        spaceship.setX((int)(Math.random()*601) + 50);
        spaceship.setY((int)(Math.random()*601) + 50);
        spaceship.accelerate(0);
        HYPER_COOLDOWN = 0;
      }
      if(hue == 100 || hue == 0){alpha = alpha * -1;}
    }
  }
}
public void restart() {
    spaceship.setX(350);
    spaceship.setY(350);
    spaceship.setDirectionX(0);
    spaceship.setDirectionY(0);
    spaceship.setPointDirection((int)(Math.random()*360));
    opac = 100;
    textOpac = 100;
    HYPER_DIAMETER = 60;
    HYPER_COOLDOWN = 500;
    BULLET_COOLDOWN = 8;
    
    asteroids.clear();
    for(int i = 0; i < NUM_ASTEROIDS; i++){asteroids.add(new Asteroid());}
}
public void keyPressed()
{
  if(key == 'a'){left = true;}
  if(key == 'd'){right = true;}
  if(key == 'w'){accel = true;}
  if(key == 'h'){hold = true;}
  if(key == ' '){shoot = true;}
}
public void keyReleased()
{
  if(key == 'a'){left = false;}
  if(key == 'd'){right = false;}
  if(key == 'w'){accel = false;}
  if(key == 'h')
  {
    hold = false;
    HYPER_DIAMETER = 60;
  }
  if(key == ' '){shoot = false;}
}
class Star
{
  private int sX, sY, sC;
  public Star()
  {
    sX = (int)(Math.random()*701);
    sY = (int)(Math.random()*701);
    sC = color((int)(Math.random()*101), 70, 70);
  }
  public void show()
  {
    fill(sC);
    stroke(sC);
    ellipse(sX, sY, 2, 2);
  }
}
public int varyNum(int num)
{
  num = num + (int)(Math.random()*9 - 4);
  return num;
}
class Bullet extends Floater
{
  private int myTime;
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection() + (Math.random()*7)-3;
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = Math.sin(dRadians) + theShip.getDirectionY();
    myColor = color(0, 80, 90);
    accelerate(5);
    myTime = 80;
  }
  public void show()
  {
    fill(myColor, 35 + myTime);
    stroke(myColor, 35 + myTime);
    ellipse((int)myCenterX, (int)myCenterY, 5, 5);
  }
  public void setTime(int time){myTime = time;}
  public int getTime(){return myTime;}
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
class Asteroid extends Floater
{
  private int rSpeed;
  private int myHitbox;
  private int mySize;
  public Asteroid()
  {
    mySize = 3;
    rSpeed = (int)(Math.random() * 2) + 2;
    corners = 7;
    myHitbox = 43;
    int[] xS = {varyNum(-35), varyNum(-23), varyNum(1), varyNum(23), varyNum(35), varyNum(16), varyNum(-23)};
    int[] yS = {varyNum(0), varyNum(-19), varyNum(-28), varyNum(-23), varyNum(0), varyNum(28), varyNum(20)};
    xCorners = xS;
    yCorners = yS;
    myColor = color(27, 0, 67);
    myCenterX = Math.random() * 701;
    myCenterY = Math.random() * 701;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = (int)(Math.random()*360);
    accelerate(Math.random() * (5 - mySize));
  }
  public void move()
  {
    rotate(rSpeed);
    super.move();
  }
  public void setSize(int size){

    while(mySize != size) {
      myHitbox = (int)(myHitbox/1.5);
      for(int i = 0; i < xCorners.length; i++) {
        xCorners[i] = (int)(xCorners[i]/1.5);
        yCorners[i] = (int)(yCorners[i]/1.5);
      }
      accelerate(Math.random() * (4 - mySize));
      mySize--;
    }
  }
  public int getSize(){return mySize;}
  public void setHitbox(int hitbox){myHitbox = hitbox;}
  public int getHitbox(){return myHitbox;}
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
    myPointDirection = (int)(Math.random()*360);
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
