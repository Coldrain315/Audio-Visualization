

//ArrayList<Firework> show = new ArrayList();
void demo_setup()
{
  //fullScreen(P3D);
  //size(600,600);
  background(0);
  minim = new Minim(this);
  frameRate(30);
  //smooth();
  // specify that we want the audio buffers of the AudioPlayer
  // to be 1024 samples long because our FFT needs to have 
  // a power-of-two buffer size and this is a good size.
  //jingle = minim.loadFile("partOfSolution.mp3", 1024);
  jingle = minim.loadFile("1.mp3", 1024);
  
  // loop the file indefinitely
  jingle.loop();
  beat = new BeatDetect(jingle.bufferSize(), jingle.sampleRate());
  beat.setSensitivity(0);
  //bl = new BeatListener(beat, jingle);
  //beat = new BeatDetect();
  noStroke();
  // create an FFT object that has a time-domain buffer 
  // the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be half as large.
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  
}

void demo_visualizer(AudioPlayer music)
{
  
  //background(0);
  //stroke(255);
  
  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward(music.mix);
  beat.detect(music.mix);
  
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
  
  fill(0,50);
  noStroke();
  rect(0,0,width,height);
  colorMode(HSB,360,100,100,255);
  if(beat.isRange(5, 15, 2)&&(frameCount-prevCount>5)){
    int num = (int)random(0,2);
    float[] Hues = new float[2];
    float Hue1 = random(45, 70);
    float Hue2 = random(190, 215);
    Hues[0] = Hue1;
    Hues[1] = Hue2;
  //println(Hues[num]);
    color col = color(Hues[num], random(40,60), random(90,100));
    prevCount = frameCount;
    println(scoreGlobal);
    float used_score = map(scoreGlobal,0, 1000, 0, 6);
    show.add(new Firework(width/2,height/2,used_score, col));
  }
  for( int i = 0; i<show.size();i++){
     Firework firework = (Firework)show.get(i);
     firework.render();
   }
   
  float max_band = 0;
  float[] average_band;
  average_band = new float[fft.specSize()/10 + 1];
  float cur_band = 0;
  //println(fft.specSize(),fft.specSize()/10);
  for(int i = 0; i < fft.specSize(); i++)
  {
    float bandValue = fft.getBand(i)*30;
    
    if (i % 10 == 0){
      cur_band += bandValue;
      average_band[i/10] = (float)cur_band/10;
      cur_band = 0;
      }
    else{
      //float mapped_band = map( fft.getBand(i)*30, 0, max_band, 0, height/2);
      cur_band += bandValue;
      }
    if( (float)cur_band/10> max_band){
      max_band = (float)cur_band/10;
    }
  }
  //float prev_band = 0;
  //for(int i = 1; i < fft.specSize()/10; i++)
  //{
  //  //float bandValue = fft.getBand(i)*(1 + (i/50));
  //  int w = width/(2*fft.specSize()/10);

  //  float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
  //  float usedHigh = map(scoreHi, 0, 300, 0, 50);
  //  stroke(usedScore, 40, 60+usedHigh, 255 - i);
  //  strokeWeight(2);
  //  float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
  //  float prev_band = map(average_band[i - 1], 0, max_band, 0, height/2);
  //   line((i -1) * w, height - prev_band, i * w, height - mapped_band);
  //   line(width - (i -1) * w, height - prev_band, width - i * w, height - mapped_band);
  //   circle((i -1) * w,height - prev_band, 5);
  //   circle(width - (i -1) * w,height - prev_band, 5);
  //}
  //int i = fft.specSize()/10;
  //float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
  //int w = width/(2*fft.specSize()/10);
  //for(int j = 0; j <= (width - (i-1) * w *2)/w ; j++){
  //  line((i-1) * w + j * w, height - mapped_band, (i-1) * w +(j+1) * w, height - mapped_band);
  //  circle((i-1) * w + j * w,height - mapped_band, 5);
  //}  
  //line((i-1) * w, height - mapped_band, width - (i-1) * w, height - mapped_band);
  for(int i = 0; i < fft.specSize()/10; i++)
  {
    int w = width/(2*fft.specSize()/10);
    float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
    float usedHigh = map(scoreHi, 0, 300, 0, 50);
    noStroke();
    fill(usedScore, 20, 80+usedHigh, 255 - i);
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    rect(i * w, height - mapped_band - 10, 7, mapped_band+10, 5);
    rect(width - i * w, height - mapped_band - 10, 7, mapped_band+10, 5);
  }
  int i = fft.specSize()/10;
  float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
  int w = width/(2*fft.specSize()/10);
  for(int j = 0; j < (width - (i-1) * w *2)/w; j++){
    rect((i-1) * w + j * w, height - mapped_band - 10, 7, mapped_band+10, 5);
  }  
}
