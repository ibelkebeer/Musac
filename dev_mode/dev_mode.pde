import processing.sound.*;
import java.util.*;
int state;
SoundFile sample;
SoundFile hit;
String path1;
String path2;
String result = "";
String name;
float bpm;
float speed = 1;
float lineY;
int mode = 0;
int line = 0;
float time;
float ellapsedTime;
float pauseTime;
int startD = -1;
int startF = -1;
int startJ = -1;
int startK = -1;
boolean paused = false;
boolean perfect = false;
boolean nameError = false;
boolean bpmError = false;
int perfectCount = 0;
Map game;
void setup(){
  size(660,660);
  background(255);
}
void draw(){
  textSize(32);
  fill(0);
  switch(state){
    case 0:
    background(255);
    text("Enter song name \n"+result,100,100);
    if(nameError){
      text("Music file does not exist",100,200);
    }
    break;
    case 1:
    background(255);
    text("Enter bpm \n"+name,100,100);
    if(bpmError){
      text("invalid bpm",100,200);
    }
    break;
    case 2:
  game.rate(speed);
  ellapsedTime = millis() - time;
  background(255);
  fill(255);
  rect(0,height-40,100,40);
  rect(100,height-40,100,40);
  rect(200,height-40,100,40);
  rect(300,height-40,100,40);
  rect(0,height-80,100,40);
  rect(100,height-80,100,40);
  rect(200,height-80,100,40);
  rect(300,height-80,100,40);
  rect(400,0,65,660);
  rect(465,0,65,660);
  rect(530,0,65,660);
  rect(595,0,65,660);
  rect(400,height-120,260,40);
  fill(250,0,0);
  textSize(32);
  text("*.25",0,height);
  text("*1",100,height);
  text("*2",200,height);
  text("reset",300,height);
  text("note",0,height-40);
  text("save",300,height-40);
  textSize(18);
  text("hold-note",100,height-40);
  text("remove",200,height-40);
  fill(75,250,250);
  if(mode == 1){
    rect(mouseX-32.5,mouseY-20,65,game.size());
  }
  fill(250,0,250);
  if(mode == 2){
    rect(mouseX-32.5,mouseY-20,65,game.size());
  }
  if(!paused){
    move();
  }else{
    drawLines();
  }
  if(perfect){
    text("perfect",50,50);
    perfectCount++;
    if(perfectCount == 20){
      perfect = false;
      perfectCount = 0;
    }
  }
}
}
void move(){
  for(float i=lineY; i>=0; i-=game.size()){
    line(400,i,660,i);
    fill(75,250,250);
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getD() == 1){
      rect(400,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getF() == 1){
      rect(465,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getJ() == 1){
      rect(530,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getK() == 1){
      rect(595,i,65,game.size());
    }
    fill(250,0,250);
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getD() == 2){
      rect(400,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getF() == 2){
      rect(465,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getJ() == 2){
      rect(530,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getK() == 2){
      rect(595,i,65,game.size());
    }
  }
  increment();  
}
void drawLines(){
  for(float i=lineY; i>=0; i-=game.size()){
    line(400,i,660,i);
    fill(75,250,250);
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getD() == 1){
      rect(400,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getF() == 1){
      rect(465,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getJ() == 1){
      rect(530,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getK() == 1){
      rect(595,i,65,game.size());
    }
    fill(250,0,250);
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getD() == 2){
      rect(400,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getF() == 2){
      rect(465,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getJ() == 2){
      rect(530,i,65,game.size());
    }
    if(game.getLine((Math.abs(int(i-659)) / game.size())+line).getK() == 2){
      rect(595,i,65,game.size());
    }
  }
}
boolean overButton(int x, int y, int w, int h){
  return mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h;
}
void increment(){
  lineY += speed * 8;
  if(lineY >= 660){
    lineY = 620;
    line++;
  }
}
void mouseClicked(){
  if(state == 2){
  if(overButton(0,height-40,100,40)){
    speed = 0.25;
  }
  if(overButton(100,height-40,100,40)){
    speed = 1;
  }
  if(overButton(200,height-40,100,40)){
    speed = 2;
  }
  if(overButton(300,height-40,100,40)){
    if(startD != -1){
        game.setD(startD,0);
        startD = -1;
      }
      if(startF != -1){
        game.setF(startF,0);
        startF = -1;
      }
      if(startJ != -1){
        game.setJ(startJ,0);
        startJ = -1;
      }
      if(startK != -1){
        game.setK(startK,0);
        startK = -1;
      }
    paused = false;
    game.stop();
    game.jump(0);
    ellapsedTime = 0;
    time = millis();
    lineY = 660 - game.size();
    line = 0;
  }
  if(overButton(0,height-80,100,40)){
    if(mode == 2){
      if(startD != -1){
        game.setD(startD,0);
        startD = -1;
      }
      if(startF != -1){
        game.setF(startF,0);
        startF = -1;
      }
      if(startJ != -1){
        game.setJ(startJ,0);
        startJ = -1;
      }
      if(startK != -1){
        game.setK(startK,0);
        startK = -1;
      }
    }
    mode = 1;
  }
  if(overButton(100,height-80,100,40)){
    mode = 2;
  }
  if(overButton(200,height-80,100,40)){
    if(mode == 2){
      if(startD != -1){
        game.setD(startD,0);
        startD = -1;
      }
      if(startF != -1){
        game.setF(startF,0);
        startF = -1;
      }
      if(startJ != -1){
        game.setJ(startJ,0);
        startJ = -1;
      }
      if(startK != -1){
        game.setK(startK,0);
        startK = -1;
      }
    }
    mode = 3;
  }
  if(overButton(300,height-80,100,40)){
    game.save();
  }
  if(mode == 1 && overButton(400,0,260,660)){
    if(mouseX < 465){
      game.setD((Math.abs(int(mouseY)-659) / game.size())+line,1);
    }
    else if(mouseX < 530){
      game.setF((Math.abs(int(mouseY)-659) / game.size())+line,1);
    }
    else if(mouseX < 595){
      game.setJ((Math.abs(int(mouseY)-659) / game.size())+line,1);
    }
    else{
      game.setK((Math.abs(int(mouseY)-659) / game.size())+line,1);
    }
  }
  if(mode == 2 && overButton(400,0,260,660)){
    if(mouseX < 465){
      if(startD == -1){
        game.setD((Math.abs(int(mouseY)-659) / game.size())+line,2);
        startD = (Math.abs(int(mouseY)-659) / game.size())+line;
      }else{
        if((Math.abs(int(mouseY)-659) / game.size())+line < startD){
          game.setD(startD,0);
          game.setD((Math.abs(int(mouseY)-659) / game.size())+line,2);
          startD = (Math.abs(int(mouseY)-659) / game.size())+line;
        }else{
          for(int i = startD; i<=(Math.abs(int(mouseY)-659) / game.size())+line; i++){
            game.setD(i,2);
          }
          startD = -1;
        }
      }
    }else if(mouseX < 530){
      if(startF == -1){
        game.setF((Math.abs(int(mouseY)-659) / game.size())+line,2);
        startF = (Math.abs(int(mouseY)-659) / game.size())+line;
      }else{
        if((Math.abs(int(mouseY)-659) / game.size())+line < startF){
          game.setF(startF,0);
          game.setF((Math.abs(int(mouseY)-659) / game.size())+line,2);
          startF = (Math.abs(int(mouseY)-659) / game.size())+line;
        }else{
          for(int i = startF; i<=(Math.abs(int(mouseY)-659) / game.size())+line; i++){
            game.setF(i,2);
          }
          startF = -1;
        }
      }
    }else if(mouseX < 595){
      if(startJ == -1){
        game.setJ((Math.abs(int(mouseY)-659) / game.size())+line,2);
        startJ = (Math.abs(int(mouseY)-659) / game.size())+line;
      }else{
        if((Math.abs(int(mouseY)-659) / game.size())+line < startJ){
          game.setJ(startJ,0);
          game.setJ((Math.abs(int(mouseY)-659) / game.size())+line,2);
          startJ = (Math.abs(int(mouseY)-659) / game.size())+line;
        }else{
          for(int i = startJ; i<=(Math.abs(int(mouseY)-659) / game.size())+line; i++){
            game.setJ(i,2);
          }
          startJ = -1;
        }
      }
    }else{
      if(startK == -1){
        game.setK((Math.abs(int(mouseY)-659) / game.size())+line,2);
        startK = (Math.abs(int(mouseY)-659) / game.size())+line;
      }else{
        if((Math.abs(int(mouseY)-659) / game.size())+line < startK){
          game.setK(startK,0);
          game.setK((Math.abs(int(mouseY)-659) / game.size())+line,2);
          startK = (Math.abs(int(mouseY)-659) / game.size())+line;
        }else{
          for(int i = startK; i<=(Math.abs(int(mouseY)-659) / game.size())+line; i++){
            game.setK(i,2);
          }
          startK = -1;
        }
      }
    }
  }
  if(mode == 3 && overButton(400,0,260,660)){
    if(mouseX < 465){
      game.setD((Math.abs(int(mouseY)-660) / game.size())+line,0);
    }
    else if(mouseX < 530){
      game.setF((Math.abs(int(mouseY)-660) / game.size())+line,0);
    }
    else if(mouseX < 595){
      game.setJ((Math.abs(int(mouseY)-660) / game.size())+line,0);
    }
    else{
      game.setK((Math.abs(int(mouseY)-660) / game.size())+line,0);
    }
  }
}
}
void keyPressed(){
  switch(state){
    case 0:
    if(key==ENTER || key==RETURN){
      String path = sketchPath(result);
      File f = new File(path);
      if(f.exists()){
        path1 = sketchPath(result);
        name = result;
        state++;
        nameError = false;
        path = sketchPath(result.substring(0,result.length()-3) + "txt");
        File d = new File(path);
        if(d.exists()){
          state++;
          ellapsedTime = 0;
  path2 = sketchPath("hit.wav");
  sample = new SoundFile(this,path1);
  hit = new SoundFile(this,path2);
  game = new Map(sample,hit,180,name.substring(0,name.length()-4));
  game.load();
  game.play();
        }
      }else{
        nameError = true;
      }  
      result = "";
    }else if(key==BACKSPACE && result.length() > 0){
      result = result.substring(0,result.length()-1);
    }else if(key != CODED){
      result += key;
    }
    break;
    case 1:
    if(key==ENTER || key==RETURN){
      float b = float(result);
      if(!(b > 0)){
        bpmError = true;
      }else{
        state++;
      }
      result = "";
      time = millis();
  ellapsedTime = 0;
  path2 = sketchPath("hit.wav");
  sample = new SoundFile(this,path1);
  hit = new SoundFile(this,path2);
  game = new Map(sample,hit,180,name.substring(0,name.length()-4));
  game.load();
  game.play();
  lineY = 660 - game.size();
    }else if(key==BACKSPACE){
      result = result.substring(0,result.length()-1);
    }else if(key != RETURN && key != ENTER){
      result += key;
    }
    break;
    case 2:
    if(key == CODED){
      if(keyCode == LEFT){
        if(ellapsedTime >= 1){
          time += 1000;
          ellapsedTime = millis() - time;
          game.jump(ellapsedTime/1000);
          line -= game.bpm() / 30;
        }
      }
      if(keyCode == RIGHT){
        if(ellapsedTime <= sample.duration() * 1000){
          time -= 1000;
          ellapsedTime = millis() - time;
          game.jump(ellapsedTime/1000);
          line += game.bpm() / 30;
        }
      }
    }
    if(key == ' '){
      if(!paused){
        paused = true;
        game.stop();
        pauseTime = millis();
      }else{
        time += millis() - pauseTime;
        ellapsedTime = millis() - time;
        game.jump(ellapsedTime/1000);
        paused = false;
      }
    }
    textSize(30);
    if(key == 'd'){
      game.hit();
      if(game.getLine(2+line).getD() > 0 || (game.getLine(3+line).getD() > 0 && lineY >= 640)){
        perfect = true;
      }
    }
    if(key == 'f'){
      game.hit();
      if(game.getLine(2+line).getF() > 0 || (game.getLine(3+line).getF() > 0 && lineY >= 640)){
        perfect = true;
      }
    }
    if(key == 'j'){
      game.hit();
      if(game.getLine(2+line).getJ() > 0 || (game.getLine(3+line).getJ() > 0 && lineY >= 640)){
        perfect = true;
      }
    }
    if(key == 'k'){
      game.hit();
      if(game.getLine(2+line).getK() > 0 || (game.getLine(3+line).getK() > 0 && lineY >= 640)){
        perfect = true;
      }
    }
    break;
  }
}
void keyReleased(){
  if(state == 2){
    if(key == 'd' && game.getLine(2+line).getD() == 2 || (game.getLine(3+line).getD() == 2 && lineY >= 640)){
      game.hit();
      perfect = true;
    }
    if(key == 'f' && game.getLine(2+line).getF() == 2 || (game.getLine(3+line).getF() == 2 && lineY >= 640)){
      game.hit();
      perfect = true;
    }
    if(key == 'j' && game.getLine(2+line).getJ() == 2 || (game.getLine(3+line).getJ() == 2 && lineY >= 640)){
      game.hit();
      perfect = true;
    }
    if(key == 'k' && game.getLine(2+line).getK() == 2|| (game.getLine(3+line).getK() == 2 && lineY >= 640)){
      game.hit();
      perfect = true;
    }
  }
}
