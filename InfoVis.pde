
FlipImage[] flips;
PImage[] portraits;
Table infoTable;
int margin_top = 50, margin_left = 150, image_size = 170, gap = 10;
int margin_top0 = 150;

void setup(){
  
  fullScreen();
  
  infoTable = loadTable("presidentInfo.csv");
  loadFlips();
  //loadPortraits();
  
  //transformToSquare();
  //downloadImages();
  //images already in local
}

void draw(){
  //for(int j = 0; j < 5; j++){
  //  for(int i = 0; i < 9; i++){
  //   image(flips[i + j * 9].portrait, margin_left + (image_size + gap) * i, margin_top + (image_size + gap) * j, image_size, image_size); 
  //  }
  //}
  background(0);
  for(int i = 0; i < 45; i++){
    if(flips[i].selected(mouseX,mouseY)){
      fill(255);
      textSize(40);
      textAlign(CENTER);
      flips[i].drawFrame();
      if(i == 42)
      {
        textSize(30);
        text(flips[i].trivia.substring(0, 100), width / 2, margin_top + 2.4 * image_size);
        text(flips[i].trivia.substring(100), width / 2, margin_top + 2.6 * image_size);
      }
      else
        text(flips[i].trivia, width / 2, margin_top + 2.5 * image_size);
    }
    flips[i].drawFlip();
  }
}

public void loadFlips(){
  flips = new FlipImage[45];
  for(int i = 0; i < 45; i++){
    flips[i] = new FlipImage();
    flips[i].id = infoTable.getInt(i+1, 0);
    flips[i].name = infoTable.getString(i+1,1);
    flips[i].wiki = infoTable.getString(i+1,2);
    flips[i].tookOffice = infoTable.getString(i+1,3);
    flips[i].leaveOffice = infoTable.getString(i+1,4);
    flips[i].party = trim(infoTable.getString(i+1,5));
    flips[i].setPartyColor(flips[i].party);
    flips[i].birthState = infoTable.getString(i+1,7);
    flips[i].trivia = infoTable.getString(i+1,8);
    flips[i].age = infoTable.getString(i+1,9);
    flips[i].setIndex(i+1);
    println(flips[i].id + flips[i].name + flips[i].trivia);
    
    flips[i].portrait = loadImage(i+"-.jpg");
  }
}

void mousePressed(){
  println("mousePressed!");
  for(int i = 0; i < 45; i++){
    if(flips[i].selected(mouseX, mouseY)){
      flips[i].flip();
      println(i + " " + flips[i].front);
      break;
    }
  }
}







public void loadPortraits(){
  portraits = new PImage[45];
  for(int i = 0; i < 45; i++){
    try{
      portraits[i] = loadImage(i+"-.jpg");
    }catch(Exception e1){
      try{
        portraits[i] = loadImage(i+1+"-.png");
      }catch(Exception e2){
        portraits[i] = loadImage(i+1+"-.tif");
      }
    }
    
  }
}

// This method is written to read all the presidents pictures to local for convenience
// Did not use loadImage(url) directly because the url in the csv given can not be used to fetch a image directly
// so I fetch the page, parse it and pick out the real image url from the page content and download the images
// The method work well for most presidents expect 32 Roosevelt and 43 Bush, because their page urls are different from others
// So I used the method to download the rest, and download Roosevelt and Bush images manually

public void downloadImages(){
  
  Table infoTable = loadTable("presidentInfo.csv");
  int rowCount = infoTable.getRowCount();
  PImage online;
  
  for(int row = 1; row != 32 && row != 43 && row < rowCount; row++){
    String pageURL = infoTable.getString(row, 6);
    println(pageURL);
    
    // read the real image url
    XML page = loadXML(pageURL);
    String pageContent = page.toString();
    int a = pageContent.indexOf("https://upload.wikimedia.org");
    int b = pageContent.indexOf("property=\"og:image\"");
    String imageUrl = pageContent.substring(a,b-2);
    println(a);
    println(b);
    println(imageUrl);
    online = loadImage(imageUrl, "jpg");
    online.save(row + ".jpg");
  }
}

public void transformToSquare(){
  PImage[] squarePortraits = new PImage[45];
  for(int i = 0; i < 45; i++){
    squarePortraits[i] = createImage(portraits[i].width, portraits[i].width, RGB);
    for(int x = 0; x < portraits[i].width; x++){
     for(int y = 0; y < portraits[i].width; y++){
       int count = y*portraits[i].width + x;
       squarePortraits[i].pixels[count] = portraits[i].pixels[count];
     }
    }
    squarePortraits[i].save(i + "-.jpg");
  }
}