class Kanransha {
  Kanransha(float x, float y) {
    FBody c = new FCircle(50);
    c.setPosition(0, 0);
    c.setFriction(4);
    //world.add(c);
    FCompound c1 = new FCompound();
    int n = 6;
    float len = 200;
    for (int i = 1; i <= n; i++) {
      FBox b = new FBox(len, 10);
      float theta = radians((360/n)*i);    
      b.setPosition(len/2*cos(theta), len/2*sin(theta));
      b.setRotation(theta);
      b.setSensor(true);
      c1.addBody(b);
    }
    c1.addBody(c);
    c1.setPosition(x, y);  
    world.add(c1);
    println(c1.getX(), c1.getY());
    for (int i = 1; i<=n; i++) {
      float theta = radians(1.0*(360/n)*i);
      FCircle c2 = new FCircle(20);
      c2.setPosition(0, 0);
      FBox b1 = new FBox(20, 10);
      b1.setPosition(0, 15);
      b1.setRotation(PI/2);
      FPoly p2 = new FPoly();
      p2.vertex(-5, 35-10);
      p2.vertex(5, 35-10);
      p2.vertex(-5, 45-10);
      p2.vertex(-15, 55-10);
      p2.vertex(-25, 55-10);
      p2.vertex(-35, 45-10);
      p2.vertex(-35, 35-10);
      p2.vertex(-25, 45-10);
      p2.vertex(-15, 45-10);
      FPoly p1 = new FPoly();
      p1.vertex(-35-10, 35-10);
      p1.vertex(-25-10, 35-10);
      p1.vertex(-25-10, 45-10);
      FCompound cc = new FCompound();
      cc.addBody(p1);
      cc.addBody(p2);
      cc.addBody(b1);
      cc.addBody(c2);
      cc.setPosition(c1.getX()+len*cos(theta), c1.getY()+len*sin(theta));
      cc.setDensity(10);
      cc.setRestitution(0);
      cc.setFriction(0);
      cc.setAngularDamping(5);
      world.add(cc);
      FRevoluteJoint j2 = new FRevoluteJoint(c1, cc);
      j2.setAnchor(cc.getX(), cc.getY());
      j2.setCollideConnected(false);
      j2.setEnableLimit(false);
      j2.setLowerAngle(-PI/3);
      j2.setUpperAngle(PI/3);
      j2.setNoStroke();
      j2.setNoFill();
      world.add(j2);
    }
    FCircle g1 = new FCircle(10);
    g1.setPosition(c1.getX(), c1.getY());
    g1.setStatic(true);
    world.add(g1);
    FRevoluteJoint j1 = new FRevoluteJoint(g1, c1);
    j1.setAnchor(g1.getX(), g1.getY());
    j1.setEnableMotor(true);
    j1.setMotorSpeed(0.4);
    j1.setMaxMotorTorque(100000000);
    j1.setNoStroke();
    j1.setNoFill();
    world.add(j1);
  }
}
