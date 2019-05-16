public class Matrix{
 
  
  public String transposition(String message, int kkey){
    if(kkey > message.length()-1){
      println("key should be shorter than the length of the message");
      return "out";
    }
   
    
    //Encryption
    int nRows = round(message.length() / (float) kkey);
    //println(nRows);
    char [] [] matrix = new char[nRows][kkey];
    char[] charMessage = message.toCharArray();
    int splitMessageIndex = 0;
    String output = "";
    String enc = "";
    
    for(int i = 0; i < nRows; i++){
      for(int j = 0 ; j < kkey; j++){
        //println("i = " + i + "; j = " + j);
        
        if(splitMessageIndex == message.length()) break;
        
        matrix[i][j] = charMessage[splitMessageIndex++];
        output = output + matrix[i][j];
      }
    }
    
    //println("scramble begins here: ");
    //Scramble
    for(int j = 0; j < kkey; j++){
      for(int i = 0; i < nRows; i++){
        //println("i = " + i + " j = " + j);
        enc = enc + matrix[i][j];
      }
    }

    return enc;
  }
  
  void setup(){
  }
  
  void draw(){
  
  }
}
