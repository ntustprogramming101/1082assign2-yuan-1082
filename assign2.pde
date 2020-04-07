PImage bgImg, soilImg, lifeImg, soldierImg;
PImage cabbage, title, gameover;
PImage startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;

float layer = 80;
float soldierX, soldierY; 
float cabbageX, cabbageY;
float speedX, speedY;
float groundhogX, groundhogY;
float groundhogX2, groundhogY2;

int life1 = 10;
int life2 = 80;
int life3 = 150;
int loseLife = -100;
int lifeCount = 2 ;

int vertical = 1;
int horizon = 4;
float move = 0;

int gameState;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
  size(640, 480, P2D);
  
  
  //load images
  bgImg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  lifeImg = loadImage("img/life.png");
  soilImg = loadImage("img/soil.png");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  soldierImg = loadImage("img/soldier.png");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  //soldierX = -soldierWidth;
  soldierY = layer*floor(random(2,6));
  cabbageX = layer*floor(random(0,8));
  cabbageY = layer*floor(random(2,5));
  gameState = GAME_START;
  groundhogX = 4*layer;
  groundhogY = layer;
  groundhogX2 = groundhogX;
  groundhogY2 = groundhogY;
  
  frameRate(25);

}

void draw() {
  image(title, 0, 0);
  image(startNormal, 248, 360);
  // Switch Game State
  switch(gameState){
    
    // Game Start
    case GAME_START:

      //mouse action
      if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
        if(mousePressed){
          //click
          gameState = GAME_RUN;
        }else{
          //hover
          image(startHovered, 248, 360);
        }
      }
      
      //reset

      soldierY = layer*floor(random(2,6));
      cabbageX = layer*floor(random(0,8));
      cabbageY = layer*floor(random(2,5));

      break;
     
    //Game Run  
    case GAME_RUN:

    image(bgImg,0,0);
    image(soilImg,0,layer*2);
    image(lifeImg,life1,10);
    image(lifeImg,life2,10);
    
    // Grass
    noStroke();
    fill(124,204,25);
    rect(0,145,640,15);
    
    // Sun
    fill(255,255,0);
    ellipse(590,50,130,130);
    fill(253,184,19);
    ellipse(590,50,120,120);
    
    // Soldier
    soldierX += 5;
    soldierX %= -720;
    image(soldierImg, soldierX-layer, soldierY);
    
    // Groundhog
    image(groundhogIdle, groundhogX, groundhogY);
  
    // Hit Soldier Detection
    if(soldierX>groundhogX && soldierX-layer<groundhogX+layer){
      if(soldierY+layer>groundhogY && soldierY<groundhogY+layer){
        vertical = 1;
        horizon = 4;
        groundhogX = 4*layer;
        groundhogY = layer;
        lifeCount -= 1;
      }
    }
    
    // Eat Cabbage Detection
    image(cabbage, cabbageX, cabbageY);
    if(cabbageX+layer>groundhogX && cabbageX<groundhogX+layer){
      if(cabbageY+layer>groundhogY && cabbageY<groundhogY+layer){
        cabbageY = 600;
        lifeCount += 1;
      }
    }
    
    // Life Count
    if(lifeCount == 0){
      groundhogX = 4*layer;
      groundhogY = layer;
      gameState = GAME_OVER; 
    }
    if(lifeCount == 1){
      life2 = loseLife;
      life3 = loseLife;
    }
    if(lifeCount == 2){
      life2 = 80;
      life3 = loseLife;
    }
    if(lifeCount == 3){
      life2 = 80;
      life3 = 150;
      image(lifeImg,life3,10);
    }
    break;
  
       
		// Game Lose
     case GAME_OVER:
       image(gameover, 0, 0);
       image(restartNormal, 248, 360);
       //mouse action
       if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
           //hover
           image(restartHovered, 248, 360);         
       }
       break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      case UP:
        break;
        
      case DOWN:
      groundhogY += layer;
      if(groundhogY >= height-layer){
        groundhogY = height-layer;
      }     
         break;
         
      case LEFT:
      groundhogX -= layer;
      if(groundhogX <= 0){
        groundhogX = 0;
      }      
        break;
        
      case RIGHT:   
      groundhogX += layer;
      if(groundhogX >= width-layer){
        groundhogX = width-layer;
      }
        break;
    }
  }
}

void mouseClicked(){
  // game over to start 
  if(gameState == GAME_OVER){
    if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
      lifeCount = 2;
      gameState = GAME_START;
    }
  }
}
