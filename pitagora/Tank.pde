class Tank {
  int x;
  int y;
  FCompound body;
  FBody[] gear = new FBody[2];
  FRevoluteJoint mainGunJoint;
  FBox mainGun;
  FCircle bullet;
  FRevoluteJoint[] rJoint = new FRevoluteJoint[2];
  Tank(int x, int y) {
    this.x = x;
    this.y = y;
    FBox body1 = new FBox(160, 40);
    body1.setPosition(0, 5);
    body1.setSensor(true);
    body1.setDensity(0);
    mainGun = new FBox(70, 10);
    mainGun.setPosition(x+60, y-30);
    mainGun.setSensor(true);
    mainGun.setRotation(0);
    mainGun.setDensity(0.6);
    world.add(mainGun);
    FPoly turret = new FPoly();
    turret.vertex(30, 15);
    turret.vertex(-10, 15);
    turret.vertex(-10, 10);
    turret.vertex(-40, 10);
    turret.vertex(-40, 0);
    turret.vertex(-25, -15);
    turret.vertex(30, -15);
    turret.vertex(37, -5);
    turret.vertex(40, 5);

    turret.setPosition(15, -30);
    turret.setSensor(true);
    turret.setDensity(0);
    body = new FCompound();
    body.addBody(body1);
    body.addBody(turret);
    body.setPosition(x+0, y-0);
    body.setDensity(2);
    world.add(body);
    
    mainGunJoint = new FRevoluteJoint(body, mainGun);
    mainGunJoint.setAnchor(mainGun.getX()-35, mainGun.getY());
    mainGunJoint.setCollideConnected(false);
    mainGunJoint.setEnableMotor(true);
    mainGunJoint.setEnableLimit(true);
    mainGunJoint.setUpperAngle(radians(7));
    mainGunJoint.setLowerAngle(radians(-25));
    mainGunJoint.setReferenceAngle(0);
    mainGunJoint.setNoFill();
    mainGunJoint.setNoStroke();
    world.add(mainGunJoint);
    c(x+-35, y+5);
    c(x+0, y+5);
    c(x+35, y+5);
    b(x+50+5, y+40);
    b(x+25+5, y+40);
    b(x+0+5, y+40);
    b(x-25+5, y+40);
    b(x-50+5, y+40);
    a(x-70, y+10, x+70, y+10, 20);
    mainGunJoint.setUpperAngle(-25);
    mainGunJoint.setLowerAngle(-25);
  }

  void c(int x, int y) {
    FBody wheel = new FCircle(15);
    wheel.setPosition(x, y);
    wheel.setFriction(0);
    wheel.setDensity(0.7);
    //wheel.setBullet(true);
    world.add(wheel);


    FRevoluteJoint gear = new FRevoluteJoint(wheel, body);
    gear.setAnchor(wheel.getX(), wheel.getY());
    gear.setEnableMotor(true);
    gear.setCollideConnected(false);
    gear.setNoFill();
    gear.setNoStroke();
    world.add(gear);
  }
  void b(int x, int y) {
    FBody wheel = new FCircle(25);
    wheel.setPosition(x, y);
    wheel.setFriction(0);
    wheel.setDensity(0.7);
    //wheel.setBullet(true);
    world.add(wheel);
    FBody pin = new FCircle(3);
    pin.setPosition(wheel.getX(), wheel.getY());
    world.add(pin);
    FRevoluteJoint gear = new FRevoluteJoint(pin, wheel);
    gear.setAnchor(wheel.getX(), wheel.getY());
    gear.setEnableMotor(true);
    gear.setCollideConnected(false);
    gear.setNoFill();
    gear.setNoStroke();
    world.add(gear);
    FPrismaticJoint shaft = new FPrismaticJoint(body, pin);
    shaft.setAnchor(pin.getX(), pin.getY());
    shaft.setEnableLimit(true);
    shaft.setAxis(0, 100);
    shaft.setLowerTranslation(0);
    shaft.setUpperTranslation(0);
    shaft.setNoFill();
    shaft.setNoStroke();
    world.add(shaft);
  }

  void a(float x1, float y1, float x2, float y2, int step) {
    int komaCount = 0;  //間に挟む玉の数

    float gearSpeed = 10;  //ギアの速さ
    float torque = 1000000;  //ギアのとるく
    float friction = 2000;

    float overlapping = 1;  //チェーンの重なり具合
    int boxHeight = 4;  //チェーンの太さ
    int r = 34;  //ギア半径
    float tension = PI;  //チェーンの張り具合　適正　3.14
    float theta = atan2((y2-y1), (x2-x1));
    float l =sqrt(sq(x2-x1)+sq(y2-y1))-55;
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
          chain[i][j].setFriction(friction);
          world.add(chain[i][j]);
        } else {
          chain[i][chain[i].length-j-1] = new FBox(boxLength, boxHeight);
          chain[i][chain[i].length-j-1].setPosition(v.x, v.y);
          //chain[i][chain[i].length-j-1].setSensor(true);
          chain[i][chain[i].length-j-1].setRotation(theta);
          chain[i][chain[i].length-j-1].setFriction(friction);
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
            rJoint.setNoFill();
            rJoint.setNoStroke();
            world.add(rJoint);
            //stroke(j*50);
            //line(v.x, v.y, v2.x, v2.y);
          } else if (i==1) {
            FRevoluteJoint rJoint = new FRevoluteJoint(chain[i][chain[i].length-j], chain[i][chain[i].length-j-1]);
            rJoint.setAnchor(v2.x, v2.y);
            rJoint.setCollideConnected(false);
            rJoint.setNoFill();
            rJoint.setNoStroke();
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
    rJoint1.setNoFill();
    rJoint1.setNoStroke();
    world.add(rJoint1);

    chain[1][step-1].setPosition(chain[0][step-1].getX()-boxToBox.x, chain[0][step-1].getY()-boxToBox.y);
    chain[1][step-1].setRotation(PI+theta);
    FRevoluteJoint rJoint2 = new FRevoluteJoint(chain[0][step-1], chain[1][step-1]);
    rJoint2.setAnchor(chain[1][step-1].getX()+boxToBox.x/2, chain[1][step-1].getY()+boxToBox.y/2);
    rJoint2.setCollideConnected(false);
    rJoint2.setNoFill();
    rJoint2.setNoStroke();
    world.add(rJoint2);




    //FBody[] fixGear = new FBody[2];
    for (int i = 0; i < gear.length; i++) {
      gear[i] = new FCircle(25);
      if (i==0) {
        gear[i].setPosition(x1, y1);
      } else {
        gear[i].setPosition(x2, y2);
      }
      gear[i].setFriction(1);
      
      gear[i].setBullet(true);
      
      world.add(gear[i]);
      //fixGear[i] = new FCircle(5);
      //fixGear[i].setPosition(gear[i].getX(), gear[i].getY());
      ////fixGear[i].setStatic(true);
      //world.add(fixGear[i]);
      rJoint[i] = new FRevoluteJoint(body, gear[i]);
      rJoint[i].setAnchor(gear[i].getX(), gear[i].getY());
      rJoint[i].setCollideConnected(false);
      rJoint[i].setEnableMotor(true);
      rJoint[i].setNoStroke();
      rJoint[i].setNoFill();
      if (i==0) {
        //rJoint.setEnableMotor(false);
      }
      rJoint[i].setMotorSpeed(gearSpeed);
      rJoint[i].setMaxMotorTorque(torque);
      world.add(rJoint[i]);
      //FRevoluteJoint rJoint32 = new FRevoluteJoint(body, fixGear[i]);
      //rJoint32.setAnchor(fixGear[i].getX(), fixGear[i].getY());
      //rJoint32.setCollideConnected(false);
      //rJoint32.setEnableMotor(true);
      //world.add(rJoint32);
    }
    gear[1].setDensity(9);
    gear[0].setFriction(1);
    //gear[1].setFill(255, 0, 0);



    for (int i = 1; i <= komaCount; i++) {
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
  void setGunAngle(float theta){
    mainGunJoint.setUpperAngle(theta);
    mainGunJoint.setLowerAngle(theta);
  }
  float getGunAngle(){
    return mainGun.getRotation();
  }
  void fire(){
    float x = mainGunJoint.getAnchorX()+70*cos(getGunAngle());
    float y = mainGunJoint.getAnchorY()+70*sin(getGunAngle());
    bullet = new FCircle(10);
    bullet.setPosition(x,y);
    bullet.addImpulse(10000000*cos(getGunAngle()),100000*sin(getGunAngle()));
    bullet.setDensity(2);
    world.add(bullet);
    body.addImpulse(-100,2500,-80,0);
  }
  void setSpeed(float x){
    rJoint[0].setMotorSpeed(x);
    rJoint[1].setMotorSpeed(x);
  }
  float getBodyX(){
    return body.getX();
    
  }
}
