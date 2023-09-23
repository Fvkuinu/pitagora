void liquid(float x, float y){
  for (int i = 0; i<2; i++) {
    FCircle l = new FCircle(5);
    l.setFriction(0);
    l.setRestitution(0.8);
    l.setDensity(1);
    l.setPosition(x,y);
    l.setName("ryusi");
    l.setVelocity(200,10);
    l.setStroke(0,0,100);
    l.setStrokeWeight(2);
    l.setFill(0,0,100);
    world.add(l);
  }
  ArrayList<FBody> bodies = world.getBodies();
  for (FBody b : bodies) {
    if (b.getName()==null) continue;
    if (b.getName().equals("ryusi")) {
      if (b.getY()>height) {
        world.remove(b);
      }
      if (b.getX()<x-5) {
        world.remove(b);
      }
      if (b.getX()>2930) {
        world.remove(b);
      }
    }
  }
}
