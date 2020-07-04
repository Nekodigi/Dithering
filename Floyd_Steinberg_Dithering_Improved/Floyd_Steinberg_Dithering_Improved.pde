// based on these site https://youtu.be/0L2n8Tg2FwI
// https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering

PImage img, errImg, resImg, wdrImg;//original, error, result, without dithering result
PVector[] colors = {v(0, 0, 0), v(255, 0, 0), v(0, 255, 0), v(0, 0, 255), v(255, 255, 0), v(0, 255, 255), v(255, 0, 255), v(255, 255, 255)};
int ceh = 1;//cell height

void setup() {
  size(1000, 1000);
  img = loadImage("USA_Antelope-Canyon Under(PD).jpg");
  img.resize(int(500/ceh), int(500/ceh));
  image(img, 0, 0);
  errImg = img.copy();//to refer image size
  resImg = img.copy();
  wdrImg = img.copy();
}

int imgIndex(int x, int y) {
  return x + y * img.width;
}
int canvIndex(int x, int y) {
  return x + y * width;
}

void draw() {
  //img.loadPixels();
  //loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      PVector oldC = toRGB(errImg.pixels[imgIndex(x, y)]);
      PVector newC = findNearestColor(oldC);
      resImg.pixels[imgIndex(x, y)] = toColor(newC);//set final result

      PVector errC = PVector.sub(oldC, newC);

      int ii = imgIndex(x+1, y);
      PVector c = toRGB(errImg.pixels[ii]);
      c.add(PVector.mult(errC, 7./16));
      errImg.pixels[ii] = toColor(c);

      ii = imgIndex(x-1, y+1);
      c = toRGB(errImg.pixels[ii]);
      c.add(PVector.mult(errC, 3./16));
      errImg.pixels[ii] = toColor(c);

      ii = imgIndex(x, y+1);
      c = toRGB(errImg.pixels[ii]);
      c.add(PVector.mult(errC, 5./16));
      errImg.pixels[ii] = toColor(c);


      ii = imgIndex(x+1, y+1);
      c = toRGB(errImg.pixels[ii]);
      c.add(PVector.mult(errC, 1./16));
      errImg.pixels[ii] = toColor(c);
      
      //example of without dithering
      PVector oldC2 = toRGB(img.pixels[imgIndex(x, y)]);
      PVector newC2 = findNearestColor(oldC2);
      wdrImg.pixels[imgIndex(x, y)] = toColor(newC2);
    }
  }
  //updatePixels();
  //img.updatePixels();
  image(img   , 0      , 0       , width/2, height/2);//original
  image(errImg, width/2, 0       , width/2, height/2);//error
  image(resImg, 0      , height/2, width/2, height/2);//result
  image(wdrImg, width/2, height/2, width/2, height/2);//without dithering
  noLoop();
}
