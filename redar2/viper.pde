int maxdistrance=50;
int windowheight=450;
int windowlenth=640;
int cellsize=windowheight/maxdistrance;

int ang=0;
int side=1;
ArrayList<Integer> read_list=new ArrayList();
int maxlistcount=90;
int reading=255;

void drawAnim() {


  //stroke(0, 255, 0, 40);
  //for (int x=0; x<=windowheight*2; x+=cellsize) {
    //line(x, 0, x, windowheight*2);
  //}
  //for (int y=0; y<=windowheight*2; y+=cellsize) {
   // line(0, y, windowheight*2, y);
 // }

  int d_ang=ang;
  int d_dir=side*-1;

  for (int i=read_list.size()-1; i>-1; i--) {
    int d_angd=d_ang;
    double radient=Math.toRadians(d_angd+180);
    int r=read_list.get(i);
    int xg=windowheight-getX(radient, r);
    int yg=windowheight+getY(radient, r);
    int xg2=windowheight+getX(radient, r);
    int yg2=windowheight-getY(radient, r);


    stroke(0, 255, 0, i);
    line(windowlenth, windowheight, xg, yg);
    line(windowlenth, windowheight, xg2, yg2);


    r=windowheight;
    int xr=windowlenth-getX(radient, r);
    int yr=windowheight+getY(radient, r);
    int xr2=windowlenth+getX(radient, r);
    int yr2=windowheight-getY(radient, r);

    stroke(255, 0, 0, i*2);
    line(xg, yg, xr, yr);
    line(xg2, yg2, xr2, yr2);

    d_ang+=d_dir;
    if (d_ang<0) {
      d_dir=d_dir*-1;
      d_ang+=d_dir*2;
    }
    if (d_ang>180) {
      d_dir=d_dir*-1;
      d_ang+=d_dir*2;
    }
  }
}


int getX(double rang, double r) {
  return(int)(Math.cos(rang)*r);
}
int getY(double rang, double r) {
  return(int)(Math.sin(rang)*r);
}

String setLen(String in, int no) {
  String wrd="";
  int i=in.length();
  for (int j=0; j<no-i; j++) {
    wrd+="0";
  }
  wrd+=in;
  return wrd;
}
