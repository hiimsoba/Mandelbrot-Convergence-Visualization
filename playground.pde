final int divisions = 4;
final float value = 1.5;
final float maxX = value;
final float minX = -value;
final float maxY = value;
final float minY = -value;

final int iterations = 1000;

void setup() {
  size(640, 640);
  smooth(102400);
}

PVector firstPoint = new PVector();

void draw() {
  background(255);
  plotAxes();
  stroke(0);
  noFill();
  ellipse(xToCartesian(0), yToCartesian(0), (xToCartesian(1) - xToCartesian(0)) * 2, (yToCartesian(1) - yToCartesian(0)) * 2);
  fill(0);

  ArrayList<PVector> points = new ArrayList<PVector> ();

  PVector c = new PVector(cartesianToX(mouseX), cartesianToY(mouseY));

  //points.add(new PVector(cartesianToX(mouseX), cartesianToY(mouseY)));
  points.add(firstPoint);

  for (int i = 0; i < iterations; i++) {
    PVector curr = square(points.get(points.size() - 1)).add(c);
    if (Float.isNaN(curr.x) || Float.isNaN(curr.y)) {
      break;
    }
    points.add(curr);
  }

  // draw the first point separately
  fill(200);
  stroke(255, 0, 0);
  ellipse(xToCartesian(points.get(0).x), yToCartesian(points.get(0).y), 4, 4);

  stroke(0);
  for (int i = 1; i < points.size(); i++) {
    ellipse(xToCartesian(points.get(i).x), yToCartesian(points.get(i).y), 3, 3);
    line(xToCartesian(points.get(i).x), yToCartesian(points.get(i).y), xToCartesian(points.get(i - 1).x), yToCartesian(points.get(i - 1).y));
  }
}

PVector square(PVector p) {
  return new PVector(p.x * p.x - p.y * p.y, 2 * p.x * p.y);
}

void plotAxes() {
  stroke(0);
  line(0, yToCartesian(0), width, yToCartesian(0));
  line(xToCartesian(0), 0, xToCartesian(0), height);

  textSize(12);
  fill(0);

  textAlign(RIGHT, TOP);
  text(0, xToCartesian(0), yToCartesian(0));

  textAlign(LEFT, TOP);
  text(nf(minX), xToCartesian(minX), yToCartesian(0));

  textAlign(RIGHT, TOP);
  text(nf(maxX), xToCartesian(maxX), yToCartesian(0));

  textAlign(RIGHT, BOTTOM);
  text(nf(minY), xToCartesian(0), yToCartesian(minY));

  textAlign(RIGHT, TOP);
  text(nf(maxY), xToCartesian(0), yToCartesian(maxY));

  float xDivision = (abs(minX) + abs(maxX)) / divisions;
  float yDivision = (abs(minY) + abs(maxY)) / divisions;

  noStroke();
  fill(0);

  for (int i = 1; i < divisions; i++) {
    if (!nf(minX + i * xDivision).equals("0")) {
      textAlign(CENTER, TOP);
      text(nf(minX + i * xDivision), xToCartesian(minX + i * xDivision), yToCartesian(0));
    }
    if (!nf(minY + i * yDivision).equals("0")) {
      textAlign(RIGHT, CENTER);
      text(nf(minY + i * yDivision), xToCartesian(0), yToCartesian(minY + i * yDivision));
    }
  }
}

// to move around the first point
void mousePressed() {
  firstPoint.x = cartesianToX(mouseX);
  firstPoint.y = cartesianToY(mouseY);
}

void mouseDragged() {
  firstPoint.x = cartesianToX(mouseX);
  firstPoint.y = cartesianToY(mouseY);
}

float xToCartesian(float x) {
  return map(x, minX, maxX, 0, width);
}

float yToCartesian(float y) {
  return map(y, maxY, minY, 0, height);
}

float cartesianToX(float x) {
  return map(x, 0, width, minX, maxX);
}

float cartesianToY(float y) {
  return map(y, 0, height, maxY, minY);
}
