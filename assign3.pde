final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;      
final int HOG_STAND = 3, HOG_RUN = 4;
final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int LIFE_W = 50;
final int LIFE_GAP = 20;
final int BLOCK = 80;

int gameState = 0;
int hogState = 3;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24;
PImage life,soil0,soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;
PImage groundhogLeft, groundhogRight, groundhogDown, groundhogIdle;

float groundhogX= BLOCK*4, groundhogY= BLOCK;
float moveX, moveY;

float slide = 0;
float slideY = 0;
boolean camera = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;


// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
  life = loadImage("img/life.png");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");  
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

    // Move Before 20th BLOCKs
    if (camera) {
      pushMatrix();
      if(slideY>=slide){
        slideY-=floor(BLOCK/15);
      } 
    }
     translate(0,slideY+5);  // each "new draw" needs "new tanslate" 


		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
      // soil0
      for(int j=2; j<6; j++){
        for(int i=0; i<8; i++){
         image(soil0,BLOCK*i,BLOCK*j);
        }
      }
      // soil1
      for(int j=6; j<10; j++){
        for(int i=0; i<8; i++){
         image(soil1,BLOCK*i,BLOCK*j);
        }
      }
      // soil2
      for(int j=10; j<14; j++){
        for(int i=0; i<8; i++){
         image(soil2,BLOCK*i,BLOCK*j);
        }
      }
      // soil3
      for(int j=14; j<18; j++){
        for(int i=0; i<8; i++){
         image(soil3,BLOCK*i,BLOCK*j);
        }
      }
      // soil4
      for(int j=18; j<22; j++){
        for(int i=0; i<8; i++){
         image(soil4,BLOCK*i,BLOCK*j);
        }
      }
      // soil5
      for(int j=22; j<26; j++){
        for(int i=0; i<8; i++){
         image(soil5, BLOCK*i, BLOCK*j);
        }
      }
      // stone 1~8
      for(int i=0; i<8; i++){
        for(int j=2; j<10; j++){
          if(i+2 == j){
           image(stone1, BLOCK*i, BLOCK*j);
          }
        }
      }
      
      // stone 9~16
      for(int i=0; i<=9; i++){
        for(int j=10; j<18; j++){
          if(i%4 == 1 || i%4 ==2){
            
            if(j%4 == 1 || j%4 ==2){
              image(stone1, BLOCK*i, BLOCK*j);
            }else if(j%4 == 0 || j%4 == 3){
              image(stone1, BLOCK*i-BLOCK*2, BLOCK*j);
            }
            
          }
        }
      }
      
      // stone 17~24
      for(int i=0; i<=9; i++){
        for(int j=18; j<26; j++){
          //stone1
          if(i%3 == 1 || i%3 == 2){
           
            if(j%3 == 0){
             image(stone1, BLOCK*i, BLOCK*j);
            }else if(j%3 == 1){
             image(stone1, BLOCK*i-BLOCK, BLOCK*j);
            }else{
             image(stone1, BLOCK*i-BLOCK*2, BLOCK*j);
            }
           
          }
          //stone2
          if(i%3 == 2){
            
            if(j%3 ==0){
              image(stone2, BLOCK*i, BLOCK*j);
            }else if(j%3 ==1){
              image(stone2, BLOCK*i-BLOCK, BLOCK*j);
            }else{
              image(stone2, BLOCK*i-BLOCK*2, BLOCK*j);
            }
            
          }
          
        }
      }
      
    // translate  
    if (camera) {
      popMatrix();
    }
      
      
      
		// Player
    switch ( hogState ) {
      case HOG_STAND:      
      if(downPressed){
        if(slideY > slide){
          image(groundhogDown, groundhogX, groundhogY);
          }else{
            downPressed = false;
          }
      }else if(leftPressed){      
        if(moveX > groundhogX){
          image( groundhogLeft, moveX, groundhogY);
          moveX -= floor(BLOCK/15);
        }else{
          leftPressed = false;
        }
      }else if(rightPressed){
        if(moveX < groundhogX){
          image( groundhogRight, moveX, groundhogY);
          moveX += floor(BLOCK/15);
        }else{
          rightPressed = false;
        }
      }else{
        image(groundhogIdle, groundhogX, groundhogY);
      }
      
      break;
    
      
      case HOG_RUN:
      if(downPressed){       
        if(groundhogY < height){
          if(moveY < groundhogY){
            image( groundhogDown, groundhogX, moveY);
            moveY += floor(80/15);  
          }else{            
            downPressed = false;
          }
        }
      }else if(leftPressed){      
              if(moveX > groundhogX){
              image( groundhogLeft, moveX, groundhogY);
              moveX -= floor(BLOCK/15);
              }else{
                leftPressed = false;
              }
      }else if(rightPressed){
              if(moveX < groundhogX){
              image( groundhogRight, moveX, groundhogY);
              moveX += floor(BLOCK/15);
              }else{
                rightPressed = false;
              }
      }else{
        image(groundhogIdle, groundhogX, groundhogY);
      }
      break;
      
    }


		// Health UI
    for(int i=0; i<playerHealth; i++){
      image(life, 10+(LIFE_W+LIFE_GAP)*i, 10);
    }
		break;


		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
    if(key == CODED){
      switch(keyCode){
        case DOWN:
          downPressed = true;                 
          camera = true;
          moveY = groundhogY;
          slideY = slide;        
        if(slide > BLOCK*(-20)){ // boundary            
          slide-=BLOCK;
          hogState = HOG_STAND;
        }else{
          hogState = HOG_RUN;
          if(moveY < height-BLOCK){
            groundhogY +=BLOCK;
          }       
        }

        break;
        
        case LEFT:
        moveX = groundhogX;
        if(moveX > 0){ // boundary
          leftPressed = true;
          groundhogX -= BLOCK;
        }
        break;
        
        case RIGHT:
        moveX = groundhogX;
        if(moveX < width-BLOCK){ // boundary
          rightPressed = true;
          groundhogX += BLOCK;
        }
        break;
      }
    }
  
    
    
    	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
