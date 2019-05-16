import java.security.*;
import java.util.*;

int counter = 0;
int counted = 0;
//float from = 50.0;
//float to = 0.0;

void setup() {
  size(500,500);

 
 Vigenere v = new Vigenere();
 Matrix m = new Matrix();
 String message = "Mesazhi per enkriptim"; 
 String encryptedMessage =v.vigenereKeyword(message, "SuperPassword", 0);
 println(encryptedMessage);





 
 //---------------<<<>>>>------------//
 normalizePicture("beach.jpg", 50.0, 51.0, "normalized");
 //writeLinearPicture("beach.tif", 50.0, message);
 //writeLinearScatteredPicture("dog_normalized.tif", 50.0, message);
 //writeLinearEdge("dog_normalized.tif", 50.0, message);
 //println(readLinearPicture("encoded.tif", 50.0));
 //decryptedMessage = v.vigenereKeyword(readLinearPicture("encrypted.tif", 127.0), kkey, 1);
 //println(decryptedMessage);
 //readPixels("test.jpg");
 exit();
}




void draw() {
 
}

//Metoda per normalizimin e pixeleve (Ne kete rast po e normalizojna vetem kanalin e kuq). 
void normalizePicture(String s, float from, float target, String name){
  //Helpers - start  
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  //Helpers - end
  PImage p = loadImage(s);
   //baseIMG = loadImage(s); //lexon fotografon me emrin test.jpg. Emri duhet te jete sikurse emri i file-it. test.jpg tash eshte ne baseIMG
     
  int dimension = p.width * p.height;             //mar madhesine e pixelve
  p.loadPixels();                                       //lexoj pixel-et e imazhit base
  for (int i = 0; i < dimension; i ++) { 
    r = red(p.pixels[i]);
    g = green(p.pixels[i]);
    b = blue(p.pixels[i]);
    if(r == from){
      println("Found " + from +" at " + i + " Actual value = " + r);
      p.pixels[i] = color(target,g,b);
      println("Color changed to: " + target);
      counter++;
    }
    //println(r);
  }
  p.updatePixels();
  println("Changes made: " + counter);
  final String PATH = savePath("data\\" + name + ".tif");
  p.save(PATH);
  println("------NORMALIZING DONE------");
  println("Target values " + "[" + from + "]" + " found : " + counter + "\nTargeted pixels changed to: " + target);
  //to = from + 1;
}

//Metoda perdoret vetem per DEBUG
void readPixels(String s){
  float to = 0.0;
  PImage p = loadImage(s);
  p.loadPixels();
  for(int i = 0; i < (p.width * p.height); i++){
    if(red(p.pixels[i]) > to){
      println(i+ " with the blue value " + blue(p.pixels[i]));
      counted++;
    }
  }
  println("----------OPERATION FINISHED" + "---------" + "\nCounter = " + counter + "\nCounted = " + counted);
}

//Metoda per perkthimin nga pixel float ne int
public int floatToInt(float f) throws Exception{
  if(f > 255.0) {
  throw new Exception("Value cannot be bigger than 255");
  }else if(f < 0){
   throw new Exception("Value less than 0");
  }
  return (int) f;
}

//Metoda per leximin e fotografise -- kthen nje String -- targeti sherbn si key --- kjo eshte menyra lineare, lexon cdo pixel ne menyre sekuenciale duke ja dhene nje target. --- start
public String readLinearPicture(String s, float target){
  
  String output = "";
  int tempInt = 0;
  char tempChar = ' ';
  PImage p = loadImage(s);
  int dim = p.width * p.height;
  p.loadPixels();
  for(int i = 0; i < dim ; i++){
    if(red(p.pixels[i]) == target){
    println("hit " + i);
    try{
    tempInt = floatToInt(blue(p.pixels[i]));
    }catch(Exception e){
      println("Couldn't translate to int");
    }
    
    try{
    tempChar = intToUnicode(tempInt);
    }catch(Exception e){
      println("Could not translate to unicode");
    }
    
    output = output + tempChar;
    }
  }
  p.updatePixels();
  
  return output;
}
//Metoda per leximin e fotografise -- kthen nje String -- targeti sherbn si key --- kjo eshte menyra lineare, lexon cdo pixel ne menyre sekuenciale duke ja dhene nje target. --- end

//====================LINEAR==================================================
void writeLinearPicture(String s, float target, String message){
  
 //helpers - start (Kjo ndihmon mbajtjen e konsistences se pixelve baze.
 float r = 0.0;
 float g = 0.0;
 float b = 0.0;
 
 int messageIndex = 0;
 //helpers - end
 
 float [] fMessage = stringToFloats(message);
 PImage p = loadImage(s);
 

 int dim = p.width * p.height;
 
  p.loadPixels();
  for(int i = 2000; i < dim; i++){
    r = (float) red(p.pixels[i]);
    g = (float) green(p.pixels[i]);
    b = (float) blue(p.pixels[i]);
     //p.pixels[i] = color(target,g,fMessage[messageIndex]);; 
      //Ketu e shkruaj karakterin ne kanalin blue, ndersa si identifikues perdori kanalin red me vlere te target (VENI RE, TARGET ESHTE KEY, duhet te dihet nga lexuesi).
      //if(i > message.length()) break;
       if(messageIndex < message.length()){
       println("Written " + fMessage[messageIndex]);
       p.pixels[i] = color(target,g,fMessage[messageIndex++]);
       }
       
     }
     p.updatePixels();
     
     
     final String PATH = dataPath("encoded.tif");

     p.save(PATH);
     println("Liner encryption done");
  }

  
//====================SCATTERED==================================================
void writeLinearScatteredPicture(String s, float target, String message){
 //helpers - start (Kjo ndihmon mbajtjen e konsistences se pixelve baze.
 if(target > 255 || target < 0){            //Kontroller per numra, edhe pse dy modulet tjera gjujn exception nese nuk plotsohet kushti.
   println("Targeti jasht kufijve");        //Console
   return;                                  //Kthehet nuk vazhdon ma tutje
 }
 float r = 0.0;
 float g = 0.0;
 float b = 0.0;
 int messageIndex = 0;
 //helpers - end
 
 float [] fMessage = stringToFloats(message);
 PImage p = loadImage(s);
 

 int dim = p.width * p.height;
 int low, divider;
 low = 0;
 divider = 96; //scatterDivider(message)//Prodhon perpjestues ne baze te gjatesis se mesazhit
 int position =(int) random(low, dim/divider);
 int tempPosition = 0;
  p.loadPixels();
  for(int i = 0; i < dim; i++){
    r = (float) red(p.pixels[i]); //Nuk perdoret momentalisht, veteme nese dojna me ndrru kanallin e leximit
    g = (float) green(p.pixels[i]);
    b = (float) blue(p.pixels[i]); //Nuk perdoret momentalisht, vetem nese dojna me ndrru kanallin e leximit
     //p.pixels[i] = color(target,g,fMessage[messageIndex]);; 
      //Ketu e shkruaj karakterin ne kanalin blue, ndersa si identifikues perdori kanalin red me vlere te target (VENI RE, TARGET ESHTE KEY, duhet te dihet nga lexuesi).
      //if(i > message.length()) break;
       if(messageIndex < message.length()){
       //println("Written " + fMessage[messageIndex]); //
       p.pixels[position] = color(target,g,fMessage[messageIndex++]);
       tempPosition = position;
       position = (int) random(position, random(position + 2, position + (dim/divider))); println(position);
       if(position >= dim){
         position = tempPosition + 2;
         println("ma e madhe se dim, vlera u kthy ne: " + position);
         }
       }
     }
     p.updatePixels();
     final String PATH = dataPath("scattered_encoded.tif");
     p.save(PATH);
     println("Scattered Liner encryption done");
  }

//====================EDGE-TO-EDGE==================================================
//Metoda e shkrimit te pixelve ne edge-to-edge
void writeLinearEdge(String s, float target, String message){
 //helpers - start (Kjo ndihmon mbajtjen e konsistences se pixelve baze.
 if(target > 255 || target < 0){            //Kontroller per numra, edhe pse dy modulet tjera gjujn exception nese nuk plotsohet kushti.
   println("Targeti jasht kufijve");        //Console
   return;                                  //Kthehet nuk vazhdon ma tutje
 }
 float r = 0.0;
 float g = 0.0;
 float b = 0.0;
 int messageIndex = 0;
 //helpers - end
 
 float [] fMessage = stringToFloats(message);
 PImage p = loadImage(s);
 int dim = p.width & p.height;
 int wid = p.width;
 int first = 0; println(first);
 int last = wid-1; println(last);
 int j = 1;
 int k = 2;
  p.loadPixels();
  for(int i = 0; i < dim; i++){
    r = (float) red(p.pixels[i]); //Nuk perdoret momentalisht, veteme nese dojna me ndrru kanallin e leximit
    g = (float) green(p.pixels[i]);
    b = (float) blue(p.pixels[i]); //Nuk perdoret momentalisht, vetem nese dojna me ndrru kanallin e leximit
     //p.pixels[i] = color(target,g,fMessage[messageIndex]);; 
      //Ketu e shkruaj karakterin ne kanalin blue, ndersa si identifikues perdori kanalin red me vlere te target (VENI RE, TARGET ESHTE KEY, duhet te dihet nga lexuesi).
      //if(i > message.length()) break;
       if(messageIndex < message.length()-1){
       //println("Written " + fMessage[messageIndex]); //
       p.pixels[first] = color(target,g,fMessage[messageIndex++]);
       p.pixels[last] = color(target,g,fMessage[messageIndex++]);
       first = (wid * j); println("First: " + first);
       last = (wid * k)-1; println("Last: " + last);
       j++;
       k++;
       if(i >= dim){
         println("Redo the whole thing, it is getting out of hand");  
         return;
         }
       }
     }
     p.updatePixels();
     final String PATH = dataPath("edge_encoded.tif");
     p.save(PATH);
     println("Edge-to-Edge is done");
  }  
   



//Metoda e perkthimit te int ne karaktere --- START
public char intToUnicode(int x) throws Exception{
  if(x > 255){
    throw new Exception("Value bigger than 255");
  }else if(x < 0){
    throw new Exception("Value less than 0");
  }
  
  String unicode = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€,ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œž› ¡¢£¤¥¦§¨©ª«¬ ®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ";
  char [] c = new char[unicode.length()];
  c = unicode.toCharArray();
  //char o = 'x';
  
  return c[x];
}
//Metoda e perkthimit te int ne karaktere --- END

//Metoda linear per enkodim te string to Float array
public float[] stringToFloats(String s){
  float [] output = new float[s.length()];
  char [] c = new char[s.length()];
  c = s.toCharArray();
  String unicode = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€,ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œž› ¡¢£¤¥¦§¨©ª«¬ ®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ";
  for(int i = 0; i < s.length(); i++){
    for(int j = 0; j < unicode.length(); j++){
      if(unicode.charAt(j) == c[i]){
        output[i] = j;
      }
    }
  }
  return output;
}

//Helper - not fully implemented, TO DO LATER
public int scatterDivider(String s){
  int source = s.length();
  int divider = 4;
  int output = 4;
  
  if(source < 16){
    return output;
  }else{
    return (int) source / divider;
  }
 
  //return divider;
}
