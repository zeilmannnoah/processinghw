int[] rCounts = new int[256];  // Red bin
int[] gCounts = new int[256];  // Green bin
int[] bCounts = new int[256];  // Blue bin
int posR = 10, posG = 275, posB = 541;
int textX = 50, textY = 75;  // Position for text
String fname = "RRtracks.jpg";
PFont f;
PImage img, simg, eimg, currentImg; //Original, stretched equalized, and current image
boolean showHists = false;  // Boolean to display histograms

void setup() {
  size(400, 400);
  surface.setResizable(true);
  img = loadImage(fname);
  surface.setSize(img.width, img.height);
  currentImg = img;
  strokeWeight(1);  //Lines 1 pixel wide (this is the default)
  f = createFont("Poor Richard", 48);
  textFont(f);  //Set f to be the current font
}

void draw() {
  if (showHists) {
    int edge = 0;  //Reference point for start of histogram
    displayHists();
    fill(255, 255, 0);  //Text color
    if (mouseX >= posR && mouseX < posR + rCounts.length) {
      edge = posR;  //index relative to red hist
    } 
    else if (mouseX >= posG && mouseX < posG + gCounts.length) {
      edge = posG;  //index relative to green hist
    } 
    else if (mouseX >= posB && mouseX < posB + bCounts.length) {
      edge = posB;  //index relative to blue hist
    }

    if (edge > 0) {  //If edge is 0, mouse is not above any hist
      int i = mouseX - edge;
      String s = str(i) + ":  " + str(rCounts[mouseX - edge]);
      text(s, textX, textY);
    }

  } 
  else {
    image(currentImg, 0, 0);
  }
}

void calcHists(PImage img) {
  //Calculate red, green, & blue histograms
  //First initialize rCounts, gCounts, and bCounts to all 0
  for (int i = 0; i < rCounts.length; i++) {
    rCounts[i] = 0; gCounts[i] = 0; bCounts[i] = 0;
  }
    /*For each pixel, get the red, green, and blue values as ints.
    Increment the counts for the red, green, and blue values.
    For example, if the red value is 25, the green value is 110,
    and the blue value is 42, increment rCounts[25], gCounts[110],
    and bCounts[42].
  */
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      int r = int(red(c)), g = int(green(c)), b = int(blue(c));
      rCounts[r] += 1;
      gCounts[g] += 1;
      bCounts[b] += 1;
    }
  }
}

void displayHists() {
  background(0);  //Clear the screen and set to black
  //Put code here to draw histograms
  //First, find max value for scaling; assumes hists are not empty
  int maxval = 0;
  for (int i = 0; i < rCounts.length; i++) {
    if (rCounts[i] > maxval) maxval = rCounts[i];
    if (gCounts[i] > maxval) maxval = gCounts[i];
    if (bCounts[i] > maxval) maxval = bCounts[i];
  }
  //Draw all hists in one loop; this works because all are the same len
  //Use map() to scale line values; scale to height/2
  for (int i = 0; i < rCounts.length; i++) {
    stroke(255, 0, 0);  //Red lines for red hist
    int val = int(map(rCounts[i], 0, maxval, 0, height/2));
    line(i + posR, height, i + posR, height - val);
    stroke(0, 255, 0);  //Green lines for green hist
    val = int(map(gCounts[i], 0, maxval, 0, height/2));
    line(i + posG, height, i + posG, height - val);
    stroke(0, 0, 255);  //Blue lines for blue hist
    val = int(map(bCounts[i], 0, maxval, 0, height/2));
    line(i + posB, height, i + posB, height - val);
  }
}

void printHists() {
  //Use a for (int i...) loop to println i, rCounts[i], gCounts[i], and bCounts[i]
  for (int i = 0; i < rCounts.length; i++) {
    println(i, rCounts[i], gCounts[i], bCounts[i]);
  }
}

PImage equalizeImage(PImage source) {
  PImage target = img.get();
}

void keyReleased() {
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
		// display normal histogram
    calcHists(img);
    showHists = true;
    surface.setSize(posB + bCounts.length, img.height);
	}
  else if (key == 's') {
		// display stretched histogram
    calcHists(simg);
    showHists = true;
    surface.setSize(posB + bCounts.length, simg.height);
	}
  else if (key == 'e') {
		// display equalized histogram
    calcHists(eimg);
    showHists = true;
    surface.setSize(posB + bCounts.length, eimg.height);
}
	}