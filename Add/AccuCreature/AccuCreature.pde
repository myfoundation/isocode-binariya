float inc = 0.0, posx = 240, posy = 240, dx = 0, dy = 0, angle3 = 0.0;
boolean food = false;
int foodiam = 0, fadestroke;
float anglefood;

float a1 = 0.012,
      a2 = 0.001,
      a3 = 0.002,
      a4 = 0.003,
      a5 = 0.0025,
      a6 = 0.0034,
      a7 = 0.014,
      a8 = 0.0028;
      
float rot1, rot2, rot3, rot4, rot5, rot6, rot7, rot8;

float easing = 0.05, foff = 0.975, targetY, targetX;

void setup()
{
  targetX = random(width); targetY = random(height);
  size(600, 400); smooth(); frameRate(30); rectMode(CENTER);
}

void draw()
{
  noStroke();
  fill(225, 75, 0); rect(width / 2, height / 8, width, height / 4);
  fill(200, 50, 0); rect(width / 2, height / 8 * 3, width, height / 4);
  fill(155, 0, 35); rect(width / 2, height / 8 * 5, width, height / 4);
  fill(100, 0, 25); rect(width / 2, height / 8 * 7, width, height / 4);
  
  if (food == true) createFood(targetX, targetY);

  if (dist(targetX, targetY, posx, posy) < 20)
  {
    targetX = random(width); targetY = random(height);
    foodiam = 10; fadestroke = 255; food = true;
  }

  inc += 0.006;
  float angle1 = sin(inc) / 10.0 + sin(inc * 4.5) / 70.0,
        angle2 = cos(inc) / 12.0 + cos(inc * 4.5) / 80.0;

  angle3 += 0.007;
  float d = dist(targetX, targetY, posx, posy); 
  dx = (dx + (targetX - posx) / d * easing) * foff;
  dy = (dy + (targetY - posy) / d * easing) * foff;
  posx += dx; posy += dy;
  
  stroke(0);
  translate(posx, posy);           tail(0, 24, angle1*4);
  rotate(sin(rot1) + QUARTER_PI);  tail(0, 21, angle1 * 2.7);
  rotate(cos(rot2) + QUARTER_PI);  tail(0, 18, angle2 * 5.5);
  rotate(rot3 + QUARTER_PI);       tail(0, 17, angle1 * 3);
  rotate(sin(rot4 + QUARTER_PI));  tail(0, 19, angle2 * 4.2);
  rotate(atan(rot5) + QUARTER_PI); tail(0, 20, angle1 * 2.4);
  rotate(sin(rot6) + QUARTER_PI);  tail(0, 24, angle2 * 3);
  rotate(cos(rot7) + QUARTER_PI);  tail(0, 25, angle1 * 3.2);
  rot1 += a1;
  rot2 += a2;
  rot3 += a3;
  rot4 += a4;
  rot5 += a5;
  rot6 += a6;
  rot7 += a7;
  rot8 += a8;
}

void tail(int x, int units, float angle)
{
  float f, d;
  pushMatrix(); translate(x, 0);
  for (int i = units; i > 0; i--)
  { f = 1.5 + sqrt((float)i / 20);
    stroke(0); strokeWeight(0.5);      drawLine(-i, 0, i, 0);
    d = (float)(height - posy) / height;
    fill(255, 100 + d * 155, d * 255); drawCirc(-i, 0, f);  drawCirc(i, 0, f);
    strokeWeight(i / 1.7);             drawLine(0, 0, 0, -8);
    fill(0); noStroke();               drawCirc(0, 0, i / 1.25);
    fill(155 * d, 0, d * 35);          drawCirc(0, 0, i / 5);
    translate(0, -10);
    rotate(angle);
  }
  popMatrix();
}

void mousePressed()
{
  targetX = mouseX; targetY = mouseY;
  foodiam = 10; fadestroke = 255; food = true;
}

void createFood(float locationX, float locationY)
{
  noStroke(); fill(0);    drawCirc(locationX, locationY, 3 + abs(cos(anglefood) * 3));
  noFill(); stroke(0,80); drawCirc(locationX, locationY, 10 + abs(cos(anglefood + QUARTER_PI) * 3));
  if (foodiam < 220)
  { noFill(); stroke(0, fadestroke); drawCirc(locationX, locationY, foodiam);
    foodiam++; fadestroke-=2;
  }
  anglefood += map(dist(targetX, targetY, posx, posy), 0, 300, 0.2, 0.01);
}

