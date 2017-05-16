import processing.pdf.*;

PFont cityFont;
PFont countryFont; 
int pgnum = 0; 

String path;

File[] files, imgfiles;  
int cityfontsize = 20; 
int countryfontsize = 20; 

String imgpath; 

void setup() {
  background(255); 
  smooth();
  fill(0); 

  cityFont = createFont("Courier New Bold.ttf", 48);
  countryFont = createFont("Courier New.ttf", 48); 

  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  size(540, 540, PDF, "earth.pdf");
 

  path = dataPath("")+"/txt/";
  files = listFiles(path);

  String sketchname = "/earthbook/";
  String imgpath = sketchPath("");
  imgpath = imgpath.substring(0, imgpath.length()-sketchname.length()) + "/imgs/";

  imgfiles = listFiles(imgpath);

  for (int i = 0; i < imgfiles.length; i++) { 
    println("on page "+ (i+1));
    String filename = imgfiles[i].getName(); 
    String[] filenamearr = split(filename, "~");

    String city = filenamearr[0];
    String country = filenamearr[1].substring( 0, filenamearr[1].length()-4 ).toUpperCase();

    PImage street = loadImage(imgpath+filename);
    
    //street.resize(0, int(height*0.5));

    textFont(cityFont, cityfontsize);
    text(city, width/2, height*0.8);

    textFont(countryFont, countryfontsize);
    text(country, width/2, height*0.85);

    image(street, width/2, height/2);

    if (i < imgfiles.length-1)
      goToNext();
  }

  exit();
} 
 
void goToNext() {
  PGraphicsPDF pdf = (PGraphicsPDF) g;
  pdf.nextPage();
}

//taken from http://processing.org/learning/topics/directorylist.html
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}