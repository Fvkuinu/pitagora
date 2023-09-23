/////  PRESS SPACE TO START!!!!!!!!!!    ////

import fisica.*;
FWorld world;
FWorld world2;
Tank tank;

int ttt = 0;
int tttt = 0;
int ttttt = 0;
int tttttt=0;
float translateX = 0;
float translateY = 0;
int time = 1200000;
int startTime = -120000000;
boolean fire = false;
boolean stop = false;
boolean start = false;
float scale = 1;
void setup() {
  size(1024, 576);
  noLoop();
  smooth();
  PFont font = createFont("GenShinGothic-Bold.ttf", 72);
  textFont(font);
  textSize(240);
  Fisica.init(this);
  Fisica.setScale(10);
  world = new FWorld(-1000, -1000, 10000, 10000);
  world2 = new FWorld(-1000, -1000, 10000, 10000);
  world.setGrabbable(false);
  //world.setGravity(0,10);
  //world.setEdges();
  tank = new Tank( 200, 230);
  Domino domino = new Domino(2050, 275, 50, 10);
  Kanransha kanransha = new Kanransha(3330, 250);
  ground1();
  ground2();
  ground3();
  ground4();
  ground5();
  world.setGrabbable(false);
}

void draw() {
  background(255);
  translate(translateX, translateY);
  scale(scale);
  int t = millis()-startTime;
  if (tank.getBodyX()>560 && !stop) {
    tank.setSpeed(0);
    tank.setGunAngle(-25);
    time = millis();
    stop = true;
  }

  if (!fire && millis()-time>2400 && frameCount>10 ) {
    tank.fire();
    fire=true;
  }
  if (fire) {
    if (t<8400) {
      translateX=-tank.bullet.getX()+width/2;
    } else if (t<16000) {
      translateX-=1.4;

      if (scale>0.7) {
        scale-=0.0004;
        translateY+=0.2;
      }
    } else if (t<30000) {
    } else if (t<36000) {
      translateX-=1.2;
    } else if (t<43000) {
    } else if (t<53000) {
      translateX-=2.1;

      translateY+=0.62;
    }else if(t<58000){
    }else if(t<100000){
      particle(5200,170);
    }

  }
  liquid(2605, 395);
  fill(0);
  text("終", 5070, -10);
  world.step();

  world.draw();
  world2.step();
  world2.draw();
}

void keyPressed() {
  if (key == ' ') {
    println(millis()-startTime);
    if (!start) {
      startTime = millis();
      start=true;
    }
    loop();
  }
}
void mousePressed() {

}
void mouseDragged() {

}
