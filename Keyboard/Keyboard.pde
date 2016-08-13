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
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

import processing.serial.*;
Serial port;
String data="";
//tmline yaw =new tmline();
//tmline pitch= new tmline();
//vector loc=new vector();
//vector leng=new vector();
////mouse m=new mouse();
//double off[]=new double[100];
//int cnt=0,fw=0,fa=0,fs=0,fd=0,cn=0;
//double offset=0,oax=0,oay=0,oaz=0;
//double ax=0,ay=0,az=0;

double roll,pitch;


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
  
  port=new Serial(this,"COM11",57600);
  port.bufferUntil('\n');
  
}

void draw(){
 try{
   
   Robot r=new Robot();
   if(roll>18&&pitch>-4){
     r.keyRelease(KeyEvent.VK_S);
     r.keyPress(KeyEvent.VK_W);
   }else if(roll<-15&&pitch<-5){
     r.keyRelease(KeyEvent.VK_W);
     r.keyPress(KeyEvent.VK_S);
   }else if(pitch>15){
     r.keyRelease(KeyEvent.VK_A);
     r.keyPress(KeyEvent.VK_D);
   }else{
     r.keyRelease(KeyEvent.VK_W);
     r.keyRelease(KeyEvent.VK_D);
    r.keyRelease(KeyEvent.VK_S);
    r.keyRelease(KeyEvent.VK_A);
     
   }
 
 
 
 }catch(Exception e){}  
  
  
  
 //if(ax>=.06){
 //     if(fs==0){
 //       r.keyPress(KeyEvent.VK_S);
 //     fw=1;
 //     }else{
 //       cn=20;fs=0;
 //     }
  
 // }else if(ay>=.10){
 // r.keyPress(KeyEvent.VK_A);
//}//else if(ax<=-.09){
 // if(fw==0){
 // r.keyPress(KeyEvent.VK_W);
 // fs=1;
//}//else{
 // cn=20;fw=0;
//}//


//}//else if(ay<=-.10){
 // r.keyPress(KeyEvent.VK_D);


//}////else if(ax>.18){
////  r.keyPress(KeyEvent.VK_SHIFT);
////  r.keyPress(KeyEvent.VK_W);
////}
//e//lse{
 // r.keyRelease(KeyEvent.VK_W);
 // r.keyRelease(KeyEvent.VK_D);
 // r.keyRelease(KeyEvent.VK_S);
 // r.keyRelease(KeyEvent.VK_A);
 // r.keyRelease(KeyEvent.VK_SHIFT);
//}//
  
 
 // pitch.p=pitch.n;
 // yaw.p=yaw.n;
 //// if(yaw.n<0){   //yaw
 //  // yaw.n=360+yaw.n;
 //// }
 // }else{
 //       --cn;
 //     }
 //   }else if(cnt<100){               //for adjusting yaw
 //     off[cnt]=yaw.n;
 //     oax+=ax;
 //     oay+=ay;
 //     oaz+=az;
 //     System.out.println("hello "+cnt);
 //     ++cnt;
 //   }else{
 //     for(int i=0;i<100;i++){
 //       offset+=off[i];
 //     }
 //     oax/=100;
 //     oay/=100;
 //     oaz/=100;
 //     offset/=100.0;
 //     ++cnt;
      
      
      
 //   }
      
 //   }catch(Exception e){}
 
  
  
  
 //// System.out.println(data);
 // flush();


}


void serialEvent(Serial port){
 try{ data = port.readStringUntil('\n');
 // System.out.println(data);
 
  
  data=data.substring(0,data.length()-1);
  //System.out.println(data);
  int index=data.lastIndexOf(',');   //Remember correction
  //System.out.println(index);
  pitch=Double.parseDouble(data.substring(8,index));
  
  
  data=data.substring(index+1);
 //System.out.println(data);
  roll=Double.valueOf(data.substring(7,data.length()-2));
  //System.out.println(yaw.n);

 
 }catch(Exception e){}
 
}