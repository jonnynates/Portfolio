import lejos.hardware.Button;
import lejos.utility.Delay;

//ColourRobotScout


public class ColourClass {
	
	//Creating an object of the pilot robot
	PilotRobot me;
	
	
	
	private String[][] morseDict = new String[][] {
		{"A",".-"},
		{"B","-..."},
		{"C","-.-."},
		{"D","-.."},
		{"E","."},
		{"F","..-."},
		{"G","--."},
		{"H","...."},
		{"I",".."},
		{"J",".---"},
		{"K","-.-"},
		{"L",".-.."},
		{"M","--"},
		{"N","-."},
		{"O","---"},
		{"P",".--."},
		{"Q","--.-"},
		{"R",".-."},
		{"S","..."},
		{"T","-"},
		{"U","..-"},
		{"V","...-"},
		{"W",".--"},
		{"X","-..-"},
		{"Y","-.--"},
		{"Z","--.."},
		{"1",".----"},
		{"2","..---"},
		{"3","...--"},
		{"4","....-"},
		{"5","....."},
		{"6","-...."},
		{"7","--..."},
		{"8","---.."},
		{"9","----."},
		{"0","-----"}
	};
	
	//Transition table for decoding morse code letter strings
	private String[][] morseTransitionTable = new String[][] {
			//DOT //DASH
		{"root","1","2"}, 	//0
		{"E","3","4"}, 		//1
		{"T","5","6"}, 		//2
		{"I","7","8"}, 		//3
		{"A","9","10"},	 	//4
		{"N","11","12"}, 	//5
		{"M","13","14"}, 	//6
		{"S","15","16"},	 	//7
		{"U","17","37"}, 	//8
		{"R","18","-1"},		//9
		{"W","19","20"}, 	//10
		{"D","21","22"}, 	//11
		{"K","23","24"}, 	//12
		{"G","25","26"}, 	//13
		{"O","38","39"}, 	//14
		{"H","31","30"}, 	//15
		{"V","-1","29"}, 	//16
		{"F","-1","-1"}, 	//17
		{"L","-1","-1"}, 	//18
		{"P","-1","-1"}, 	//19
		{"J","-1","27"}, 	//20
		{"B","32","-1"}, 	//21
		{"X","-1","-1"}, 	//22
		{"C","-1","-1"}, 	//23
		{"Y","-1","-1"}, 	//24
		{"Z","33","-1"}, 	//25
		{"Q","-1","-1"},  	//26
		{"1","-1","-1"},  	//27
		{"2","-1","-1"},  	//28
		{"3","-1","-1"},  	//29
		{"4","-1","-1"},  	//30
		{"5","-1","-1"},  	//31
		{"6","-1","-1"},  	//32
		{"7","-1","-1"},  	//33
		{"8","-1","-1"},  	//34
		{"9","-1","-1"},  	//35
		{"0","-1","-1"},  	//36
		//EMPTY NODES TO HELP TRANSITION TO THE NUMBERS
		{"EMP_U","-1","28"}, //37
		{"EMP_O1","34","-1"}, //38
		{"EMP_O2","35","36"} //39
		
	};
	
	
	/*
	 * Encodes an alphabet letter into a morse code string
	 */
	public String encLetter(char alphaLetter) {
		boolean found = false;
		int count = 0;
		String morseLetter = "1";
		while (!found) {
			if (morseDict[count][0].charAt(0) == alphaLetter ) {
				morseLetter = morseDict[count][1];
				found = true;
			}
			count++;
		}
		
		return morseLetter;
	}
	
	/*
	 * Decodes a morse code string into an alphabet letter
	 */
	public String decLetter(String morseLetter) {
		int count = 0;
		int currPos = 0;
		while (count < morseLetter.length()) {
			if (morseLetter.charAt(count) == '.') {
				currPos = Integer.parseInt(morseTransitionTable[currPos][1]);
			}
			else if (morseLetter.charAt(count) == '-') {
				currPos = Integer.parseInt(morseTransitionTable[currPos][2]);
			}
			
			
			count++;
		}
		return morseTransitionTable[currPos][0];
	}
	
	/*
	 * Scans a colour sequence that corresponds to a single morse letter.
	 * The morse letter ends when the colour Green flashes
	 * Red represents dot
	 * Blue represents dash
	 */
	public String scanLetter() {
		//System.out.println("In scan letter");
		Boolean done = false;
		String morseString = "";
		String colourRes = "";
		
		
		while (!done) 
		{
			colourRes = me.scanCol();
			
			if (colourRes == "G" ) 
			{
				done = true;
			}
			else 
			{
				if (colourRes == "R")
				{
					morseString = morseString + ".";
				}
				else if (colourRes == "B") 
				{
					morseString = morseString + "-";
				}
				else 
				{
					System.out.println("ERROR unkown colour");
				}
			}
			//Waits before scanning next colour. Gives time for the colour to change
			Delay.msDelay(3000);
		}
		
		return morseString;
	}
	
	public String reciever() {
		Boolean done = false;
		String engWord = "";
		Boolean exit = false;
		
		while (exit == false){
			 String temp = me.scanCol();
			if (temp != "G") {
				//System.out.println("exit temp");
				exit = true;
			}
			if (Button.ESCAPE.isDown()) {
				System.exit(0);
			}
			Delay.msDelay(500);
		} 
		//Boolean presG = false;
		while (!done) 
		{
			String results = scanLetter();
			if (results == "") 
			{
				done = true;
			}
			else 
			{
				
					String engLetter = decLetter(results);
					engWord = engWord + engLetter;
			}
		}
		return engWord;
	}

}
