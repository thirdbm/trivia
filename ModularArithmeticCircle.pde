// Left Mouse button : Lower multiplication
// Right mouse button : Raise multiplication
// Mouse wheel : Change point numbers
// 0 : ColorMode = 0
// 1 : ColorMode = 1

static final float RADIUS = 300;
int MULTIPLY = 2;
int COUNT = 180;
float t;
int COLORMODE = 0;

void setup(){
  size(620,620);
}

void draw(){
  background(20);
 
  stroke(60);
  strokeWeight(1);
  fill(10); 
  ellipse(width/2,height/2,RADIUS*2,RADIUS*2);  
 
  fill(255);
  arcPoint arcPoints[] = new arcPoint[COUNT];
  for(int i = 0; i < arcPoints.length; i++){    
    float degree = (360 / (float)COUNT) * i;
    arcPoints[i] = new arcPoint();
    arcPoints[i].Reset(degree + 90, RADIUS, width/2, height/2);
    ellipse(arcPoints[i].x, arcPoints[i].y, 4,4);
  }
  
  stroke(255, 255, 255, 100);
  strokeWeight(1);
  
  for(int i=0; i<arcPoints.length; i++){
    int targetIdx = i * MULTIPLY;
    for(int mul=MULTIPLY; mul > 0; mul--){
      if(targetIdx >= arcPoints.length * mul){
        targetIdx = targetIdx - (arcPoints.length * mul);
      }
    }
    
    if(COLORMODE == 1){
      float r = abs(cos(t / 30) * 255 - ((255 / COUNT) * i));
      float g = abs(sin(t / 60) * 255 - ((255 / COUNT) * i));
      float b = abs(sin(t / 90) * 255 - ((255 / COUNT) * i));
      stroke(r, g, b, 160);
    }
    
    line(arcPoints[i].x, arcPoints[i].y, arcPoints[targetIdx].x, arcPoints[targetIdx].y);
  }  
  
  textSize(14);
  text(COUNT + " points, " + MULTIPLY + "x", 4, 16);
  t += 1;
}

void keyPressed(){
  if(key == '1') COLORMODE = 0;
  if(key == '2') COLORMODE = 1;
}

void mousePressed(){
  if(mouseButton==LEFT) { if(MULTIPLY > 0) MULTIPLY--; } 
  else if(mouseButton==RIGHT) { MULTIPLY++; }
     
   redraw();
}

void mouseWheel(MouseEvent event){
  float e = event.getCount();
  if(e < 0) { if(COUNT < 360) COUNT++; }
  else { if(COUNT > 4) COUNT--; }
    
  redraw();
}

class arcPoint{
  float x, y;
  arcPoint () {
    x = 0;
    y = 0;
  }
  void Reset(float degree, float radius, float offsetX, float offsetY){
    x = cos( (PI/180) * degree) * radius + offsetX;
    y = sin( (PI/180) * degree) * radius + offsetY;
  }
}
