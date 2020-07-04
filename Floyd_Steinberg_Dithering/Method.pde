color findNearestColor(color col_){
  float bestD = Float.POSITIVE_INFINITY;
  color bestCol = color(0);
  for(color col : colors){
    float dr = red(col_) - red(col);
    float dg = green(col_) - green(col);
    float db = blue(col_) - blue(col);
    float sqD = dr*dr+dg*dg+db*db;
    if(bestD > sqD){
      bestD = sqD;
      bestCol = col;
    }
  }
  return bestCol;
}