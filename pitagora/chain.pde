void chain(float x1, float y1, float x2, float y2, int step) {
  int komaCount = 3;  //間に挟む玉の数

  float gearSpeed = 2.92784;  //ギアの速さ
  float torque = 1000000;  //ギアのとるく

  float overlapping = 4;  //チェーンの重なり具合
  int boxHeight = 10;  //チェーンの太さ
  int r = 20;  //ギア半径
  float tension = 3;  //チェーンの張り具合　適正　3.14
  float theta = atan2((y2-y1), (x2-x1));
  float l =sqrt(sq(x2-x1)+sq(y2-y1));
  float L = l+tension*r;
  float boxLength = 1.0*L/step+overlapping*2;
  PVector o1o2 = new PVector((x2-x1), (y2-y1));
  PVector o1p1 = new PVector();
  o1p1 = o1o2.copy();
  o1p1.rotate(PI/2);
  o1p1.setMag(r);
  PVector a = new PVector();
  a = o1o2.copy();
  a.setMag(tension*r/2);
  PVector o1p2 = new PVector(0, 0);
  o1p2.add(o1p1);
  o1p2.sub(a);
  PVector boxToBox = new PVector();
  boxToBox = o1o2.copy();
  boxToBox.setMag(L/step);
  PVector o1 = new PVector(x1, y1);
  PVector o2 = new PVector(x2, y2);
  PVector p2 = new PVector(0, 0);
  p2.add(o1);
  p2.add(o1p2);
  PVector p4 = new PVector(0, 0);
  p4.add(o1p2);
  p4.mult(-1);
  p4.add(o2);
  FBody chain[][] = new FBody[2][step];
  for (int i = 0; i < chain.length; i++) {
    boxToBox.mult(pow(-1, i));
    for (int j = 0; j < chain[i].length; j++) {
      PVector v = new PVector(0, 0);
      v = boxToBox.copy();
      v.mult(j);
      if (i==0) {
        v.add(p2);
      } else if (i==1) {
        v.add(p4);
      }
      if (i==0) {
        chain[i][j] = new FBox(boxLength, boxHeight);
        chain[i][j].setPosition(v.x, v.y);
        //chain[i][j].setSensor(true);
        chain[i][j].setRotation(theta);
        world.add(chain[i][j]);
        if (j%4==1) {
          FBody hika = new FBox(8, 50);
          hika.setPosition(chain[i][j].getX()-25, chain[i][j].getY());
          hika.setRestitution(-400);
          hika.setRotation(-PI/3.3);
          world.add(hika);
          FPrismaticJoint jjj = new FPrismaticJoint(chain[i][j], hika);
          jjj.setAnchor(chain[i][j].getX(), chain[i][j].getY());
          jjj.setEnableLimit(true);
          jjj.setUpperTranslation(0);
          jjj.setLowerTranslation(0);
          jjj.setCollideConnected(false);
          jjj.setNoStroke();
          jjj.setNoFill();
          world.add(jjj);
        }
      } else {
        chain[i][chain[i].length-j-1] = new FBox(boxLength, boxHeight);
        chain[i][chain[i].length-j-1].setPosition(v.x, v.y);
        //chain[i][chain[i].length-j-1].setSensor(true);
        chain[i][chain[i].length-j-1].setRotation(theta);
        world.add(chain[i][chain[i].length-j-1]);
        if ((chain[i].length-j-1)%4==2) {
          FBody hika = new FBox(8, 50);
          hika.setPosition(chain[i][chain[i].length-j-1].getX()+25, chain[i][chain[i].length-j-1].getY());
          hika.setRotation(-PI/3.3);
          hika.setRestitution(-100);
          world.add(hika);
          FPrismaticJoint jjj = new FPrismaticJoint( hika,chain[i][chain[i].length-j-1]);
          jjj.setAnchor(chain[i][chain[i].length-j-1].getX(), chain[i][chain[i].length-j-1].getY());
          jjj.setEnableLimit(true);
          jjj.setUpperTranslation(0);
          jjj.setLowerTranslation(0);
          jjj.setCollideConnected(false);
          jjj.setNoStroke();
          jjj.setNoFill();
          world.add(jjj);
        }
      }
      //pushMatrix();
      //translate(v.x,v.y);
      //rotate(theta);
      //rectMode(CENTER);
      //fill(255,0,0,80);
      //rect(0,0, boxLength, boxHeight);
      //popMatrix();
      if (j>0) {
        PVector v2 = v.copy();
        v2.add(PVector.mult(boxToBox, -1.0/2));
        if (i==0) {
          FRevoluteJoint rJoint = new FRevoluteJoint(chain[i][j-1], chain[i][j]);
          rJoint.setAnchor(v2.x, v2.y);
          rJoint.setCollideConnected(false);
          
          world.add(rJoint);
          //stroke(j*50);
          //line(v.x, v.y, v2.x, v2.y);
        } else if (i==1) {
          FRevoluteJoint rJoint = new FRevoluteJoint(chain[i][chain[i].length-j], chain[i][chain[i].length-j-1]);
          rJoint.setAnchor(v2.x, v2.y);
          rJoint.setCollideConnected(false);
          
          world.add(rJoint);
        }
      }
    }
  }
  chain[0][0].setPosition(chain[1][0].getX()+boxToBox.x, chain[1][0].getY()+boxToBox.y);
  chain[0][0].setRotation(PI+theta);
  FRevoluteJoint rJoint1 = new FRevoluteJoint(chain[1][0], chain[0][0]);
  rJoint1.setAnchor(chain[0][0].getX()-boxToBox.x/2, chain[0][0].getY()-boxToBox.y/2);
  rJoint1.setCollideConnected(false);
   
  world.add(rJoint1);

  chain[1][step-1].setPosition(chain[0][step-1].getX()-boxToBox.x, chain[0][step-1].getY()-boxToBox.y);
  chain[1][step-1].setRotation(PI+theta);
  FRevoluteJoint rJoint2 = new FRevoluteJoint(chain[0][step-1], chain[1][step-1]);
  rJoint2.setAnchor(chain[1][step-1].getX()+boxToBox.x/2, chain[1][step-1].getY()+boxToBox.y/2);
  rJoint2.setCollideConnected(false);
   
  world.add(rJoint2);



  FBody[] gear = new FBody[2];
  FBody[] fixGear = new FBody[2];
  for (int i = 0; i < gear.length; i++) {
    gear[i] = new FCircle(r*2);
    if (i==0) {
      gear[i].setPosition(x1, y1);
      gear[i].setBullet(true);
    } else {
      gear[i].setPosition(x2, y2);
      gear[i].setBullet(true);
    }
    gear[i].setFriction(1000);
    world.add(gear[i]);
    fixGear[i] = new FCircle(5);
    fixGear[i].setPosition(gear[i].getX(), gear[i].getY());
    fixGear[i].setStatic(true);
    world.add(fixGear[i]);
    FRevoluteJoint rJoint = new FRevoluteJoint(fixGear[i], gear[i]);
    rJoint.setAnchor(gear[i].getX(), gear[i].getY());
    rJoint.setCollideConnected(false);
    rJoint.setEnableMotor(true);
    rJoint.setMotorSpeed(gearSpeed);
    rJoint.setMaxMotorTorque(torque);
     
    world.add(rJoint);
  }



  for (int i = 1; i <= komaCount; i++) {
    FBody koma = new FCircle(r*2);
    koma.setPosition(x1+1.0*i*o1o2.x/(komaCount+1), y1+1.0*i*o1o2.y/(komaCount+1));
    koma.setStatic(true);
    koma.setRotatable(true);
    koma.setFriction(0);
    koma.setFill(255);
    world.add(koma);
  }
  //ellipse(x1, y1, r*2, r*2);
  //ellipse(x2, y2, r*2, r*2);
}

void chain2(float x1, float y1, float x2, float y2, int step) {
  int komaCount = 4;  //間に挟む玉の数
  
  float gearSpeed = 10;  //ギアの速さ
  float torque = 1000000;  //ギアのとるく
  
  float overlapping = 4;  //チェーンの重なり具合
  int boxHeight = 10;  //チェーンの太さ
  int r = 20;  //ギア半径
  float tension = PI;  //チェーンの張り具合　適正　3.14
  float theta = atan2((y2-y1), (x2-x1));
  float l =sqrt(sq(x2-x1)+sq(y2-y1));
  float L = l+tension*r;
  float boxLength = 1.0*L/step+overlapping*2;
  PVector o1o2 = new PVector((x2-x1), (y2-y1));
  PVector o1p1 = new PVector();
  o1p1 = o1o2.copy();
  o1p1.rotate(PI/2);
  o1p1.setMag(r);
  PVector a = new PVector();
  a = o1o2.copy();
  a.setMag(tension*r/2);
  PVector o1p2 = new PVector(0, 0);
  o1p2.add(o1p1);
  o1p2.sub(a);
  PVector boxToBox = new PVector();
  boxToBox = o1o2.copy();
  boxToBox.setMag(L/step);
  PVector o1 = new PVector(x1, y1);
  PVector o2 = new PVector(x2, y2);
  PVector p2 = new PVector(0, 0);
  p2.add(o1);
  p2.add(o1p2);
  PVector p4 = new PVector(0, 0);
  p4.add(o1p2);
  p4.mult(-1);
  p4.add(o2);
  FBody chain[][] = new FBody[2][step];
  for (int i = 0; i < chain.length; i++) {
    boxToBox.mult(pow(-1, i));
    for (int j = 0; j < chain[i].length; j++) {
      PVector v = new PVector(0, 0);
      v = boxToBox.copy();
      v.mult(j);
      if (i==0) {
        v.add(p2);
      } else if (i==1) {
        v.add(p4);
      }
      if (i==0) {
        chain[i][j] = new FBox(boxLength, boxHeight);
        chain[i][j].setPosition(v.x, v.y);
        //chain[i][j].setSensor(true);
        chain[i][j].setRotation(theta);
        chain[i][j].setFriction(100);
        chain[i][j].setRestitution(-3);
        world.add(chain[i][j]);
      } else {
        chain[i][chain[i].length-j-1] = new FBox(boxLength, boxHeight);
        chain[i][chain[i].length-j-1].setPosition(v.x, v.y);
        //chain[i][chain[i].length-j-1].setSensor(true);
        chain[i][chain[i].length-j-1].setRotation(theta);
        chain[i][chain[i].length-j-1].setFriction(100);
        chain[i][chain[i].length-j-1].setRestitution(-3);
        world.add(chain[i][chain[i].length-j-1]);
      }
      //pushMatrix();
      //translate(v.x,v.y);
      //rotate(theta);
      //rectMode(CENTER);
      //fill(255,0,0,80);
      //rect(0,0, boxLength, boxHeight);
      //popMatrix();
      if (j>0) {
        PVector v2 = v.copy();
        v2.add(PVector.mult(boxToBox, -1.0/2));
        if (i==0) {
          FRevoluteJoint rJoint = new FRevoluteJoint(chain[i][j-1], chain[i][j]);
          rJoint.setAnchor(v2.x, v2.y);
          rJoint.setCollideConnected(false);
           
          world.add(rJoint);
          //stroke(j*50);
          //line(v.x, v.y, v2.x, v2.y);
        } else if (i==1) {
          FRevoluteJoint rJoint = new FRevoluteJoint(chain[i][chain[i].length-j], chain[i][chain[i].length-j-1]);
          rJoint.setAnchor(v2.x, v2.y);
          rJoint.setCollideConnected(false);
           
          world.add(rJoint);
        }
      }
    }
  }
  chain[0][0].setPosition(chain[1][0].getX()+boxToBox.x, chain[1][0].getY()+boxToBox.y);
  chain[0][0].setRotation(PI+theta);
  FRevoluteJoint rJoint1 = new FRevoluteJoint(chain[1][0], chain[0][0]);
  rJoint1.setAnchor(chain[0][0].getX()-boxToBox.x/2, chain[0][0].getY()-boxToBox.y/2);
  rJoint1.setCollideConnected(false);
  world.add(rJoint1);

  chain[1][step-1].setPosition(chain[0][step-1].getX()-boxToBox.x, chain[0][step-1].getY()-boxToBox.y);
  chain[1][step-1].setRotation(PI+theta);
  FRevoluteJoint rJoint2 = new FRevoluteJoint(chain[0][step-1], chain[1][step-1]);
  rJoint2.setAnchor(chain[1][step-1].getX()+boxToBox.x/2, chain[1][step-1].getY()+boxToBox.y/2);
  rJoint2.setCollideConnected(false);
  world.add(rJoint2);


  
  FBody[] gear = new FBody[2];
  FBody[] fixGear = new FBody[2];
  for (int i = 0; i < gear.length; i++) {
    gear[i] = new FCircle(r*2);
    if(i==0){
      gear[i].setPosition(x1, y1);
    } else {
      gear[i].setPosition(x2, y2);
    }
    gear[i].setFriction(1);
    world.add(gear[i]);
    fixGear[i] = new FCircle(5);
    fixGear[i].setPosition(gear[i].getX(), gear[i].getY());
    fixGear[i].setStatic(true);
    world.add(fixGear[i]);
    FRevoluteJoint rJoint = new FRevoluteJoint(fixGear[i], gear[i]);
    rJoint.setAnchor(gear[i].getX(), gear[i].getY());
    rJoint.setCollideConnected(false);
    rJoint.setEnableMotor(true);
    rJoint.setMotorSpeed(gearSpeed);
    rJoint.setMaxMotorTorque(torque);
    world.add(rJoint);
  }
  
  
  
  for(int i = 1; i <= komaCount; i++){
    FBody koma = new FCircle(r*2);
    koma.setPosition(x1+1.0*i*o1o2.x/(komaCount+1), y1+1.0*i*o1o2.y/(komaCount+1));
    koma.setStatic(true);
    koma.setRotatable(true);
    koma.setFill(255);
    world.add(koma);
  }
  //ellipse(x1, y1, r*2, r*2);
  //ellipse(x2, y2, r*2, r*2);
}
