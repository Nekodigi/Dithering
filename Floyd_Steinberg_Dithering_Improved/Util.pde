PVector findNearestColor(PVector target){
  float bestD = Float.POSITIVE_INFINITY;
  PVector result = new PVector();
  for(PVector col : colors){
    float sqD = PVector.dist(target, col);
    if(bestD > sqD){
      bestD = sqD;
      result = col;
    }
  }
  return result;
}
