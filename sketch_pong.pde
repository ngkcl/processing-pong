final int BACKGROUND_COLOR = 0;

final float PADDLE_SIZE_X = 15;
final float PADDLE_SIZE_Y = 150;
final float PADDLE_DIST_WALL = 5;

final float BALL_DIAMETER = 14;

float ball_x, ball_y;
float ball_speed_x, ball_speed_y;

float opp_y;
float opp_speed;

float score = 0;
float lives = 3;

PFont main_font;

void setup() {
    size(700, 700);
    background(0, 0, 0);
    
    main_font = createFont("Arial", 16, true);
    fill(255);
    textFont(main_font, 30);
    
    reset_ball();
    reset_enemy();
}

void reset_ball() {
   ball_x = width/2;
   ball_y = height/2;
   ball_speed_x = random(3,5);
   ball_speed_y = random(3,5);
}

void reset_enemy() {
   opp_y = width/2 - PADDLE_SIZE_Y/2;
   opp_speed = 3.3;
}

void draw() {
  // Reset background
  background(BACKGROUND_COLOR);
  
  // Show score
  textAlign(LEFT);
  text("Score: " + (int) score, 30, 35);
  
  // Show lives
  textAlign(RIGHT);
  text("Lives: " + (int) lives, width-30, 35);
  
  // Player:
  rect(width - (PADDLE_SIZE_X + PADDLE_DIST_WALL), mouseY - PADDLE_SIZE_Y/2, PADDLE_SIZE_X, PADDLE_SIZE_Y);
  
  // Ball:
  ellipse(ball_x, ball_y, BALL_DIAMETER, BALL_DIAMETER); 
  
  // Enemy:
  rect(5, opp_y, PADDLE_SIZE_X, PADDLE_SIZE_Y);
  opp_y += opp_speed;
  
  // BALL ----------------------------------
  ball_x += ball_speed_x;
  ball_y += ball_speed_y;
  
  // if ball hits the top walls
  if (ball_y >= height || ball_y <= 0) {
    // add randomness:
    float chaos = random(-0.1, 0.1);
    ball_speed_y *= (-1 + chaos);
    println("speedY: " + ball_speed_y);
  }
  
  // if ball hits side walls
  if (ball_x <= 0 || ball_x >= width) {
    // add randomness:
    float chaos = random(-0.1, 0.1);
    ball_speed_x *= (-1 + chaos);
    println("speedX: " + ball_speed_x);
    if (ball_x <= 0) score += 1;
    if (ball_x >= width) {
       lives -= 1;
       reset_ball();
       
       if (lives <= 0) {
          //TODO: GAME OVER 
       }
    }
  }
  
  // if ball hits player
  if (ball_x > (width - (PADDLE_SIZE_X + PADDLE_DIST_WALL)) && ball_x < (width - PADDLE_DIST_WALL) && ball_y > (mouseY - PADDLE_SIZE_Y/2) && ball_y < (mouseY + PADDLE_SIZE_Y/2)) {
    float chaos = random(-0.2, 0.2);
    ball_speed_x *= (-1 + chaos);
    println("speedX: " + ball_speed_x);
  }
  
  // if ball hits enemy
  if (ball_x > PADDLE_DIST_WALL && ball_x < (PADDLE_SIZE_X + PADDLE_DIST_WALL) && ball_y > opp_y && ball_y < (opp_y + PADDLE_SIZE_Y)) {
    float chaos = random(-0.1, 0.1);
    ball_speed_x *= (-1 + chaos);
    println("speedX: " + ball_speed_x);
  }
  // ========================================
  
  // ENEMY ----------------------------------
  
  // Checks if paddle is near edges
  Boolean near_edge = (opp_y >= height - PADDLE_SIZE_Y - 15 || opp_y <= 15);
  
  // y-distance between ball and center of paddle
  float y_distance = (opp_y + PADDLE_SIZE_Y/2) - ball_y;
  
  if (opp_y >= height - PADDLE_SIZE_Y || opp_y <= 0) {
        opp_speed *= -1;
  } else if (y_distance > 30 && opp_speed > 0 && !near_edge) {
    opp_speed *= -1;
  } else if (y_distance < -30 && opp_speed < 0 && !near_edge) { 
    opp_speed *= -1;
  }
  
  println(y_distance > 0 );
  
  // ========================================
  
}
