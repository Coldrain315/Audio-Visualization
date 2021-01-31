void startGame(){
  screenRefresh();
  //image(syn,0,0);
  fill(255);
  noStroke();
  textFont(font);
  text("Welcome to Synesthesia!",width/6.5,height/2.5);
  
  fill(240,80);
  noStroke();
  textFont(font2);
  text("Press 0 to start",width/2.5,height/2.1);
  
  fill(50,150,50);
  noStroke();
  rect(width/2 - 110, height/2 + 100, 220, 100, 10);
  
  fill(255);
  noStroke();
  textFont(font2);
  text("Get Started",width/2 - 95, height/2 + 160);
  
  if ((mouseX < width/2 + 110) && (mouseX > width/2 - 110) && (mouseY > height/2 + 100) && (mouseY < height/2 + 200)){
    fill(50,50,150);
    noStroke();
    rect(width/2 - 110, height/2 + 100, 220, 100, 7);
    fill(255);
    noStroke();
    textFont(font2);
    text("Get Started",width/2 - 95,height/2 + 160);
  }
  
  // background
  color col = color(random(150, 200), random(150, 200), random(150, 200), 25);
  for (int i = 0; i< 3; i++){
    show.add(new Firework(random(width),random(height),1,col));
  }
  for( int i = 0; i<show.size();i++){
     Firework firework = (Firework)show.get(i);
     firework.render();
   }
}
