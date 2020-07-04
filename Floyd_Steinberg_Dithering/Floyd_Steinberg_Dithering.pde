// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Floyd Steinberg Dithering
// Edited Video: https://youtu.be/0L2n8Tg2FwI

PImage img;
color[] colors = {#DDDDDD, #DB7D3E, #B350BC, #6B8AC9, #B1A627, #41AE38, #D08499, #404040, #9AA1A1, #2E6E89, #7E3DB5, #2E388D, #4F321F, #35461B, #963430, #191616};

void setup() {
  size(1500, 500);
  img = loadImage("USA_Antelope-Canyon Under(PD).jpg");
  //img.filter(GRAY);
  img.resize(500, 500);
  image(img, 0, 0);
}

int index(int x, int y) {
  return x + y * img.width;
}
int index2(int x, int y) {
  return x + y * width;
}

void draw() {
  loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      color pix = img.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      //int factor = 1;
      color newColor = findNearestColor(pix);
      pixels[index2(x+width/3*2, y)] = color(newColor);
      float newR = red(newColor);
      float newG = green(newColor);
      float newB = blue(newColor);
      //kitten.pixels[index(x, y)] = newColor;

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;


      int index = index(x+1, y  );
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0;
      g = g + errG * 7/16.0;
      b = b + errB * 7/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x-1, y+1  );
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      img.pixels[index] = color(r, g, b);

      index = index(x, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      img.pixels[index] = color(r, g, b);


      index = index(x+1, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      img.pixels[index] = color(r, g, b);
    }
  }
  updatePixels();
  image(img, width/3, 0);
  noLoop();
}
