void ground1() {
  FLine line = new FLine(-300, 300, 650, 300);
  line.setStroke(0);
  line.setStrokeWeight(3);
  line.setFriction(100);
  world.add(line);
  randomSeed(58352879);
  for (int i = 0; i < 15; i++) {   
    FCircle c = new FCircle(30);
    c.setPosition(-100+40*i, 300+random(-5, 5));
    c.setStatic(true);
    world.add(c);
  }
  FLine line1 = new FLine(550, 300, 650, 300);
  line1.setStroke(255, 0, 0);
  line1.setStrokeWeight(3);
  line1.setFriction(100);
  world.add(line1);
}

void ground2() {
  FLine line = new FLine(2000, 320, 2540, 320);
  line.setStroke(0);
  line.setStrokeWeight(3);
  line.setFriction(100);
  world.add(line);
  FLine line1 = new FLine(2540, 320, 2600, 320);
  line1.setStroke(0);
  line1.setStrokeWeight(3);
  line1.setFriction(1);
  world.add(line1);
  FBody ball = new FCircle(55);
  ball.setPosition(2550, 270);
  ball.setDensity(0.3);
  
  world.add(ball);
  FLine line2 = new FLine(2600, 320, 2600, 400);
  line2.setStroke(0);
  line2.setStrokeWeight(3);
  line2.setFriction(1);
  world.add(line2);
  FLine line3 = new FLine(2600, 400, 2818, 400);  
  line3.setStroke(0);
  line3.setStrokeWeight(3);
  line3.setFriction(1);
  world.add(line3);
  FLine line4 = new FLine(2850, 400, 2850, 350);
  line4.setStroke(0);
  line4.setStrokeWeight(3);
  line4.setFriction(1);
  world.add(line4);
  FLine line5 = new FLine(2850, 350, 2900, 350);
  line5.setStroke(0);
  line5.setStrokeWeight(3);
  line5.setFriction(0);
  world.add(line5);
  FBox pomp = new FBox(100, 10);
  pomp.setPosition(2555, 395);
  pomp.setSensor(true);
  pomp.setStatic(true);
  world.add(pomp);
  FBox pomp1 = new FBox(10, 400);
  pomp1.setPosition(2500, height+14);
  pomp1.setSensor(true);
  pomp1.setStatic(true);
  world.add(pomp1);
}

void ground3() {
  //FLine line4 = new FLine(2940, 350, 2950, 350);
  //line4.setStroke(0);
  //line4.setStrokeWeight(3);
  //line4.setFriction(0);
  //world.add(line4);
  FLine line = new FLine(2930, 350, 3000, 400);
  line.setStroke(0);
  line.setStrokeWeight(3);
  line.setFriction(0);
  world.add(line);
  FLine line1 = new FLine(3000, 400, 3100, 400);
  line1.setStroke(0);
  line1.setStrokeWeight(3);
  line1.setFriction(0);
  world.add(line1);
  FCircle[] c = new FCircle[6];
  for (int i = 0; i < c.length; i++) {
    c[i] = new FCircle(20);
    c[i].setPosition(3010+20*i+10, 400-15);
    c[i].setFriction(0.01);
    c[i].setDensity(0.31);
    c[i].setRestitution(0);
    if (!(i==c.length-1)) {
      world.add(c[i]);
    }
    //FLine line1 = new FLine(3000+20*i, 400, 3000+20*i+10, 400);
    //line1.setStroke(0);
    //line1.setStrokeWeight(3);
    //line1.setFriction(0);
    //world.add(line1);
  }
  FLine line2 = new FLine(3100, 400, 3151, 470);
  line2.setStroke(0);
  line2.setStrokeWeight(3);
  line2.setFriction(0);
  world.add(line2);
  FLine line6 = new FLine(3151, 470, 3350, 500);
  line6.setStroke(0);
  line6.setStrokeWeight(3);
  line6.setFriction(0);
  world.add(line6);
  //FLine line7 = new FLine(3100, 400, 3225, 480);
  //line7.setStroke(0);
  //line7.setStrokeWeight(3);
  //line7.setFriction(0);
  //world.add(line7);
  FLine line3 = new FLine(3350, 500, 3500, 500);
  line3.setStroke(0);
  line3.setStrokeWeight(3);
  line3.setFriction(100);
  line3.setRestitution(0);
  world.add(line3);
  FLine line5 = new FLine(3500, 500, 3650, 400);
  line5.setStroke(0);
  line5.setStrokeWeight(3);
  line5.setFriction(0);
  world.add(line5);
}
void ground4() {
  FBox box = new FBox(100, 10);
  box.setPosition(3330, 250-214);
  box.setStatic(true);
  world.add(box);
  //FLine line5 = new FLine(3400,110, 3280, 120);
  //line5.setStroke(0);
  //line5.setStrokeWeight(3);
  //line5.setFriction(0);
  //line5.setBullet(true);
  //world.add(line5);
  FBox box5 = new FBox(160, 10);
  box5.setPosition(3350, 195);
  box5.setRotation(PI/4);
  box5.setStatic(true);
  box5.setRestitution(4.78);
  box5.setFill(0,255,100);
  world.add(box5);
}
void ground5() {
  FLine line5 = new FLine(3700, 210-15, 4100, 210-10);
  line5.setStroke(0);
  line5.setStrokeWeight(3);
  line5.setFriction(0);
  world.add(line5);
  chain(4200,0,4180,210,14);
  chain2(4305,24,4600,24,24);
  FLine line1 = new FLine(4621,0, 4700, 10);
  line1.setStroke(0);
  line1.setStrokeWeight(3);
  line1.setFriction(0);
  world.add(line1);
  FLine line2 = new FLine(4701,10, 4750, 10);
  line2.setStroke(0);
  line2.setStrokeWeight(3);
  line2.setFriction(0);
  world.add(line2);
  //FLine line2 = new FLine(4270,-5, 4283, -5);
  //line2.setStroke(0);
  //line2.setStrokeWeight(3);
  //line2.setFriction(4);
  //world.add(line2);
  cannon(4750-3-10, 10-45+1,4750-3, 10-45+50+19);
  FLine line3 = new FLine(4800,50, 5600, 50);
  line3.setStroke(0);
  line3.setStrokeWeight(3);
  line3.setFriction(1000);
  world.add(line3);
  for(int i = 0; i < 22; i++){
    for(int j = 0; j <= i; j++){
      FBox box = new FBox(16, 15);
      box.setPosition(5200-16/2*i+15*j,-340+15*i);
      box.setDensity(0.001);
      box.setFriction(1);
      box.setRestitution(0);
      box.setStatic(false);
      world.add(box);
    }
  }
}
