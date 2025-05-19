import processing.serial.*;
Serial myPort;

int lastUpdateTime = 0;
int updateInterval = 300;

int savedAngle = 0;
int savedDistance = 0;

String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PImage flightIcon;

void setup() {
  size(1200, 700);
  smooth();
  myPort = new Serial(this, "COM10", 9600);
  myPort.bufferUntil('.');
  flightIcon = loadImage("plane.png");
  flightIcon.resize(60, 60);
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);

  fill(98, 245, 31);
  noStroke();

  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void drawObject() {
  if (millis() - lastUpdateTime > updateInterval && iDistance >= 5 && iDistance <= 40) {
    savedAngle = iAngle;
    savedDistance = iDistance;
    lastUpdateTime = millis();
  }

  if (savedDistance >= 5 && savedDistance <= 40) {
    pushMatrix();
    translate(width / 2, height - height * 0.074);
    pixsDistance = savedDistance * ((height - height * 0.1666) * 0.025);

    float scaleFactor = 2.0;
    float x = pixsDistance * cos(radians(savedAngle)) - (flightIcon.width * scaleFactor) / 2;
    float y = -pixsDistance * sin(radians(savedAngle)) - (flightIcon.height * scaleFactor) / 2;

    tint(255, 200);
    image(flightIcon, x, y, flightIcon.width * scaleFactor, flightIcon.height * scaleFactor);
    noTint();
    popMatrix();
  }
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  if (data != null && data.contains(",")) {
    data = data.substring(0, data.length() - 1);
    index1 = data.indexOf(",");
    angle = data.substring(0, index1);
    distance = data.substring(index1 + 1);
    iAngle = int(angle);
    iDistance = int(distance);
  }
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  arc(0, 0, width * 0.9375, width * 0.9375, PI, TWO_PI);
  arc(0, 0, width * 0.73, width * 0.73, PI, TWO_PI);
  arc(0, 0, width * 0.521, width * 0.521, PI, TWO_PI);
  arc(0, 0, width * 0.313, width * 0.313, PI, TWO_PI);

  line(-width / 2, 0, width / 2, 0);
  for (int a = 30; a <= 150; a += 30) {
    line(0, 0, (-width / 2) * cos(radians(a)), (-width / 2) * sin(radians(a)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.074);
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  if (iDistance < 5 || iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }

  fill(0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);

  textSize(45);
  textAlign(CENTER);
  text("OP SINDOOR - Radra System", width / 2, 50);

  textSize(35);
  textAlign(LEFT);
  text("Angle: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
  text("Distance: " + ((iDistance >= 5 && iDistance <= 40) ? iDistance + " cm" : "---"), width - width * 0.26, height - height * 0.0277);

  // Red alert text when enemy spotted
  if (iDistance >= 5 && iDistance <= 40) {
    fill(255, 0, 0); // Red color
    textSize(50);
    textAlign(CENTER);
    text("ENEMY SPOTTED!", width / 2, height / 2 - 100);
  }

  // Angle markers
  textSize(25);
  fill(98, 245, 60);
  String[] angles = {"30°", "60°", "90°", "120°", "150°"};
  int[] deg = {30, 60, 90, 120, 150};
  for (int i = 0; i < angles.length; i++) {
    float angleRad = radians(deg[i]);
    float x = (width / 2) + (width / 2 - 100) * cos(angleRad);
    float y = (height - height * 0.074) - (width / 2 - 100) * sin(angleRad);
    text(angles[i], x, y);
  }
  popMatrix();
}
