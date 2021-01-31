import processing.serial.*;

import cc.arduino.*;
import org.firmata.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// for iremote
Serial myPort;  // Create object from Serial class
int val = 1000;   

Minim       minim;
AudioPlayer jingle;
AudioPlayer song;
FFT         fft;
BeatDetect beat;
//BeatListener bl;

float specLow = 0.05; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.20;   // 20%

// Score values for each area
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

// Softening value
float scoreDecreaseRate = 25;

// Valeur précédentes, pour adoucir la reduction; Previous value, to soften the reduction
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;

boolean first_page = true;
boolean second_page = false;
boolean third_page = false;
boolean forth_page = false;
boolean fifth_page = false;
boolean sixth_page = false;
boolean seventh_page = false;
boolean eighth_page = false;
boolean ninth_page = false;
boolean tenth_page = false;
PFont font;
PFont A_font_small;
PFont font2;
PImage syn;
ArrayList<Firework> show = new ArrayList();

// for demo page and music play page
int musicNum = int(random(1,5));;
int time = 0;
boolean play = false;
int prevCount = 0;
int count = 0; //how many colors chosen

// for choice of colors
ArrayList three_col = new ArrayList();

// for choice of particles
PImage particle_bubble;
PImage particle_firework;
PImage particle_wave;
PImage freq_line;
PImage freq_rect;
ArrayList particle = new ArrayList();
ArrayList freq = new ArrayList();
int count1 = 0;
int count2 = 0;

// for bubbles
float noiseSeed = 0.5;
float rotateSeed;

// for visualization
int time2 = 0;

void setup(){
  //size(displayWidth, displayHeight, P3D);
  println(displayWidth, displayHeight);
  //fullScreen(P3D);
  size(1500,1000);
  
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  
  // for first page, start game
  font = loadFont("Algerian-80.vlw");
  A_font_small = loadFont("Algerian-40.vlw");
  //syn = loadImage("dark_synesthesia.jpg");
  font2 = loadFont("Calibri-Bold-40.vlw");
  frameRate(30);
  background(0);
  
  // for demo of synesthesia
  minim = new Minim(this);
  frameRate(30);
  
}

void draw(){
  //background(0);
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();      // read it and store it in val
    if(val == 0){
    println(val,"0 pressed");
    }
    if(val == 1){
    println(val,"1 pressed");
    }
    if(val == 2){
    println(val,"2 pressed");
    }
    if(val == 3){
    println(val,"3 pressed");
    }
    if(val == 4){
    println(val,"4 pressed");
    }
    if(val == 5){
    println(val,"5 pressed");
    }
    if(val == 6){
    println(val,"6 pressed");
    }
    if(val == 7){
    println(val,"7 pressed");
    }
    if(val == 8){
    println(val,"8 pressed");
    }
    if(val == 9){
    println(val,"9 pressed");
    }
    if(val == 11){
    println(val,"left pressed");
    }
    if(val == 12){
    println(val,"right pressed");
    }
    //if(val == 13){
    //println(val,"EQ pressed");
    //}
    //if(val == 14){
    //println(val,"ST pressed");
    //}
  }
  if (first_page){
    startGame();
    if(val == 0|| (mousePressed == true && (mouseX < width/2 + 110) && (mouseX > width/2 - 110) && (mouseY > height/2 + 100) && (mouseY < height/2 + 200))){
      //prompt1();
      first_page = false;
      second_page = true;
    }
  }
  else if (second_page){
    prompt1();
    if (val==1||(keyPressed == true && key == '1')){
      second_page = false;
      third_page = true;
      demo_setup();
    }
  }
  else if (third_page){
    //set_up();
    demo_visualizer(jingle);
    time += 1;
    if (time <=100){
      prompt2();
    }
    if (val==2||(keyPressed == true && key == '2')){
      third_page = false;
      forth_page = true;
      stop_visualize(jingle);
      print(forth_page);
    }
  }
  else if (forth_page){
    //set_up();
    prompt3(play);
    play_stop(play);
    if (play == false){
      if(val == 11 ||(mousePressed == true && (mouseX < width/2 -5) && (mouseX > width/2 - 225) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
      //prompt1();
        play_music();
        play = true;
      }
    }
    else if (play == true){
      if(val == 12 ||(mousePressed == true && (mouseX < width/2 + 225) && (mouseX > width/2 + 5) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
        play = false;
        stop_music();
      }
    }
    if (val ==0||(keyPressed == true && key == '0')){
      forth_page = false;
      fifth_page = true;
    }
  }
  else if (fifth_page){
    //set_up();
    prompt4();
    play_stop(play);
    if (play == false){
      if(val == 11 ||(mousePressed == true && (mouseX < width/2 -5) && (mouseX > width/2 - 225) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
        play_music();
        play = true;
      }
    }
    else if (play == true){
      if(val == 12 ||(mousePressed == true && (mouseX < width/2 + 225) && (mouseX > width/2 + 5) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
        play = false;
        stop_music();
      }
    }
    color_choice();
    if(val == 1 && three_col.contains(40*0-20)==false){
      three_col.add((float)40*0-20);
      count+=1;
    }
    if(val == 2 && three_col.contains(40*1-20)==false){
      three_col.add((float)40*1-20);
      count+=1;
    }
    if(val == 3 && three_col.contains(40*2-20)==false){
      three_col.add((float)40*2-20);
      count+=1;
    }
    if(val == 4 && three_col.contains(40*3-20)==false){
      three_col.add((float)40*3-20);
      count+=1;
    }
    if(val == 5 && three_col.contains(40*4-20)==false){
      three_col.add((float)40*4-20);
      count+=1;
    }
    if(val == 6 && three_col.contains(40*5-20)==false){
      three_col.add((float)40*5-20);
      count+=1;
    }
    if(val == 7 && three_col.contains(40*6-20)==false){
      three_col.add((float)40*6-20);
      count+=1;
    }
    if(val == 8 && three_col.contains(40*7-20)==false){
      three_col.add((float)40*7-20);
      count+=1;
    }
    if(val == 9 && three_col.contains(40*8-20)==false){
      three_col.add((float)40*8-20);
      count+=1;
    }
    if (val ==0 && count == 3||(keyPressed == true && key == '0')&& count >= 3){
      fifth_page = false;
      sixth_page = true;
      println(three_col);
    }
  }
  else if (sixth_page){
    //set_up();
    prompt5();
    play_stop(play);
    if (play == false){
      if(val == 11 ||(mousePressed == true && (mouseX < width/2 -5) && (mouseX > width/2 - 225) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
      //prompt1();
        play_music();
        play = true;
      }
    }
    else if (play == true){
      if(val == 12 ||(mousePressed == true && (mouseX < width/2 + 225) && (mouseX > width/2 + 5) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
        play = false;
        stop_music();
      }
    }
    load_particle();
    if(val == 1 && particle.contains(1)==false){
      particle.add(1);
      count1+=1;
    }
    if(val == 2 && particle.contains(2)==false){
      particle.add(2);
      count1+=1;
    }
    if(val == 3 && particle.contains(3)==false){
      particle.add(3);
      count1+=1;
    }
    if (val ==0 && count1 == 1||(keyPressed == true && key == '5')){
      sixth_page = false;
      seventh_page = true;
    }
  }
  else if (seventh_page){
    //set_up();
    prompt6();
    play_stop(play);
    if (play == false){
      if(val == 11 ||(mousePressed == true && (mouseX < width/2 -5) && (mouseX > width/2 - 225) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
      //prompt1();
        play_music();
        play = true;
      }
    }
    else if (play == true){
      if(val == 12 ||(mousePressed == true && (mouseX < width/2 + 225) && (mouseX > width/2 + 5) && (mouseY > height/2 + 50) && (mouseY < height/2 + 150))){
        play = false;
        stop_music();
      }
    }
    load_freq();
    if(val == 1 && freq.contains(1)==false){
      freq.add(1);
      count2+=1;
    }
    if(val == 2 && freq.contains(2)==false){
      freq.add(2);
      count2+=1;
    }
    if (val ==0 && count2 == 1||(keyPressed == true && key == '6')){
      seventh_page = false;
      eighth_page = true;
      //count+=1;
      stop_music();
    }
  }
  else if (eighth_page){
    //set_up();
    prompt7();
    if (val==1||(keyPressed == true && key == '1')){
      eighth_page = false;
      ninth_page = true;
      //count+=1;
      setUp(musicNum);
    }
  }
  else if (ninth_page){
    visualizer(song, three_col, particle, freq);
    if (time2 <=100){
      prompt8();
    }
    if (val==2||(keyPressed == true && key == '2')){
      ninth_page = false;
      tenth_page = true;
      stop_visualize(song);
    }
  }
  else if (tenth_page){
    prompt9();
    
    if (val==1||(keyPressed == true && key == '2')){
      tenth_page = false;
      forth_page = true;
      musicNum = int(random(1,5));
      play = false;
    }
  }
}
