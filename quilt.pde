
import java.util.Map;

// Quilt Code
// This code is a Processing sketch that generates a quilt pattern based on a binary and octal string.
// The binary string represents the pattern, and the octal string represents the color of each rectangle.
// The quilt is rendered in a grid format, with each rectangle representing a piece of fabric.
// The code also calculates the total area of fabric needed for each color and the total area of fabric needed for the quilt.
// The fabric requirements are displayed in either meters or yards, depending on the user's choice.

// I wrote this in 2024 for the wedding of two big nerds who love solving puzzles. I can't claim credit for the final quilt,
// but I can promise that it was a big hit with the couple, though it only took them a few hours to decode it. 
// Feel free to use this code to create your own coded quilt patterns or messages, or to modify it to suit your needs.

// Set the parameters for your strings and the quilt rectangle sizing in the draw() function. Set your colour maps in the CodeRect class.

void setup() {
    size(1000, 1000);    
    background(#FFFFFF);
    noLoop();
}

void draw() {

  int xpos = 0; // starting x position
  int ypos = 0; // starting y position
  int max = 200; // Maximum number of rectangles to draw
  int width = 35; // Width of each rectangle in inches * 10
  int rowHeight = 60; // Height of each row of rectangles in inches * 10
  int maxAcross = 19; // Maximum number of rectangles across the quilt. Try to pick a divisor of the length of your longest string to avoid uneven rows (ex 152/19 = 8 rows, 152/20 = 7.6 rows, which is not ideal).

  CodeRect[] rectangles = new CodeRect[max];
  int firstRect = 0;
  int j = 0 ; 
  int k = 1; 

  // Set Binary and octal strings representing the quilt pattern and colors here
  // These strings should be the same length. The code will automatically pad the shorter string with spaces to make them the same length, 
  // but the quilt looks better if they are the same length to start with (or within a few characters of each other).
  // I have left spaces in these strings to aid in readability, and decoding for the recipient, but you can remove them if you prefer a more compact representation. or difficult challenge
  // This code will accept octal strings with or without leading zeros, so you can use either format. Use this to your advantage to make the strings the same length.
  String binaryString = "01010100 01101000 01100101 00100000 01100110 01101001 01110010 01110011 01110100 00100000 01101101 01100101 01110011 01110011 01100001 01100111 01100101";
  String octalString = "042 115 141 153 145 040 164 150 145 040 163 145 143 157 156 144 040 143 157 144 145 040 155 145 163 163 141 147 145 040 154 157 156 147 145 162 056 042";

  println("Binary String: " + binaryString.length());
  println("Octal String: " + octalString.length());

  // Check if the binary and octal strings are the same length, and pad them if necessary
  if (binaryString.length() != octalString.length()) {
    println("padding octal string to make them the same length");
    int diff = binaryString.length() - octalString.length();
    for (int i = 0; i < diff; i++) {
      octalString = octalString + " ";
    }
  } else if (octalString.length() > binaryString.length()) {
    println("padding binary string to make them the same length");
    int diff = octalString.length() - binaryString.length();
    for (int i = 0; i < diff; i++) {
      binaryString = binaryString + " ";
    }
  }

  Fabric fabric = new Fabric();

  for (int i = 0; i < binaryString.length(); i++) {
    if(i > 0){
      xpos = xpos+ rectangles[i-1].wide;
    }

    CodeRect r = new CodeRect(xpos, ypos, rowHeight, width, binaryString.charAt(i), octalString.charAt(i) ); 
    r.render();
    rectangles[i] = r;
    fabric.addRect(r);

   if (((i+1) % maxAcross) == 0 && i > 2) {

    xpos = -1 *  r.wide ;
    k++;  
    j = k; 
      ypos = ypos + rowHeight;
    }
    j++; 
  }


  // Render the fabric requirements in meters. Use "yards" to render in yards. Set X and Y coordinates to position the text on the canvas.
  fabric.render("meters", 750, 50); 
}



class CodeRect {
  int xcoord, ycoord, wide, tall, rHeight;
  char flip; 
  char hexColor;
  color baseColor = color(#fffff0); // base color for the rectangles
  color spaceColor = color(#000000); // color for the space character in the Hex string. Binary space characters are represented by full height rectangles in the quilt.

  // Storing some alternate color maps for testing purposes
  // Uncomment the color map you want to use
  // color[] colorMap = // set 1
  //   {
  //     color(#42c4bf),
  //     color(#385f4a),
  //     color(#582d39),
  //     color(#1d3d90),
  //     color(#e87042),
  //     color(#dd3c48),
  //     color(#835397),
  //     color(#f4c060),
  //     color(#1196d6),
  //     color(#559f52)
  //   };

  // color[] colorMap =  // set 2
  //   {
  //     color(#42c4bf),
  //     color(#385f4a),
  //     color(#582d39),
  //     color(#1d3d90),
  //     color(#1196d6),
  //     color(#dd3c48),
  //     color(#835397),
  //     color(#f4c060),
  //  };

  //    color[] colorMap =  // set 3
  //   {
  //     color(#42c4bf),
  //     color(#1d3d90),
  //     color(#582d39),
  //     color(#385f4a),
  //     color(#1196d6),
  //     color(#dd3c48),
  //     color(#835397),
  //     color(#f4c060),
  //  };


  //    color[] colorMap =  // set 4
  //   {
  //     color(#06DDDD),
  //     color(#1d3d90),
  //     color(#6F375A),
  //     color(#7A4CB6),
  //     color(#15B4ED),
  //     color(#D52453),
  //     color(#f4c060),
  //     color(#1A7D52),
  //  };

  //       color[] colorMap =  // set 5 current fave
  //   {
  //     color(#06DDDD),
  //     color(#1d3d90),
  //     color(#6F375A),
  //     color(#7A4CB6),
  //     color(#f4c060),
  //     color(#D52453),
  //     color(#15B4ED),
  //     color(#1A7D52),
  //  };


  //       color[] colorMap =  // set 6
  //   {
  //     color(#FF7839),
  //     color(#1d3d90),
  //     color(#6F375A),
  //     color(#7A4CB6),
  //     color(#f4c060),
  //     color(#D52453),
  //     color(#15B4ED),
  //     color(#1A7D52),
  //  };

    color[] colorMap =  // set 7  
    {
      color(#06DDDD),
      color(#1d3d90),
      color(#6F375A),
      color(#7A4CB6),
      color(#f4c060),
      color(#D52453),
      color(#FF7839),
      color(#1A7D52),
   };







  CodeRect(int x, int y, int r, int w, char f, char hc){
    xcoord = x;
    ycoord = y;
    hexColor = hc;
    wide = w; // Set fixed width of each rectangle
    tall = int(random(3.33, 6.66)/10 * r) ; // Set randomized row height, from 1/3 to 2/3 of total row height
    rHeight = r;
    flip = f; 
    if(hc == ' ') {
       hexColor = '8';
    }
  }

  color getColor(char hexDigit) {
    switch(hexDigit) {
      case ('0'):
        return colorMap[0];
      case ('1'):
        return colorMap[1];
      case ('2'):
        return colorMap[2];
      case ('3'):
        return colorMap[3];
      case ('4'):
        return colorMap[4];
      case ('5'):
        return colorMap[5];
      case ('6'):
        return colorMap[6];
      case ('7'):
        return colorMap[7];
      case ('8'):
        return spaceColor;
      default:
        return color(0,0,0);
    }
  }
 

  void render(){
    if (flip == '0') {
      fill(baseColor);
      rect(xcoord, ycoord, wide, tall); 
      fill(getColor(hexColor));
      rect(xcoord, ycoord+tall, wide, rHeight - tall);
      fill(baseColor);
      text(hexColor + "," + ((rHeight - tall)), xcoord+5, ycoord+rHeight-5); // Display the color map code and the height of the rectangle to aid in quilt construction
    } else if (flip == '1') {
      fill(getColor(hexColor));
      rect(xcoord, ycoord, wide, tall); 
      fill(baseColor);
      text(hexColor + ","+ (tall), xcoord+5, ycoord + tall - 5);
      fill(baseColor);
      rect(xcoord, ycoord+tall, wide, rHeight - tall);
    }
    else {
      fill(getColor(hexColor));
      rect(xcoord, ycoord, wide, rHeight); 
      fill(color(#fffff0));
      text(hexColor, xcoord+5, ycoord+rHeight-5);
    }
  }

}

class Fabric {

  // This class is used to calculate the total area of fabric needed for each color
  // and the total area of fabric needed for the quilt.

  IntDict areas;
  Fabric(){
    areas = new IntDict();
    areas.set("0", 0);
    areas.set("1", 0);
    areas.set("2", 0);
    areas.set("3", 0);
    areas.set("4", 0);
    areas.set("5", 0);
    areas.set("6", 0);
    areas.set("7", 0);
    areas.set("8", 0);
    areas.set("9", 0);
  }

  void addRect(CodeRect rect){
    int g = 0;
    int c = 0; 
    if (rect.flip == '0') { 
        g = (rect.wide+5) * (rect.tall+5);  // add 1/4 inch seam allowance around all sides 
        c = rect.wide+5 * (rect.rHeight+5 - rect.tall);
    } else if ( rect.flip == '1') {
      g = rect.wide+5 * (rect.rHeight+5- rect.tall);
      c = rect.wide+5 * rect.tall+5; 
    }
    else {
      c = rect.wide * rect.rHeight; 
    }

    areas.add(str(rect.hexColor), c);
    areas.add("9", g);
  }

  float toMeters(int sqInch){
    float inches = float(sqInch)/100;
    return (inches / 45) * 1.1 * 0.0254; // calculated for 45" width fabric, 10% wasteage, inches to meters;
  }

  float toYards(int sqInch){
    float inches = float(sqInch)/100;
    return (inches / 45) * 1.1 * 0.0277778; // calculated for 45" width fabric, 10% wasteage, inches to yards;
  }

  void render(String unit, int x, int y) {
    String amounts = "Fabric measurements in";
    if (unit.equals("yards")) {
      amounts = amounts + " yards \n"; 
      for (int i = 0; i <= 9; i++){
        amounts = amounts + "colour " + str(i) +  ": " +  toYards(areas.get(str(i))) + "\n";
      
    }
    } else {
       amounts = amounts + " meters \n"; 
      for (int i = 0; i <= 9; i++){
        amounts = amounts + "colour " + str(i) +  ": " +  toMeters(areas.get(str(i))) + "\n";
      }
    }

    println("==================");
    println("Fabric Needed");
    println("==================");

    println(amounts);

    fill(#000000);
    text(amounts, x, y);
  }
}
