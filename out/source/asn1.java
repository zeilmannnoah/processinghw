import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class asn1 extends PApplet {

String fileName = "";
PImage img, currentImg, eImg, sImg;
int[] rCounts = new int[256];
int[] gCounts = new int[256];
int[] bCounts = new int[256];
int posR, posG, posB;
boolean showHists = false;

public void setup() {
  int third = (img.width - 20)/3;
  
  surface.setResizable(true);
  img = loadImage(fileName);
  currentImg = img;
  surface.setSize(img.width, img.height);
  posB = img.width - third;
  posG = posB - third;
  posR = posG - third;
  calcHists(img);
}

public void draw() {
  if (showHists) {

  }
  else {
    image(currentImg, 0, 0);
  }
}

public void calcHists(PImage img) {
  background(0);

  int maxVal = 0;
  for (int i = 0; i < rCounts.length; i++) {
    if (rCounts[i] > maxVal) {
      maxVal = rCounts[i];
    }
    if (gCounts[i] > maxVal) {
      maxVal = gCounts[i];
    }
    if (bCounts[i] > maxVal) {
      maxVal = bCounts[i];
    }
  }
  
  for (int i = 0; i < rCounts.length; i++) {
    stroke(255, 0, 0); // Red
    int val = PApplet.parseInt(map(rCounts[i], 0, maxVal, 0, height/2));
    line(i + posR, height, i + posR, height - val); 

    stroke(0, 255, 0);  // Green 
    val = PApplet.parseInt(map(gCounts[i], 0, maxVal, 0, height/2));
    line(i + posG, height, i + posG, height - val);
    stroke(0, 0, 255);  // Blue

    val = PApplet.parseInt(map(bCounts[i], 0, maxVal, 0, height/2));
    line(i + posB, height, i + posB, height - val);
  }
}

public void keyReleased() {
	if (key == '1') {
		currentImg = img;
    showHists = false;
    surface.setSize(currentImg.width, currentImg.height);
	} 
  else if (key == '2') {
		// display stretched image
    showHists = false;
	}
  else if (key == '3') {
		// display equalized image
    showHists = false;
	}
  else if (key == 'h') {
		// display equalized histogram
    showHists = true;
	}
  else if (key == 's') {
		// display equalized histogram
    showHists = true;
	}
  else if (key == 'e') {
		// display equalized histogram
    showHists = true;
	}
}
  public void settings() {  size(200, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "asn1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
