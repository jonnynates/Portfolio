import lejos.utility.Delay;

//ColourRobotTerminal
public class ColourClass {
	
	private PilotRobot me = new PilotRobot();
	public Boolean occupied = false;
	

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
	
	public void sender(String word) {
		occupied = true;
		String TEST_OUTPUT = "";
		
		
		int wordLeng = word.length();
		for (int i=0; i < wordLeng; i++) 
		{
			if (Character.isWhitespace(word.charAt(i))) {
				TEST_OUTPUT = TEST_OUTPUT + "G";
				me.flashGreen();
				Delay.msDelay(3000);
			}
			else {
				String morseLetter = encLetter(word.charAt(i));
				int morseLeng = morseLetter.length();
				for (int j = 0; j < morseLeng ; j++) 
				{
					char currChar = morseLetter.charAt(j);
					if (currChar == '.') 
					{
						TEST_OUTPUT = TEST_OUTPUT + "R"; 
						me.flashRed();
					}
					else 
					{
						TEST_OUTPUT = TEST_OUTPUT + "B";
						me.flashBlue();
					}
					Delay.msDelay(3000);
				}
				TEST_OUTPUT = TEST_OUTPUT + "G";
				me.flashGreen();
				Delay.msDelay(3000);
			}
		}
		TEST_OUTPUT = TEST_OUTPUT + "G";
		Delay.msDelay(3000);
		me.flashGreen();
		//System.out.println(TEST_OUTPUT);
		occupied = false;
	}

}
