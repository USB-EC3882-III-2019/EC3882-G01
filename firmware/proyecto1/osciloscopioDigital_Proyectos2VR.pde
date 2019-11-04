//ROJO CLARO(255,0,0),ROJO OSCURO(125,0,0),VERDE CLARO(0,255,0),VERDE OSCURO(0,125,0),AMARILLO CLARO(255,255,0),AMARILLO OSCURO(125,125,0),FUCSIA CLARO(247,49,190),FUCSIA OSCURO(189,7,137),
import processing.serial.*;        //se inicializa el puerto serial

byte lectura_datos[];

float ts = 1;           // timescale: 1 = 50ms, 5 = 10ms, 10 = 5ms, 50 = 1ms, 100 = 500us, 500 = 100us, 1000 = 50us
int CA1_vd = 10;      // analogic 1 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int CA2_vd = 10;      // analogic 2 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int CD1_vd = 10;      // digital 1 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int CD2_vd = 10;      // digital 2 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div

int [] canal;
int [] analog1;     // arreglo respectivo al canal analogico 1
int [] analog2;     // arreglo respectivo al canal analogico 2
int [] digital1;    // arreglo respectivo al canal digital 1
int [] digital2;    // arreglo respectivo al canal digital 2

int CA1PosX=950, CA1PosY=150;
int CA2PosX=950, CA2PosY=250;
int CD1PosX=950, CD1PosY=350;
int CD2PosX=950, CD2PosY=450;

int CA1divPosX=1035, CA1divPosY=150;
int CA2divPosX=1035, CA2divPosY=250;
int CD1divPosX=1035, CD1divPosY=350;
int CD2divPosX=1035, CD2divPosY=450;
  
int resetPosX=1170, resetPosY=300;

int CHBSize = 40;      // Tamaño del boton CH
int VDBSize = 40;      // Tamaño del boton VD
int TDBSize = 70;      // Tamaño del boton TD

color CA1Color, CA2Color, CD1Color, CD2Color, VD_A1Color, VD_A2Color, VD_D1Color, VD_D2Color, resetColor, baseColor;
color CA1_Highlight;           // Indicador de estar sobre un boton de los canales
color CA2_Highlight;
color CD1_Highlight;
color CD2_Highlight;

color CA1div_Highlight;           // Indicador de estar sobre un boton de voltios por division de cada canal
color CA2div_Highlight;
color CD1div_Highlight;
color CD2div_Highlight;
color ResetButton_Highlight;

color currentColor;

boolean button_CA1Over = false;      // booleano indicativo de si el puntero se encuentra sobre el boton del canales y digitales
boolean button_CA2Over = false;      
boolean button_CD1Over = false;      
boolean button_CD2Over = false; 

boolean button_divCA1Over=false;    //botones de la division de los canales analogicos y digitales
boolean button_divCA2Over=false;
boolean button_divCD1Over=false;
boolean button_divCD2Over=false;

boolean button_ResetOver = false;      // booleano indicativo de si el puntero se encuentra sobre el boton de time/div 1

boolean button_CA1ON =false;     //botones de los canales analogicos y digitales
boolean button_CA2ON=false;
boolean button_CD1ON=false;
boolean button_CD2ON=false;

int i = 0;          // variable de control indicativa de la posicion a llenar de los arreglos
int j = 0;          // variable de control indicativa de los arreglos con data para mostrar 

PImage screen;

Serial myPort;  // Crea un objeto de clase serial

void setup(){
  size (1280,800);
  background (#373636);
  
  CA1Color = color(125,0,0);         // Color del boton del canal 1
  CA2Color = color(0,125,0);         // Color del boton del canal 2
  CD1Color = color(125,125,0);         // Color del boton del canal 3
  CD2Color = color(189,7,137);         // Color del boton del canal 4
  VD_A1Color = color(125,0,0);       // Color del boton del Volt/Div 1
  VD_A2Color = color(0,125,0);       // Color del boton del Volt/Div 2
  VD_D1Color = color(125,125,0);       // Color del boton del Volt/Div 3
  VD_D2Color = color(189,7,137);       // Color del boton del Volt/Div 4
  resetColor = color(#BFBBBB);          // Color del boton del Time/Div 1
  
  CA1_Highlight = color(255,0,0);       // Indicador de posicion sobre uno de los botones
  CA2_Highlight = color(0,255,0);
  CD1_Highlight = color(255,255,0);
  CD2_Highlight = color(247,49,190);
  
  CA1div_Highlight = color(255,0,0);       // Indicador de posicion sobre uno de los botones
  CA2div_Highlight = color(0,255,0);
  CD1div_Highlight = color(255,255,0);
  CD2div_Highlight = color(247,49,190);
  
  ResetButton_Highlight = color(#BFBBBB);
   
  int CA1PosX=950, CA1PosY=150;
  int CA2PosX=950, CA2PosY=250;
  int CD1PosX=950, CD1PosY=350;
  int CD2PosX=950, CD2PosY=450;

  int CA1divPosX=1015, CA1divPosY=130;
  int CA2divPosX=1015, CA2divPosY=230;
  int CD1divPosX=1015, CD1divPosY=330;
  int CD2divPosX=1015, CD2divPosY=430;
  
  int resetPosX=1170, resetPosY=300;
  
 //Texto
  
  
  pantalla();
  screen = get(0,0,900,800);
  
  ellipseMode(CENTER); 
  
  lectura_datos = new byte[5];  
  canal = new int[5];
  analog1 = new int[1000];
  analog2 = new int[1000];
  digital1 = new int[1000];
  digital2 = new int[1000];
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
  myPort.buffer(1000);
  image(screen,0,0);
}

void draw() {
  textSize(25);
    fill(255);
    text("Principal", 1020, 530);
  textSize(20);
    fill(255);
    text("Canales", 910, 100);  
  textSize(40);
    fill(255);
    text("Osciloscopio", 950, 620);
  textSize(15);
    fill(255);
    text("By HUNG_ELECTRONICS", 990, 650);
  textSize(20);
    fill(255);
    text("T/D", 1153, 360);
  textSize(20);
    fill(255);
    text("Escalas",1000,100);
  textSize(15);
  fill(255);
    text("CA1",935,190);
  fill(255);
    text("CA2",935,290);
  fill(255);
    text("CD1",935,390);
  fill(255);
    text("CD2",935,490);
  fill(255);
    text("(V/D)CA1",1000,190);
  fill(255);
    text("(V/D)CA2",1000,290);
  fill(255);
    text("(V/D)CD1",1000,390);
  fill(255);
    text("(V/D)CD2",1000,490);
  fill(255);
   
  Estado_clickbutton();
 
  if (j == 1){
    image(screen,0,0);            // Limpia la pantalla
    Estatus_escalas();
    
    if(button_CA1ON == true)
      Analog1();
      
    if(button_CA2ON == true)  
      Analog2();
      
    if(button_CD1ON == true)  
      Digital1();
      
    if(button_CD2ON == true)  
      Digital2();      
      
    myPort.clear();               // Limpieza del buffer del puerto serial
    i = 0;                        // Reset de los arreglos que guardan los datos desempaquetados
    j = 0;                        // Variable de control que activa la recepcion de datos y deshabilita la opcion de graficar
  } 
}
  
void mousePressed()
{
  if(button_CA1Over){
    if(button_CA1ON == false){
      button_CA1ON=true;
    }else{
      button_CA1ON=false;
    }
  }
  
  if(button_CA2Over){
    if(button_CA2ON == false){
      button_CA2ON=true;
    }else{
      button_CA2ON=false;
    }
  }
  
  if(button_CD1Over){
    if(button_CD1ON == false){
      button_CD1ON=true;
    }else{
      button_CD1ON=false;
    }
  }
  
  if(button_CD2Over){
    if(button_CD2ON == false){
      button_CD2ON=true;
    }else{
      button_CD2ON=false;
    }
  }
  
   if (button_divCA1Over) {  
     if(button_CA1ON == true) {
      if(CA1_vd == 10)
        CA1_vd = 5;
      else if (CA1_vd == 5)
        CA1_vd = 2;
      else if (CA1_vd == 2)
        CA1_vd = 20;
      else if (CA1_vd == 20)
        CA1_vd = 10;   
    }
   }
    
    if (button_divCA2Over) {  
     if(button_CA2ON == true) {
      if(CA2_vd == 10)
        CA2_vd = 5;
      else if (CA2_vd == 5)
        CA2_vd = 2;
      else if (CA2_vd == 2)
        CA2_vd = 20;
      else if (CA2_vd == 20)
        CA2_vd = 10;   
    }
   }
    
   if (button_divCD1Over) {  
     if(button_CD1ON == true) {
      if(CD1_vd == 10)
        CD1_vd = 5;
      else if (CD1_vd == 5)
        CD1_vd = 2;
      else if (CD1_vd == 2)
        CD1_vd = 20;
      else if (CD1_vd == 20)
        CD1_vd = 10;   
    }
   }
   
    if (button_divCD2Over) {  
     if(button_CD2ON == true) {
      if(CD2_vd == 10)
        CD2_vd = 5;
      else if (CD2_vd == 5)
        CD2_vd = 2;
      else if (CD2_vd == 2)
        CD2_vd = 20;
      else if (CD2_vd == 20)
        CD2_vd = 10;   
    }
   }
    
  if (button_ResetOver) {                   // Comprobacion de que el boton del mouse fue presionado encima del boton del time division
     if(ts == 1)                 // Cambio de los valores del voltage division
        ts = 2.5;
      else if (ts == 2.5)
        ts= 5;
      else if (ts == 5)
        ts = 25;  
      else if (ts == 25)
        ts = 50; 
      else if (ts == 50)
        ts = 1;         
    }  
}
  
boolean overCircle(int x, int y, int diameter) {    //  Funcion que le permite identificar si el puntero esta sobre uno de los botones
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
} 

void update(int x, int y) {                      // Funcion que permite comprobar la posicion del puntero del raton respecto al area de los botones
  if ( overCircle(CA1PosX, CA1PosY, CHBSize) ) {
    button_CA1Over = true;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
       
  } else if ( overCircle(CA2PosX, CA2PosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = true;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CD1PosX, CD1PosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = true;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CD2PosX, CD2PosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = true;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CA1divPosX,CA1divPosY, CHBSize) ) {
   button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = true;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CA2divPosX, CA2divPosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = true;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CD1divPosX, CD1divPosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = true;
    button_divCD2Over = false;
    button_ResetOver = false;
    
  } else if ( overCircle(CD2divPosX, CD2divPosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = true;
    button_ResetOver = false;
    
  } else if ( overCircle(resetPosX, resetPosY, CHBSize) ) {
    button_CA1Over = false;
    button_CA2Over = false;
    button_CD1Over = false;
    button_CD2Over = false;
    button_divCA1Over = false;
    button_divCA2Over = false;
    button_divCD1Over = false;
    button_divCD2Over = false;
    button_ResetOver = true;
  } else {
    button_CA1Over=button_CA2Over=button_CD1Over=button_CD2Over=button_divCA1Over=button_divCA2Over=button_divCD1Over=button_divCD2Over=button_ResetOver=false;
  }
  
}

void  Estado_clickbutton(){

  update(mouseX, mouseY);       // Comprueba el estado de la posicion del puntero respecto a los botones
  
 // seccion para el dibujo de los botones
  
  if (button_CA1Over) {
    fill(CA1_Highlight);
  } else {
    fill(CA1Color);
  }
  stroke(255);
  ellipse(CA1PosX, CA1PosY, CHBSize, CHBSize);
  
  if (button_CA2Over) {
    fill(CA2_Highlight);
  } else {
    fill(CA2Color);
  }
  stroke(255);
  ellipse(CA2PosX, CA2PosY, CHBSize, CHBSize);
  
    if (button_CD1Over) {
    fill(CD1_Highlight);
  } else {
    fill(CD1Color);
  }
  stroke(255);
  ellipse(CD1PosX, CD1PosY, CHBSize, CHBSize);
  
  if (button_CD2Over) {
    fill(CD2_Highlight);
  } else {
    fill(CD2Color);
  }
  stroke(255);
  ellipse(CD2PosX, CD2PosY, CHBSize, CHBSize);
  
   if (button_divCA1Over) {
    fill(CA1div_Highlight);
  } else {
    fill(VD_A1Color);
  }
  stroke(255);
  ellipse(CA1divPosX, CA1divPosY, VDBSize+15,VDBSize);
  
 
    if (button_divCA2Over) {
    fill(CA2div_Highlight);
  } else {
    fill(VD_A2Color);
  }
  stroke(255);
  ellipse(CA2divPosX, CA2divPosY, VDBSize+15, VDBSize);
  
    if (button_divCD1Over) {
    fill(CD1div_Highlight);
  } else {
    fill(VD_D1Color);
  }
  stroke(255);
  ellipse(CD1divPosX,CD1divPosY, VDBSize+15, VDBSize);
  
    if (button_divCD2Over) {
    fill(CD2div_Highlight);
  } else {
    fill(VD_D2Color);
  }
  stroke(255);
  ellipse(CD2divPosX, CD2divPosY, VDBSize+15, VDBSize);
  
    if (button_ResetOver) {
    fill(ResetButton_Highlight);
  } else {
    fill(125);
  }
  stroke(255);
  ellipse(resetPosX, resetPosY, TDBSize, TDBSize);

}

void Estatus_escalas(){   // Funciones que ponen en pantalla el valor de las escalas de tiempo y voltaje de los canales activos
    
    textSize(17);
    fill(255);
    text("Time:",70,670);
    
    if(ts == 1)
      text("50ms",70,695);
    if(ts == 2.5)
      text("10ms",70,695);
    if(ts == 5)
      text("5ms",70,695);
    if(ts == 25)
      text("1ms",70,695);
    if(ts == 50)
      text("500us",70,695);
      
    fill(255,0,0);
    text("CA1:",170,670);
    
    if(button_CA1ON == false)
      text("OFF",170,695);
    if(button_CA1ON == true && CA1_vd == 10)
      text("1V/Div",170,695);
    if(button_CA1ON == true && CA1_vd == 5)
      text("2V/Div",170,695);
    if(button_CA1ON == true && CA1_vd == 2)
      text("5V/Div",170,695);
    if(button_CA1ON == true && CA1_vd == 20)
      text("0.5V/Div",170,695); 
 
    fill(0,255,0);
    text("CA2:",270,670);      
      
    if(button_CA2ON == false)
      text("OFF",270,695);
    if(button_CA2ON == true && CA2_vd == 10)
      text("1V/Div",270,695);
    if(button_CA2ON == true && CA2_vd == 5)
      text("2V/Div",270,695);
    if(button_CA2ON == true && CA2_vd == 2)
      text("5V/Div",270,695);
    if(button_CA2ON == true && CA2_vd == 20)
      text("0.5V/Div",270,695);      
  
    fill(255,255,0);
    text("CD1:",370,670);      
      
    if(button_CD1ON == false)
      text("OFF",370,695);
    if(button_CD1ON== true && CD1_vd == 10)
      text("1V/Div",370,695);
    if(button_CD1ON == true && CD1_vd == 5)
      text("2V/Div",370,695);
    if(button_CD1ON == true && CD1_vd == 2)
      text("5V/Div",370,695);
    if(button_CD1ON == true && CD1_vd == 20)
      text("0.5V/Div",370,695);  
      
    fill(247,49,190);
    text("CD2:",470,670);      
      
    if(button_CD2ON == false)
      text("OFF",470,695);
    if(button_CD2ON == true && CD2_vd == 10)
      text("1V/Div",470,695);
    if(button_CD2ON == true && CD2_vd == 5)
      text("2V/Div",470,695);
    if(button_CD2ON == true && CD2_vd == 2)
      text("5V/Div",470,695);
    if(button_CD2ON == true && CD2_vd == 20)
      text("0.5V/Div",470,695);     
}

//void grafica(){
  void serialEvent(Serial myPort){
 if ((myPort.available() > 0) && (j == 0)) {
    do {
    lectura_datos[0] = byte(myPort.read());
    } while (int(lectura_datos[0]) < 255);
    lectura_datos[1] = byte(myPort.read());
    lectura_datos[2] = byte(myPort.read());
    lectura_datos[3] = byte(myPort.read());
    lectura_datos[4] = byte(myPort.read());
 } 
 if (j == 0){
    desempaquetado();
    print(" ( "+ int(lectura_datos[0]) + " "+ int(lectura_datos[1]) +" "+ int(lectura_datos[2]) +" "+ int(lectura_datos[3]) +" ) ");
 } 
 
}

void desempaquetado(){
  int[] aux = new int[2];
 
  aux[0] = lectura_datos[1] & 15;
  aux[0] = aux[0] << 8;
  aux[1] = lectura_datos[2] & 255;
  canal[0] = (aux[0] + aux[1])/13;       // Canal Analogico 1 Listo
  
  aux[0] = lectura_datos[3] & 15;
  aux[0] = aux[0] << 8;
  aux[1] = lectura_datos[4] & 255;
  canal[1] = (aux[0] + aux[1])/13;     // Canal Analogico 2 Listo
  
  aux[0] = lectura_datos[1] & 16;
  canal[2] = aux[0]*10;                  // Canal Digital 1 listo
  
  aux[0] = lectura_datos[3] & 16;
  canal[3] = aux[0]*10;                  // Canal Digital 2 listo
 //print(" ( "+ aux[0]);
 
  analog1[i] = canal[0];                 // Guardo los datos desempaquetados en sus respectivas variables para graficar 
  analog2[i] = canal[1]; 
  digital1[i] = canal[2]; 
  digital2[i] = canal[3]; 
  i = i + 1;
  
  if (i > 799) {                         // Condicion que define cuando ya este lleno el vector para graficar
     j = 1;                              // Variable de control que me permite graficar en pantalla los canales activos y detiene la recepcion de datos 
   }
   
}

void Analog1() {
  for (int x = 0; x < 799; x += 1)  {
       stroke(color(255,0,0));
     if ((x*ts)+50 < 849)
       line((x*ts)+50, 350 - analog1[x]*CA1_vd/25, ((x+1)*ts)+50, 350 - analog1[(x+1)]*CA1_vd/25); 
           }
}

void Analog2() {
  for (int x = 0; x < 799; x += 1)  {
       stroke(color(0,255,0));
     if ((x*ts)+50 < 849)
       line((x*ts)+50, 350 - analog2[x]*CA2_vd/10, ((x+1)*ts)+50, 350 - analog2[(x+1)]*CA2_vd/10); 
           }
}

void Digital1() {
  for (int x = 0; x < 799; x += 1)  {
       stroke(color(255,255,0));
     if ((x*ts)+50 < 849)
       line((x*ts)+50, 350 - digital1[x]*CD1_vd/25, ((x+1)*ts)+50, 350 - digital1[(x+1)]*CD1_vd/25); 
           }
}

void Digital2() {
  for (int x = 0; x < 799; x += 1)  {
       stroke(color(247,49,190));
     if ((x*ts)+50 < 849)
       line((x*ts)+50, 350 - digital2[x]*CD2_vd/12, ((x+1)*ts)+50, 350 - digital2[(x+1)]*CD2_vd/12);
           }
}

void pantalla(){         //Funcion para definir la pantalla del osciloscopio
  stroke(255);           //Se establece el borde de la pantalla del osciloscopio de color blanca
  fill(2,23,70);               //La pantalla se establece de color azul
  rect(50,50, 800, 600); //Se dibuja un rectangulo (pantalla osciloscopio)
  
  stroke(255);           //Se establece el borde de la pantalla del osciloscopio de color blanca
  fill(100);               //La pantalla se establece de color negro
  rect(900,50,330, 500); //Se dibuja un rectangulo (pantalla osciloscopio)
  
  for(int y=50; y<=650; y+=50){ //Divisiones horizontales (cuadricula)
    for (int x=50; x<=850; x+=10){
      stroke(255);
      line(x-1,y,x+1,y);
    }
  }
  for(int y=50; y<=650; y+=10){
    for (int x=50; x<=850; x+=50){  //Divisiones verticales (cuadricula)
      stroke(255);
      line(x,y-1,x,y+1);
    }
  }
  for(int y=50; y<=650; y+=10){   //Divisiones eje de x(t)
    for (int x=50; x<=850; x+=10){    //Divisiones eje de tiempo
      stroke(255);
      line(445,y,455,y);
      line(x,345,x,355);
    }
  }
}
