PVector toRGB(color col){//use xyz as rgb
  return new PVector(red(col), green(col), blue(col));
}

color toColor(PVector col){
  return color(col.x, col.y, col.z);
}

PVector v(float r, float g, float b){
  return new PVector(r, g, b);
}
