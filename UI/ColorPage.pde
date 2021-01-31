void color_choice(){
  colorMode(HSB,360, 100, 100,200);
  for (int i = 0; i<9; i++){
    noStroke();
    fill(40*i-20,50,90);
    circle((i+1)*160 - 50, height/1.3, 70);
    fill(i,0,90);
    noStroke();
    textFont(font2);
    text(i+1,(i+1)*160 - 60, height/1.2+10);
  }
}
