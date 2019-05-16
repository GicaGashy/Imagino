import java.util.*;
import java.lang.Math;


public class Vigenere{

String test = "";
  private final String unicode = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€,ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œž› ¡¢£¤¥¦§¨©ª«¬ ®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ";
  //public String unicode = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
int size = unicode.length();
void setup() {
  //println(vigenereKeyword("Vlehip splepi fjfjfj", "Pre", 0));
  //println(vigenereKeyword("†¾ª˜»µÝÅµœ·µ™ÿ«š¸¯–¼", "Pre", 1));
  //println(stringToInts("Endrit"));
  //exit();
}  

void draw() {
}

//ENCRYPTION METHOD VIGNERE KEYWORD - START
public String vigenereKeyword(String m, String k, int mode) {

  char [] message = m.toCharArray();
  char [] kkey = k.toCharArray();
  String temp = k;
  char [] unicodeChar = unicode.toCharArray();

  //---- controls - START
  if (kkey.length >= message.length) {
    kkey = new char[message.length];
    for (int i = 0; i < kkey.length; i++) {
      kkey[i] = temp.charAt(i);
    }
  } else if (kkey.length == 0) {
    println("Key nuk bene te jete 0");
    return k;
  } else {
    int counter = kkey.length;
    kkey = new char[message.length];
    for (int i = 0, j = 0; j < message.length; i++, j++) {
      if (i == counter) {
        i = 0;
      };
      kkey[j] = temp.charAt(i);
    }
  }

  //convert back to String
  m = String.valueOf(message);
  k = String.valueOf(kkey);
  //---- controls - END

  //Encryption/Decryption - START
  int [] messageInt = stringToInts(m);
  int [] keyInt = stringToInts(k);
  int [] result = new int[messageInt.length];
  char [] messageChar = new char[result.length];
  String messageString = "";
  if (mode < 0 || mode > 1) return "mode not set correctly"; 
  exit();

  if (mode == 0)
  {
    for (int i = 0; i < m.length(); i++) {
      if ((messageInt[i] + keyInt[i]) < unicodeChar.length) {
        result[i] = messageInt[i] + keyInt[i];
        //println(result[i]);
      } else if ((messageInt[i] + keyInt[i]) > unicodeChar.length) {
        result[i] = (messageInt[i] + keyInt[i]) % unicodeChar.length;
        //println(result[i]);
      }
    }
  } else if (mode == 1)
  {
    for (int i = 0; i < m.length(); i++) {
      if ((messageInt[i] - keyInt[i]) < unicodeChar.length && (messageInt[i] - keyInt[i]) >= 0) {
        result[i] = messageInt[i] - keyInt[i];
        //println(result[i]);
      } else if ((messageInt[i] - keyInt[i]) < 0) {
        result[i] = (messageInt[i] - keyInt[i] + (unicodeChar.length) ) % (unicodeChar.length);
        //println(result[i]);
      }
    }
  }
  //Encryption/Decryption - END

  //println(String.valueOf(result));


  for (int i = 0; i < messageChar.length; i++) {
    messageChar[i] = intToUnicode(result[i]);
  }
  test = String.valueOf(messageChar);
  return messageString = String.valueOf(messageChar);
}
//ENCRYPTION METHOD VIGNERE KEYWORD - END


//====int String to Int====
public int[] stringToInts(String s) {
  int [] output = new int[s.length()];
  char [] c = new char[s.length()];
  c = s.toCharArray();
  for (int i = 0; i < s.length(); i++) {
    for (int j = 0; j < unicode.length(); j++) {
      if (unicode.charAt(j) == c[i]) {
        output[i] = j;
      }
    }
  }
  return output;
}

//int==== Convert integer to chararcters
public char intToUnicode(int x) {
  if (x > unicode.length()) {
    println("Value bigger than: " + unicode.length() );
  } else if (x < 0) {
    println("Value less than 0");
  }

  char [] c = new char[unicode.length()];
  c = unicode.toCharArray();
  //char o = 'x';

  return c[x];
}

}
