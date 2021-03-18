class FlipImage{
  
  public PImage portrait;
  public int id;
  public String name;
  public String tookOffice;
  public String leaveOffice;
  public String age;
  public String birthState;
  public String trivia;
  public String wiki;
  public String party;
  public int index_i, index_j;
  public boolean front = true;
  public boolean hoveredupon = false;
  public int fx, fy;
  public color partyColor;
  
  FlipImage(){
    partyColor = #000000;
  }
  
  public void setIndex(int id){
    //if(id % 9 == 0)
    //  index_i = 8;
    //else
    index_i = (id - 1) % 9 ;
    index_j = (id - 1) / 9;
    
    fx = margin_left + (image_size + gap) * index_i;
    if(index_j > 1)
      fy = margin_top0 + (image_size + gap) * index_j;
    else
      fy = margin_top + (image_size + gap) * index_j;     
  }
  
  public void setPartyColor(String party){
    if(party == "Democratic" || party.equals("Democratic")){
      partyColor = #63b8ff; // blue color for democratic
    }
    else if(party == "Republican" || party.equals("Republican")){
      partyColor = #ee3b3b; // red color for republican
    }
    else if(party == "Whig" || party.equals("Whig")){
      partyColor = #f0dc82; // buff for whig 
    }
    else{
      partyColor = #ffffff; // white for any other
    }
  }
  
  public void flip(){
    if(front){
      // flip to back
      front = false;
    }
    else{
      front = true; 
    }
  }
  
  public boolean selected(int mx, int my){
    if(mx > fx && mx < fx + image_size && my > fy && my < fy + image_size)
    {
      return true;
    }
    else
      return false;
  }
  
  public void drawFlip(){
    if(front){
      // draw portrait 
      image(portrait, fx, fy, image_size, image_size);
    }
    else{
      fill(partyColor);
      noStroke();
      rect(fx, fy, image_size, image_size);
      // display name and tookOffice - leaveOffice
      fill(0);
      textSize(20);
      if(name.length() > 14){
        int index0 = name.indexOf(" ");
        text(name.substring(0, index0),fx + image_size / 2, fy + image_size / 4);
        text(name.substring(index0), fx + image_size / 2, fy + image_size / 2);
 
      }
      else
        text(name, fx + image_size / 2 , fy + image_size / 2);
      try{
        text(tookOffice.split("/")[2] + "-" + leaveOffice.split("/")[2], fx + image_size / 2, fy + image_size * 3/ 4);
      }catch(Exception e){
        text(tookOffice.split("/")[2] + "-" , fx + image_size / 2, fy + image_size * 3/ 4);
      }
    }
  }
  
  public void drawFrame(){
    noFill();
    stroke(150);
    strokeWeight(5);
    rect(fx, fy, image_size, image_size, 5); 
  }
  
}