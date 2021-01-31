void play_music()
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
  println(musicNum);
  song = minim.loadFile(musicNum + ".mp3", 1024);
  
  // loop the file indefinitely
  song.loop();
}

void setUp(int musicNum){
  background(0);
  minim = new Minim(this);
  frameRate(30);
  song = minim.loadFile(musicNum + ".mp3", 1024);
  
  song.loop();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(0);
  noStroke();
  fft = new FFT( song.bufferSize(), song.sampleRate() );
}
