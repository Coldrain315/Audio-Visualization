void load_particle(){
  //size(400,200);
  particle_bubble = loadImage("bubble_200.png");
  particle_firework = loadImage("firework_200.png");
  particle_wave = loadImage("wave_200.png");
  translate(width/5+50, height/1.5);
  image(particle_bubble,0,0,200,200);
  fill(255);
  noStroke();
  textFont(font2);
  text(1,100,250);
  image(particle_firework,300,0,200,200);
  fill(255);
  noStroke();
  textFont(font2);
  text(2,400,250);
  image(particle_wave,600,0,200,200);
  fill(255);
  noStroke();
  textFont(font2);
  text(3,700,250);
}

void load_freq(){
  //size(400,200);
  freq_line = loadImage("line_200.png");
  freq_rect = loadImage("rect_200.png");
  translate(width/5.5, height/1.5 + 20);
  image(freq_line,0,0,400,200);
  image(freq_rect,600,0,400,200);
  fill(255);
  noStroke();
  textFont(font2);
  text(1,200,250);
  fill(255);
  noStroke();
  textFont(font2);
  text(2,800,250);
}
