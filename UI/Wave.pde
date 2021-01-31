void Wave(float score) {
  //for(int i = 0; i < ranges; i++) {
    //float paint = map(i, 0, ranges, 0, 255);
    //stroke(paint);
    beginShape();
    for (int iDegree = 0; iDegree < 360; iDegree++) {    
    //let aNoiseSrcX = map(cos(iDegree), -1, 1, 0, 1);  //-1 ~ +1 -> 0 ~ NOISE_MAX
    //let aNoiseSrcY = map(sin(iDegree), -1, 1, 0, 1);  //-1 ~ +1 -> 0 ~ NOISE_MAX    
    float degree = (float)iDegree/(2*PI);
    println(degree);
    float aNoiseSrcX = cos(degree)*5;
    float aNoiseSrcY = sin(degree)*5;
    //float aNoiseSrcX = random(-5,5);
    //float aNoiseSrcY =  random(-5,5);
    println(aNoiseSrcX,aNoiseSrcY);
    float aNoise = noise(aNoiseSrcX, aNoiseSrcY, frameCount * 0.02);
    float aRadius = map(aNoise, 0, 1, 0, score*0.5);    
    //float aNoise = noise(degree * 0.1, random(10) * 0.01, frameCount * 0.02);
    //float aRadius = map(aNoise, 0, 1, 0, height*0.7);  
    float x = aRadius * cos(degree);
    float y = aRadius * sin(degree);
    
    vertex(x, y);
    //println(aRadius, x, y);
    }
    endShape();
  //}
}
