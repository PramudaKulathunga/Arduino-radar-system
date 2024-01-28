
import processing.serial.*;
import static javax.swing.JOptionPane.*;

Serial myPort;        // The serial port
String serialin;
int data[] = new int[360];
PFont f;

final boolean debug = true;


void setup() {
  String COMx, COMlist = "";
  size(1280, 900);
  smooth();
  f = createFont("Verdana", 32, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 20);
  frameRate(60);
  for (int i = 0; i < 360; i++) {
    data[i] = 0;
  }
  try {
    if (debug) printArray(Serial.list());
    int i = Serial.list().length;
    if (i != 0) {
      if (i >= 2) {
        // need to check which port the inst uses -
        // for now we'll just let the user decide
        for (int j = 0; j < i; ) {
          COMlist += char(j+'a') + " = " + Serial.list()[j];
          if (++j < i) COMlist += ",  ";
        }
        COMx = showInputDialog("Which COM port is correct? (a,b,..):\n"+COMlist);
        if (COMx == null) exit();
        if (COMx.isEmpty()) exit();
        i = int(COMx.toLowerCase().charAt(0) - 'a') + 1;
      }
      String portName = Serial.list()[i-1];
      if (debug) println(portName);
      myPort = new Serial(this, portName, 9600); // change baud rate to your liking
      myPort.bufferUntil('\n'); // buffer until CR/LF appears, but not required..
    } else {
      showMessageDialog(frame, "Device is not connected to the PC");
      exit();
    }
  }
  catch (Exception e)
  { //Print the type of error
    showMessageDialog(frame, "COM port is not available (may\nbe in use by another program)");
    println("Error:", e);
    exit();
  }
}


void draw() {

  background(26, 26, 36, 200);
  textSize(18);
  stroke(255, 255, 255, 150);
  fill(255, 50, 200, 255);
  text("2D REDAR SYSTEM", 20, 30);
  text("Port : COM4", 20, 50);
  text("TIME", 980, 890);
  text(hour(), 1050, 890);
  text(":", 1075, 890);
  text(minute(), 1085, 890);
  text(":", 1110, 890);
  text(second(), 1120, 890);
  fill(174, 174, 174, 50);
  strokeWeight(2);
  circle(640, 450, 800);
  circle(640, 450, 720);
  circle(640, 450, 640);
  circle(640, 450, 560);
  circle(640, 450, 480);
  circle(640, 450, 400);
  circle(640, 450, 320);
  circle(640, 450, 240);
  circle(640, 450, 160);
  circle(640, 450, 80);
  fill(0, 0, 255, 255);
  text("10cm", 617, 495);
  text("20cm", 617, 535);
  text("30cm", 617, 575);
  text("40cm", 617, 615);
  text("50cm", 617, 655);
  text("60cm", 617, 695);
  text("70cm", 617, 735);
  text("80cm", 617, 775);
  text("90cm", 617, 815);
  text("100cm", 610, 855); // Topic,Area,Time

  for (int i = 0; i < 360; i++) {
    fill(255, 10, 255, 200);
    stroke(255, 0, 0, 3000);
    point(float(640) +  (map_values(data[i]))*cos(radians(i)), float(450) + (map_values(data[i]))*sin(radians(i)));
  }

  while (myPort.available() > 0) {
    serialin = myPort.readStringUntil(10);
    try {
      String serialdata[] = splitTokens(serialin, ",");
      if (serialdata[0] != null) {
        serialdata[0] = trim(serialdata[0]);
        serialdata[1] = trim(serialdata[1]);
        serialdata[2] = trim(serialdata[2]);

        int i = int(serialdata[0]);
        data[179-i] = int(serialdata[1]);
        data[(179-i)+180] = int(serialdata[2]);
      }
    } 
    catch (java.lang.RuntimeException e) {
    }
  }
    
   if (reading>-1) {
    ang+=side;

    if (ang<0) {
      side=1;
    } else if (ang>180) {
      side=-1;
    }

    read_list.add(reading*cellsize);
    if (maxlistcount<read_list.size()) {
      read_list.remove(0);
    }

    drawAnim();
  }

  
  
}

float map_values(float x) {
  float in_min = 0, in_max = 200, out_min = 0, out_max = 700;
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
