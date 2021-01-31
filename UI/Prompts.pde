// in second page, 
void prompt1(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  background(0);
  fill(255);
  noStroke();
  textFont(font);
  text("Watch a Demo First!",width/5,height/2.5);
  
  fill(240,80);
  noStroke();
  textFont(font2);
  text("Press 1 to continue",width/2.7,height/2);
}

// in the demo page
void prompt2(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(240,50);
  noStroke();
  textFont(A_font_small);
  text("Press 2 to end the demo",width/3,100);
}

// in the music player page
void prompt3(boolean PS){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(255);
  noStroke();
  textFont(font);
  text("Listen to a clip of music", width/6,height/2.5);
  
  fill(240,50);
  noStroke();
  textFont(font2);
  text("Press left to play, right to stop; Press 0 to go to next part",width/5.7,height/2 - 10);
}


// for choosing color
void prompt4(){
  colorMode(RGB,255,255,255);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(250);
  noStroke();
  textFont(font);
  text("Choose three colors that",width/5.5,height/4);
  text("match the music best",width/5.5,height/2.5);
  
  fill(240,50);
  noStroke();
  textFont(font2);
  text("Press 1-9 to choose colors; Press 0 to go to next part",width/5.7,height/2 - 10);
  
}

void prompt5(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(250);
  noStroke();
  textFont(font);
  text("Choose one element that",width/5.5,height/4);
  text("match the music best",width/5.5,height/2.5);
  
  fill(240,50);
  noStroke();
  textFont(font2);
  text("Press 1-3 to choose particle; Press 0 to go to next part",width/5.7,height/2- 10);
}

void prompt6(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(250);
  noStroke();
  textFont(font);
  text("Choose one element that",width/5.5,height/4);
  text("match the music best",width/5.5,height/2.5);
  
  fill(240,50);
  noStroke();
  textFont(font2);
  text("Press 1-2 to choose particle; Press 0 to go to next part",width/5.7,height/2- 10);
}

void prompt7(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  background(0);
  fill(255);
  noStroke();
  textFont(font);
  text("Generate Visualization Now!",width/7.5,height/2.5);
  
  fill(240,80);
  noStroke();
  textFont(font2);
  text("Press 1 to continue",width/2.7,height/2);
}

void prompt8(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(240,50);
  noStroke();
  textFont(A_font_small);
  text("Press 2 to end the visualization",width/3.3,100);
}

void prompt9(){
  colorMode(RGB,255,255,255,255);
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
  
  fill(255);
  noStroke();
  textFont(font);
  text("Thank you!", width/3,height/2.5);
  
  fill(240,50);
  noStroke();
  textFont(font2);
  text("Press 1 to try again",width/2.7,height/2 - 10);
  
  fill(50,150,50);
  noStroke();
  rect(width/2 - 110, height/2 + 100, 220, 100, 10);
  
  fill(255);
  noStroke();
  textFont(font2);
  text("Try Again",width/2 - 85, height/2 + 160);
  
  if ((mouseX < width/2 + 110) && (mouseX > width/2 - 110) && (mouseY > height/2 + 100) && (mouseY < height/2 + 200)){
    fill(50,50,150);
    noStroke();
    rect(width/2 - 110, height/2 + 100, 220, 100, 7);
    fill(255);
    noStroke();
    textFont(font2);
    text("Try Again",width/2 - 85,height/2 + 160);
  }
}
