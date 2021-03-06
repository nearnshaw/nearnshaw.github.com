dotito[] punto = new dotito[15];


void setup ()
{
background(155);
size(500,500);

for (int i = 0; i< punto.length; i++)
{punto[i] = new dotito(punto, i);}


 
 
}


void draw ()
{
  fill(100, 120, 250,98);
  rect(0,0, width, height);
  
  for (int i = 0; i < punto.length; i++)
  {
  punto[i].bounce();
  punto[i].friction();
  }
  for (int i = 0; i < punto.length; i++)
  {
  punto[i].move();
  punto[i].display();  
  }
  
 


}
///////////////////////////////////////////////////////////////

class dotito
{
PVector location;
PVector speed;
PVector acceleration;
PVector mouse;
PVector dir;
float speedmax = 1.5;
dotito[] others;
float dotsize;
int ID;
int stucknum = 5;
linejoin[] stuck = new linejoin[stucknum];
boolean[] isstuck = new boolean[stucknum];
int index = 0;
  
dotito(dotito[] othr, int tID)
{
location = new PVector(random(0,500),random(0,500));
speed = new PVector(random(0,3),random(0,3));
acceleration =  new PVector(0,0); //new PVector(random(-3,3),random(-3,3));
others = othr;
ID = tID;
dotsize = random(20,45);
}

void display()
{
   stroke(0,30);
   strokeWeight(1);
   fill(155,30,30);
   ellipse(location.x,location.y,dotsize,dotsize);
   
    
   for (int i = 0; i < stuck.length; i++)
   {
     if (isstuck[i] == true)
     {
       stuck[i].pull();
       stuck[i].display();
      }
   } 
   
}
  

void move()
{
speed.add(acceleration);
speed.limit(speedmax);

location.add(speed);
}

void friction()
{
  speed.mult(0.995);
  acceleration.mult(0.8);
}


void bounce()
{
  
if (location.x < 0){speed.x*=(-1); acceleration.x*=(-1);}
else if (location.x>width) {speed.x*=(-1);acceleration.x*=(-1);}

if (location.y < 0){speed.y*=(-1);acceleration.y*=(-1);}
else if (location.y>height) {speed.y*=(-1);acceleration.y*=(-1);}

for (int i = 0;i<others.length;i++)
{ 
      float dx = others[i].location.x - location.x;
      float dy = others[i].location.y - location.y;
      float distance = sqrt(dx*dx + dy*dy);
      float sizeratio = dotsize/others[i].dotsize;
    if (distance < (dotsize/2+others[i].dotsize/2) )
  {
    speed.x -= dx/(sizeratio*30);
    speed.y -= dy/(sizeratio*30);
    //speed.sub(others[i].speed);
    //speed.sub(others[i].speed.mult(sizeratio/10));
    acceleration.sub(others[i].acceleration);//.mult(sizeratio*10));
    //acceleration.y.sub(others[i].acceleration);//.mult(sizeratio*10));
    if (others[i].ID != ID )
    {
        isstuck[index] = true;
        stuck[index] = new linejoin(others, i,ID);
        if (index == stucknum-1)
            {index = 0;}
        else
          {index += 1;}
    }
  }
}

}



}

//////////////////////////////////////////////////////////

class linejoin
{
  
  dotito[] pts;
  int ptA;
  int ptB;
  float distance;
  float xyratio;
  float angle;
  float rA;
  float rB;
  float oxA;
  float oxB;
  float oyA;
  float oyB;
       
  
  
  
  linejoin(dotito[] todoslospuntos, int pointA, int pointB)
  {
     pts = todoslospuntos;  
     ptA = pointA;
     ptB = pointB;
     rA = (pts[ptA].dotsize)/2;
     rB = (pts[ptB].dotsize)/2;
  }
  
  
  void display()
    {
       stroke(155,30,30,10);
       //float dx = pts[ptA].location.x - pts[ptB].location.x;
       //float dy = pts[ptA].location.y - pts[ptB].location.y;
       //distance = sqrt(dx*dx + dy*dy);
       float sxA = rA*(sin(angle));
       float syA = sxA*xyratio;
       float sxB = rB*(sin(angle));
       float syB = sxB*xyratio;
       
       
       
     if (pts[ptA].location.x < pts[ptB].location.x)
      {
        oxA =  pts[ptA].location.x + sxA;
        oxB =  pts[ptB].location.x - sxB;}
     if (pts[ptA].location.y < pts[ptB].location.y) 
       {
         oyA =  pts[ptA].location.y + syA;
        oyB = pts[ptB].location.y - syB;
      }
      if (pts[ptA].location.x > pts[ptB].location.x)
      {
       oxA =  pts[ptA].location.x - sxA;
       oxB =  pts[ptB].location.x + sxB;
      }
      if (pts[ptA].location.y > pts[ptB].location.y)
      {
        oyA =  pts[ptA].location.y - syA;
       oyB = pts[ptB].location.y + syB;
      }

       strokeWeight(600/distance);
       //line (oxA, oyA, oxB, oyB);   
       
       
       line(pts[ptA].location.x,pts[ptA].location.y, pts[ptB].location.x,pts[ptB].location.y);
    }
  
  void pull()
  {
    float dx = pts[ptA].location.x - pts[ptB].location.x;
    float dy =pts[ptA].location.y - pts[ptB].location.y;
    distance = sqrt(dx*dx + dy*dy);
    xyratio = dx/dy;
    angle = atan(dy/dx);
    
    if (distance > 40)
    {  
       PVector direction = PVector.sub(pts[ptA].location, pts[ptB].location);
       direction.mult(0.000002*distance);
       PVector dirneg = PVector.sub(pts[ptB].location,pts[ptA].location) ;
       dirneg.mult(0.000002*distance);
       //dirneg = direction.mult(-1);
       pts[ptA].acceleration.add(dirneg);
       pts[ptB].acceleration.add(direction);
    }
  }
  
  
}

