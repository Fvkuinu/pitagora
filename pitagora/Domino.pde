class Domino {
  Domino(int x, int y, float h, int n) {   
    for (int i = 0; i < n; i++) {
      FBox box = new FBox(10, h);
      if(i==0){
      box.setPosition(x+1, y);
      }else{
        box.setPosition(x+i*(h), y);
      }
      box.setFriction(0.004);
      box.setDensity(14);
      world.add(box);
    }
  }
}
