import java.util.*;
int state = 0;
String result = "";
boolean nameError = false;
void setup(){
  size(660,660);
}
void draw(){
  background(255);
  fill(0);
  textSize(32);
  if(nameError){
    text("Music file does not exist",100,200);
  }
  switch(state){
    case 0:
    text("Enter song name \n"+result,100,100);
    break;
    case 1:
    text("Enter bpm \n"+result,100,100);
    break;
  }
}
void keyPressed(){
  if(key==ENTER || key==RETURN){
    if(state==0){
      String path = sketchPath(result);
      File f = new File(path);
      if(f.exists()){
        state++;
        nameError = false;
      }else{
        nameError = true;
      }
      result = "";
    }
  }else if(key==BACKSPACE){
    result = result.substring(0,result.length()-1);
  }else{
    result += key;
  }
}
