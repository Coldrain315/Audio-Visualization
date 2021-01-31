void screenRefresh(){
  noStroke();
  fill(0,50);
  rect(0,0,width,height);
}

void stop_visualize(AudioPlayer music){
  music.close();
  minim.stop();
  
  //super.stop();
  background(0);
}

void stop_music(){
  song.close();
  minim.stop();
}

void play_stop(boolean PS){
  colorMode(RGB,255,255,255);
    if(PS==false){
    fill(50,150,50);
    noStroke();
    rect(width/2 - 225, height/2 + 50, 220, 100, 10);
    
    fill(255);
    noStroke();
    textFont(font2);
    text("Play",width/2 - 115, height/2 + 60 + 50);
    triangle(width/2 - 180,height/2 + 30 + 50,width/2 - 180,height/2 + 70+ 50, width/2 - 140,height/2 + 50+ 50);
  }
  else{
    fill(50,50,150);
    noStroke();
    rect(width/2 + 5, height/2+ 50, 220, 100, 10);
    
    fill(255);
    noStroke();
    textFont(font2);
    text("Stop",width/2 + 115, height/2 + 60+ 50);
    fill(255);
    rect(width/2 + 50, height/2 + 30+ 50, 40, 40);
  }
}

void freq_line(){
  fft.forward(song.mix);
  beat.detect(song.mix);
  
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
  for(int i = 1; i < fft.specSize()/10; i++)
  {
    //float bandValue = fft.getBand(i)*(1 + (i/50));
    int w = width/(2*fft.specSize()/10);

    float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
    float usedHigh = map(scoreHi, 0, 300, 0, 100);
    stroke(usedScore, 40, 60 + usedHigh, 255 - i);
    strokeWeight(2);
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    float prev_band = map(average_band[i - 1], 0, max_band, 0, height/2);
     line((i -1) * w, height - prev_band, i * w, height - mapped_band);
     line(width - (i -1) * w, height - prev_band, width - i * w, height - mapped_band);
     circle((i -1) * w,height - prev_band, 5);
     circle(width - (i -1) * w,height - prev_band, 5);
  }
  int i = fft.specSize()/10;
  float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
  int w = width/(2*fft.specSize()/10);
  for(int j = 0; j <= (width - (i-1) * w *2)/w ; j++){
    line((i-1) * w + j * w, height - mapped_band, (i-1) * w +(j+1) * w, height - mapped_band);
    circle((i-1) * w + j * w,height - mapped_band, 5);
  }  
}

void freq_rect(AudioPlayer music)
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
    //println("beat");
    //println(prevCount,frameCount);
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
  for(int i = 0; i < fft.specSize()/10; i++)
  {
    int w = width/(2*fft.specSize()/10);
    float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
    float usedHigh = map(scoreHi, 0, 300, 0, 50);
    noStroke();
    fill(usedScore, 40, 60+usedHigh, 255 - i);
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    rect(i * w, height - mapped_band - 10, 3, mapped_band+10, 3);
    rect(width - i * w, height - mapped_band - 10, 3, mapped_band+10, 3);
  }
  int i = fft.specSize()/10;
  float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
  int w = width/(2*fft.specSize()/10);
  for(int j = 0; j < (width - (i-1) * w *2)/w; j++){
    rect((i-1) * w + j * w, height - mapped_band - 10, 3, mapped_band+10, 3);
  }  
}

void visualizer(AudioPlayer music, ArrayList colors,  ArrayList particle,  ArrayList freq){
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
  
  colorMode(HSB,360,100,100,255);
  if((int)particle.get(0)==1){ //chose bubbles
    noStroke();
    fill(0,25);
    rect(0,0,width,height);
    noiseSeed += 0.01;
    rotateSeed += noise(noiseSeed);
    int num = (int)random(0,3);
    float[] Hues = new float[3];
    float Hue1 = random((float)colors.get(0)-20, (float)colors.get(0)+20);
    float Hue2 = random((float)colors.get(1)-20, (float)colors.get(1)+20);
    float Hue3 = random((float)colors.get(2)-20, (float)colors.get(2)+20);
    Hues[0] = Hue1;
    Hues[1] = Hue2;
    Hues[2] = Hue3;
    if(beat.isRange(10, 15, 2)){
      Bubble b = new Bubble(200, 4.5, scoreGlobal, noiseSeed, rotateSeed, Hues[num]);
      b.render();
    }
    else{
      Bubble b = new Bubble(200, 4.5, 0, noiseSeed, rotateSeed, Hues[num]);
      b.render();
    }
  }
  if((int)particle.get(0)==2){ //chose firework
    if(beat.isRange(5, 15, 2)&&(frameCount-prevCount>5)){
    int num = (int)random(0,3);
    float[] Hues = new float[3];
    //float Hue1 = random(45, 70);
    //float Hue2 = random(190, 215);
    //float Hue3 = random(10, 45);
    float Hue1 = random((float)colors.get(0)-20, (float)colors.get(0)+20);
    float Hue2 = random((float)colors.get(1)-20, (float)colors.get(1)+20);
    float Hue3 = random((float)colors.get(2)-20, (float)colors.get(2)+20);
    Hues[0] = Hue1;
    Hues[1] = Hue2;
    Hues[2] = Hue3;
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
  }
  if((int)particle.get(0)==3){
    fill(0,10);
    noStroke();
    rect(0,0,width,height);
    strokeWeight(2);
    int num = (int)random(0,3);
    float[] Hues = new float[3];
    //float Hue1 = random(45, 70);
    //float Hue2 = random(190, 215);
    //float Hue3 = random(10, 45);
    float Hue1 = random((float)colors.get(0)-20, (float)colors.get(0)+20);
    float Hue2 = random((float)colors.get(1)-20, (float)colors.get(1)+20);
    float Hue3 = random((float)colors.get(2)-20, (float)colors.get(2)+20);
    Hues[0] = Hue1;
    Hues[1] = Hue2;
    Hues[2] = Hue3;
    if(beat.isRange(10, 15, 2)){
      stroke(Hues[num],80, 70);
      translate(width/2, height/2);
      Wave(scoreGlobal);
      translate(-width/2, -height/2);
  }
  else{
    stroke(Hues[num]+15,80, 70);
    translate(width/2, height/2);
    Wave(height/1.5);
    translate(-width/2, -height/2);
  }
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
  if ((int)freq.get(0)==1){
    for(int i = 1; i < fft.specSize()/10; i++){
      int w = width/(2*fft.specSize()/10);

      float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
      float usedHigh = map(scoreHi, 0, 300, 0, 50);
      stroke(usedScore, 40, 60+usedHigh, 255 - i);
      strokeWeight(2);
      float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
      float prev_band = map(average_band[i - 1], 0, max_band, 0, height/2);
      line((i -1) * w, height - prev_band, i * w, height - mapped_band);
      line(width - (i -1) * w, height - prev_band, width - i * w, height - mapped_band);
      circle((i -1) * w,height - prev_band, 5);
      circle(width - (i -1) * w,height - prev_band, 5);
    }
    int i = fft.specSize()/10;
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    int w = width/(2*fft.specSize()/10);
    for(int j = 0; j <= (width - (i-1) * w *2)/w ; j++){
      line((i-1) * w + j * w, height - mapped_band, (i-1) * w +(j+1) * w, height - mapped_band);
      circle((i-1) * w + j * w,height - mapped_band, 5);
    }  
    line((i-1) * w, height - mapped_band, width - (i-1) * w, height - mapped_band);
  }
  
  if ((int)freq.get(0)==2){
    for(int i = 0; i < fft.specSize()/10; i++)
    {
    int w = width/(2*fft.specSize()/10);
    float usedScore = map(scoreGlobal, 0, 1000, 0, 360);
    float usedHigh = map(scoreHi, 0, 300, 0, 50);
    noStroke();
    fill(usedScore, 40, 60+usedHigh, 255 - i);
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    rect(i * w, height - mapped_band - 10, 3, mapped_band+10, 3);
    rect(width - i * w, height - mapped_band - 10, 3, mapped_band+10, 3);
    }  
    int i = fft.specSize()/10;
    float mapped_band = map(average_band[i], 0, max_band, 0, height/2);
    int w = width/(2*fft.specSize()/10);
    for(int j = 0; j < (width - (i-1) * w *2)/w; j++){
      rect((i-1) * w + j * w, height - mapped_band - 10, 3, mapped_band+10, 3);
    }  
  }
}
