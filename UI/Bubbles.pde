class Bubble {
  float score, Length, initRad, noiseSd, rotateSd, random_min;
  float rotateSeed;
  float rotateSpeed = 0.5;
  int fluctuationDepth = 20;
  int waveH = 1400;
  //float timeSync, timeAlive;
  float colour;

  Bubble(float num, float radius, float scoreGlobal, float noiseSeed, float rotateSeed, float Hue) {
    Length = num;
    initRad = radius; // the init radius of bubbles
    score = map(scoreGlobal,0,1000,0,0.3); // the score that determines how far the bubbles apart from axle
    random_min = map(scoreGlobal,0,1000,40,100);
    noiseSd = noiseSeed;
    rotateSd = rotateSeed;
    colour = Hue;
    //if(scoreGlobal>500){
    //  float random_min = 80;
    //}
    //else{
    //  float random_min = 40;
    //}
  }

  void render() {
    translate(width/2, height/2);
    rotateSd += 10*noise(noiseSd);
    
    pushMatrix();
    rotate(radians(rotateSd*rotateSpeed));
    for(int i = 0; i< Length-1; i+=random(10,40)){
    noStroke();
    fill(colour,random(50,100),random(random_min,100));
    //fill(colour,100,100);
    float radius = random(0,9)+initRad;
    ellipse(i, random(-score,score)*waveH, radius, radius);
    ellipse(-i, random(-score,score)*waveH, radius, radius);

  }
  popMatrix();
  translate(-width/2, -height/2);
  }
}

void bubble()
{
  
  //background(0);
  //stroke(255);
  
  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( jingle.mix );
  beat.detect(jingle.mix);
  
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  
  // Reset values
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
 
  // Calculate new "scores"
  for(int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }
  
  // Slow the descent.
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }
  
  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }
  
  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }
  
  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
  
  noStroke();
  fill(0,8);
  rect(0,0,width,height);
  //color col = color(random(150, 255), random(150, 255), random(150, 255));
  colorMode(HSB, 360, 100, 100, 200);
  noiseSeed += 0.01;
  rotateSeed += noise(noiseSeed);
  if(beat.isRange(10, 15, 2)){
    println("beat");
    Bubble b = new Bubble(200, 4.5, scoreGlobal, noiseSeed, rotateSeed, frameCount%360);
    b.render();
    println(scoreGlobal);
  }
  else{
    Bubble b = new Bubble(200, 4.5, 0, noiseSeed, rotateSeed, frameCount%360);
    b.render();
  }

}
