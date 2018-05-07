import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer note1,note2,note3,note4,note5,note6,note7,note8,note9,note10;


FFT fft1,fft2,fft3,fft4,fft5,fft6,fft7,fft8,fft9,fft10;
float newposx;
float tempo;
int lastMillis;
int colCounter;
int ms=200;

circlenotes[] CirclenotesArray = new circlenotes[0];

void setup()
{
fullScreen();


  lastMillis = millis();
  colCounter = -1;

  minim = new Minim(this);

 //Load the files
  note1 = minim.loadFile("note1.mp3");  note2 = minim.loadFile("note2.mp3");
  note3 = minim.loadFile("note3.mp3");  note4 = minim.loadFile("note4.mp3");
  note5 = minim.loadFile("note5.mp3");  note6 = minim.loadFile("note6.mp3");
  note7 = minim.loadFile("note7.mp3");  note8 = minim.loadFile("note8.mp3");
  note9 = minim.loadFile("note9.mp3");  note10 = minim.loadFile("note10.mp3");

  fft1 = new FFT(note1.bufferSize(), note1.sampleRate());
  fft2 = new FFT(note2.bufferSize(), note2.sampleRate());
  fft3 = new FFT(note3.bufferSize(), note3.sampleRate());
  fft4 = new FFT(note4.bufferSize(), note4.sampleRate());
  fft5 = new FFT(note5.bufferSize(), note5.sampleRate());
  fft6 = new FFT(note6.bufferSize(), note6.sampleRate());
  fft7 = new FFT(note7.bufferSize(), note7.sampleRate());
  fft8 = new FFT(note8.bufferSize(), note8.sampleRate());
  fft9 = new FFT(note9.bufferSize(), note9.sampleRate());
  fft10 = new FFT(note10.bufferSize(), note10.sampleRate());


  background(0);

}
 
void draw(){
  int m = millis();
  
  background(255);

  fft1.forward( note1.mix );
  fft2.forward( note2.mix );
  fft3.forward( note3.mix );
  fft4.forward( note4.mix );
  fft5.forward( note5.mix );
  fft6.forward( note6.mix );
  fft7.forward( note7.mix );
  fft8.forward( note8.mix );
  fft9.forward( note9.mix );
  fft10.forward( note10.mix );
  
  
  for(int i = 5; i < 50; i++)
  {
    fill(random(100,255),random(100,255),random(100,255));
    ellipse( 9*(width/10),10+fft1.getBand(i)*6,  fft1.getBand(i)*6,fft1.getBand(i)*6 );
    ellipse( 8*(width/10),10+fft2.getBand(i)*6,  fft2.getBand(i)*6,fft2.getBand(i)*6 );
    ellipse( 7*(width/10),10+fft3.getBand(i)*6,  fft3.getBand(i)*6,fft3.getBand(i)*6 );
    ellipse( 6*(width/10),10+fft4.getBand(i)*6,  fft4.getBand(i)*6,fft4.getBand(i)*6 );
    ellipse( 5*(width/10),10+fft5.getBand(i)*6,  fft5.getBand(i)*6,fft5.getBand(i)*6 );
    ellipse( 4*(width/10),10+fft6.getBand(i)*6,  fft6.getBand(i)*6,fft6.getBand(i)*6 );
    ellipse( 3*(width/10),10+fft7.getBand(i)*6,  fft7.getBand(i)*6,fft7.getBand(i)*6 );
    ellipse( 2*(width/10),10+fft8.getBand(i)*6,  fft8.getBand(i)*6,fft8.getBand(i)*6 );
    ellipse( 1*(width/10),10+fft9.getBand(i)*6,  fft9.getBand(i)*6,fft9.getBand(i)*6 );
    ellipse((width/20),fft10.getBand(i)*6,  fft10.getBand(i)*6,fft10.getBand(i)*6 );
  }
  

  fill(255);

  float positionx=0;
  float positiony=275;
 //Create the circles and append it to an array of 10x10
  for (int i=0;i<100;i++){
    positionx+=35;
   
    if ((i%10)==0){
       positiony+=35;
       positionx=0;
    }
    
   circlenotes c  = new circlenotes();
   CirclenotesArray =(circlenotes[])append(CirclenotesArray, c);
   newposx=positionx+width/6+500;
   CirclenotesArray[i].makecircle(newposx,positiony);
  }
  

 int tempo = 60000/ms;
 
 textSize(42);
 fill(90);
 text("Tempo  "+tempo+" BPM",width/2-150,100);
 textSize(20);
  text("Use up and down keys to change "+"tempo",width/2-170,150);
 fill(50);
 
  if (m - lastMillis >= ms) {
    lastMillis = m;
    colCounter++;
    
   if (colCounter == 10) {
     colCounter = 0;
   }
   
   //Check each coloumn and play all the filled up notes in it
   for (int i = 0; i < CirclenotesArray.length; i++) {

       playColumn(CirclenotesArray, colCounter);
     
     
   }
    
  }
  
}


void mouseDragged(){
//As mouse is dragged, fill the circles and play the notes
 for (int i=0;i<100;i++){
    if ((mouseX>CirclenotesArray[i].positionx-15)&&(mouseX<CirclenotesArray[i].positionx+15)&&((mouseY>CirclenotesArray[i].positiony-15)&&(mouseY<CirclenotesArray[i].positiony+15))){
      if (mouseButton==LEFT){
         CirclenotesArray[i].state=true;
      }
      else{
         CirclenotesArray[i].state=false;
      }
    }
  }
}
void mousePressed(){
//As mouse is dragged, fill the circles and play the notes
 for (int i=0;i<100;i++){
    if ((mouseX>CirclenotesArray[i].positionx-15)&&(mouseX<CirclenotesArray[i].positionx+15)&&((mouseY>CirclenotesArray[i].positiony-15)&&(mouseY<CirclenotesArray[i].positiony+15))){
      if (mouseButton==LEFT){
         CirclenotesArray[i].state=true;
      }
      else{
         CirclenotesArray[i].state=false;
      }
    }
  }
}

void keyPressed(){
  if (keyCode==UP){
    ms-=1;
  }
  else if (keyCode==DOWN){
    ms+=1;
  }
  
  
}

//Function to determine if note should be played in a coloumn depending on if it is filled 

 void playColumn(circlenotes[] array, int num) {
   if (array[num].state) {
       note1.play();
       note1.rewind();

   }
   
   if(array[num + 10].state) {
     note2.play();
     note2.rewind();
   }
   
   if (array[num + 20].state) {
     note3.play();
     note3.rewind();
   }
   
   if (array[num + 30].state) {
     note4.play();
     note4.rewind();
   }
   
   if (array[num + 40].state) {
     note5.play();
     note5.rewind();
   }
      
   if (array[num + 50].state) {
     note6.play();
     note6.rewind();
   }
      
   if (array[num + 60].state) {
     note7.play();
     note7.rewind();
   }
      
   if (array[num + 70].state) {
     note8.play();
     note8.rewind();
   }
      
   if (array[num + 80].state) {
     note9.play();
     note9.rewind();
   }
    
   if (array[num + 90].state) {
     note10.play();
     note10.rewind();
   } 
   
 }



//Create circle class

class circlenotes{
  
  boolean state=false;
  float size=30;  
  float positionx;
  float positiony;

  
  
  void makecircle(float positionnx,float positionny){
  
  //ellipse(width/5,height/5,30,30);
  if (state==false){
    fill(170);
  }else{
    fill(random(100,255),random(100,255),random(100,255));
  }
  
  positionx=positionnx;
  positiony=positionny;


  ellipse(positionnx,positionny,size,size);
 
  }
}