PImage bgImg, soilImg, lifeImg, soldierImg;
PImage cabbage, title, gameover;
PImage startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;

float block = 80;
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

float moveX, moveY;

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
  soldierY = block*floor(random(2,6));
  cabbageX = block*floor(random(0,8));
  cabbageY = block*floor(random(2,5));
  gameState = GAME_START;
  groundhogX = 4*block;
  groundhogY = block;
  groundhogX2 = groundhogX;
  groundhogY2 = groundhogY;

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


      break;
     
    //Game Run  
    case GAME_RUN:

    image(bgImg,0,0);
    image(soilImg,0,block*2);
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
    image(soldierImg, soldierX-block, soldierY);
    
    // Groundhog
    
    if(downPressed){
      if(moveY < groundhogY){
        image( groundhogDown, groundhogX, moveY);
        moveY += floor(80/15);
      }else{
        downPressed = false;
      }
    }else if(leftPressed){      
            if(moveX > groundhogX){
            image( groundhogLeft, moveX, groundhogY);
            moveX -= floor(block/15);
            }else{
              leftPressed = false;
            }
    }else if(rightPressed){
            if(moveX < groundhogX){
            image( groundhogRight, moveX, groundhogY);
            moveX += floor(block/15);
            }else{
              rightPressed = false;
            }
    }else{
      image(groundhogIdle, groundhogX, groundhogY);
    }
    
    
    
    
    // Hit Soldier Detection
    if(soldierX>groundhogX && soldierX-block<groundhogX+block){
      if(soldierY+block>groundhogY && soldierY<groundhogY+block){
        groundhogX = 4*block;
        groundhogY = block;
        lifeCount -= 1;
      }
    }
    
    // Eat Cabbage Detection
    image(cabbage, cabbageX, cabbageY);
    if(cabbageX+block>groundhogX && cabbageX<groundhogX+block){
      if(cabbageY+block>groundhogY && cabbageY<groundhogY+block){
        cabbageY = 600;
        lifeCount += 1;
      }
    }
    
    // Life Count
    if(lifeCount == 0){
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
         if(mousePressed){
           // reset
           lifeCount = 2;
           soldierY = block*floor(random(2,6));
           cabbageX = block*floor(random(0,8));
           cabbageY = block*floor(random(2,5));  
           groundhogX = block*4;
           groundhogY = block;
           gameState = GAME_RUN;
         }else{
           //hover
           image(restartHovered, 248, 360);         
         }
       }
       break;
  }
}

void keyPressed(){
    if( !leftPressed && !rightPressed && !downPressed){   
    if(key == CODED){
      switch (keyCode){
        
        case DOWN:  
          moveY = groundhogY;
          if(moveY < height-block){ 
            downPressed = true;          
            groundhogY += block;
            println(moveX,moveY);
            println(groundhogX,groundhogY);
          }
          
        
           break;
           
        case LEFT:
        moveX = groundhogX;
        if(moveX > 0){
          leftPressed = true;
          groundhogX -= block;
          println(moveX,moveY);
          println(groundhogX,groundhogY);
        }
          break;
          
        case RIGHT:
        moveX = groundhogX;
        if(moveX < width-block){
          rightPressed = true;
          groundhogX += block;
          println(moveX,moveY);
          println(groundhogX,groundhogY);
        }
  
          break;
      }
    }
  }
}


void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case DOWN:

      break;
      
      case LEFT:
      
      break;
      
      case RIGHT:
      
      break;
  
    }
  }
}
