void particle(int x, int y){
  for (int i = 0; i<2; i++) {
    float a = random(5,10);
    FBody l = new FBox(a,a);
    l.setPosition(x,y);
    l.setVelocity(400*random(-5,5),600*-random(1,2));
    l.setNoStroke();
    //l.setSensor(true);
    //l.setSensor(true);
    //l.setStrokeWeight(2);
    l.setFill(150+random(0,100),150+random(0,100),150+random(0,100));
    world2.add(l);
  }
  ArrayList<FBody> bodies = world2.getBodies();
  for (FBody b : bodies) {
    if (b.getName()==null) continue;
    if (b.getName().equals("ppp")) {
      if (b.getY()>200) {
        world2.remove(b);
      }
      if(b.getY()<-800){
        world2.remove(b);
      }
      if(b.getX()<4589){
        world2.remove(b);
      }
      if(b.getX()>5830){
        world2.remove(b);
      }
    }
  }
}
