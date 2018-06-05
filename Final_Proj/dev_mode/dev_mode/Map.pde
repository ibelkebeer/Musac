import processing.sound.*;
import java.util.*;
public class Map{
  private Line[] game;
  private String name;
  private String path;
  private int size;
  private float bpm;
  private SoundFile sample;
  private SoundFile hit;
  private PrintWriter output;
  public Map(SoundFile sample,SoundFile effect,float bpm,String name){
    game = new Line[int(bpm * sample.duration() * 8) + 100];
    for(int i=0; i<game.length; i++){
      game[i] = new Line();
    }
    this.bpm = bpm;
    this.name = name + ".txt";
    size = 7200 / int(bpm);
    this.sample = sample;
    hit = effect;
  }
  public void play(){
    sample.play();
  }
  public void jump(float time){
    sample.jump(time);
  }
  public void stop(){
    sample.stop();
  }
  public void rate(float speed){
    sample.rate(speed);
  }
  public int size(){
    return size;
  }
  public float bpm(){
    return bpm;
  }
  public void setD(int row,int val){
    game[row].setD(val);
  }
  public void setF(int row,int val){
    game[row].setF(val);
  }
  public void setJ(int row,int val){
    game[row].setJ(val);
  }
  public void setK(int row,int val){
    game[row].setK(val);
  } 
  public Line getLine(int row){
    return game[row];
  }
  public void hit(){
    hit.play();
  }
  public void save(){
    output = createWriter(name);
    for(int i=0; i<60; i++){
      output.println("0 0 0 0");
    }
    for(int i=0; i<game.length; i++){
      output.println(game[i].getD() + " " + game[i].getF() + " " + game[i].getJ() + " " + game[i].getK());
    }
    output.flush();
    output.close();
  }
  public void load(){
    path = sketchPath(name);
    File f = new File(path);
    if(f.exists()){
    try{
      BufferedReader reader = createReader(name);
      for(int i=0; i<60; i++){
        reader.readLine();
      }
      int i = 0;
      String line;
      while((line = reader.readLine()) != null){
        String[] notes = split(line,' ');
        for(int j=0; j<4; j++){
          if(int(notes[j]) == 1){
            if(j == 0){
              game[i].setD(1);
            }
            if(j == 1){
              game[i].setF(1);
            }
            if(j == 2){
              game[i].setJ(1);
            }
            if(j == 3){
              game[i].setK(1);
            }
          }
        }
        i++;
      }
    }catch(IOException e){
    }
    }
  }
}
