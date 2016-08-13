final class vector{
  double x,z;  
  vector(){
    x=0;
    z=0;
  }
}
final class tmline{
  double p,n;  
  tmline(){
    p=0;
    n=0;
  }
}
import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

import processing.serial.*;
Serial port;
String data="";
tmline yaw =new tmline();
tmline pitch= new tmline();
vector loc=new vector();
vector leng=new vector();
//mouse m=new mouse();
int cnt=0;double offp=0,offy=0,flg=0,y1=0,x1=0,x2=0,y2=0;




double hd_rad=13;      //Remember hand Radius


//Adds given vectors
final vector add_vector(vector v1,vector v2){
  vector v3=new vector();
  v3.x=v1.x+v2.x;
  v3.z=v1.z+v2.z;
  return(v3);  
}


void mPress(int a){
  try{
  Robot r=new Robot();
  r.mousePress(a);
  }catch(Exception e){
  }
}

void mRelease(int a){
  try{
  Robot r=new Robot();
  r.mouseRelease(a);
  }catch(Exception e){}
}



void setup(){
  
  port=new Serial(this,"COM8",57600);
  port.bufferUntil('\n');
  
}


void draw(){
   
 
  try{
  if(cnt>1){
pitch.n-=offp;
yaw.n-=offy;
if (yaw.n>-50&&yaw.n<50)System.out.println("yaw = "+yaw.n);//+" offp "+offp+" offy "+offy);
  Robot r=new Robot();

//pitch.n=constrain((float)pitch.n,-25,15);
//yaw.n=constrain((float)yaw.n,-25,25);
y2=(map((float)pitch.n,-25,25,0,768));                   //Remember Correction

x2=(map((float)yaw.n,-25,20,0,1366));                    //Remember Correction

  if(flg==0){
  x1=x2;
  y1=y2;
  flg=1;
}
x2=(.2*x1+.8*x2);
y2=(.2*y1+.8*y2);

if (yaw.n>-50&&yaw.n<50){
    if((((yaw.n-yaw.p)>0?(yaw.n-yaw.p):-(yaw.n-yaw.p))>.2) &&((pitch.n-pitch.p)>0?(pitch.n-pitch.p):-(pitch.n-pitch.p))>.10 ){
      if(yaw.n>6){
        r.keyRelease(KeyEvent.VK_H);
        r.keyPress(KeyEvent.VK_G);
        
      }else if(yaw.n<-6){
        r.keyRelease(KeyEvent.VK_G);
        r.keyPress(KeyEvent.VK_H);
      }else{
        r.keyRelease(KeyEvent.VK_G);
        r.keyRelease(KeyEvent.VK_H);
      }
    
    
    
    }
}
    //r.mouseMove(1024/2,768/2);
    //{
    //  if(yaw.n>-25&&yaw.n<-13){
    //    r.mouseMove(((int)((map((float)-21,-25,20,0,1366)))),(int)(y2));
    //  }if(pitch.n>-25&&pitch.n<-13){
    //     r.mouseMove(((int)(x2)),(int)((map((float)-16,-25,20,20,1346))));
    //  }if(yaw.n>10&&yaw.n<20){
    //    r.mouseMove(((int)((map((float)21,-25,20,0,1366)))),(int)(y2));
    //  }if(pitch.n>10&&pitch.n<25){
    //     r.mouseMove(((int)(x2)),(int)((map((float)16,-25,20,20,1346))));
    //  }else{
    //    r.mouseMove(((int)(1366/2)),(int)((50/2)));
    //  }
        
      
    ////r.mouseMove(((int)(x2)),(int)(y2));

    //}
  pitch.p=pitch.n;
  yaw.p=yaw.n;
  //System.out.println("pitch = "+pitch.n+" yaw = "+yaw.n);
}else if(cnt<1){               //for adjusting yaw
      offp=pitch.n;
      offy=yaw.n;
    
      System.out.println("hello "+cnt+" offp "+offp+" offy "+offy);
      if((offp!=0)&&(offy!=0))++cnt;
    }else{
      
      offp=(int)offp;
      offy=(int)offy;
      ++cnt;
      
      
      
    }
  }catch(Exception e){}
  flush();
}


void serialEvent(Serial port){
 try{ data = port.readStringUntil('\n');
  //System.out.println(data);
  if((data.substring(0,data.indexOf(" "))).equals("pitch")){
  
  data=data.substring(0,data.length()-1);
  //System.out.println(data);
  int index=data.lastIndexOf(',');   //Remember correction
  //System.out.println(index);
  pitch.n=-1*Double.parseDouble(data.substring(8,index));
 
  data=data.substring(index+1);
  //System.out.println(data);
  yaw.n=Double.valueOf(data.substring(6,data.length()-2));
 // System.out.println(yaw.n);
  yaw.n=yaw.n;
  //yaw.n/=2;
  }
  else if((data.substring(0,data.indexOf(" "))).equals("left"))
  {
    switch(Integer.valueOf(data.substring(5,6)))
    {
      case 1:
      mPress(InputEvent.BUTTON1_MASK);
      break;
      case 0:
      mRelease(InputEvent.BUTTON1_MASK);
      break;
    }
    
  }
  else
  {
    switch(Integer.valueOf(data.substring(6,7)))
    {
      case 1:
      mPress(InputEvent.BUTTON3_MASK);
      break;
      case 0:
      mRelease(InputEvent.BUTTON3_MASK);
      break;
    }
  }
  delay(2);  
 }
 catch(Exception e){}
 delay(0);
}