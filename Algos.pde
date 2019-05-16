public class Algos{
  
//===================REVERSE-CIPHER=====================
  public String reverseCipher(String s){
    char [] o = new char[s.length()];
        for(int i = o.length-1, j = 0; i >= 0 && j <= o.length-1; i--, j++ ){
                o[j] = s.charAt(i);
        }
        return new String(o);
    }
//===================REVERSE-CIPHER=====================

}
