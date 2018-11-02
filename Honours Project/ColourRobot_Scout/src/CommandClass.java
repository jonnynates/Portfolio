import java.util.Random;

import lejos.utility.Delay;

public class CommandClass {
	
	/*
	 * Variable that is false by default 
	 * changed to true as soon as a map is transfered to it
	 */
	private boolean mapHeld = false;
	ColourClass cc;
	
	
	PilotRobot me;

	
	private static int[][] map = new int[8][8];
	
	/*private static int map[][] = {
			   //0 1 2 3 4 5 6 7
				{1,1,1,1,1,1,1,1}, //0
				{1,0,0,0,0,0,0,1}, //1
				{1,0,0,1,0,1,0,1}, //2
				{1,0,1,0,0,0,0,1}, //3
				{1,0,0,0,0,0,0,1}, //4
				{1,0,0,0,0,1,1,1}, //5
				{1,1,0,0,0,0,0,1}, //6
				{1,1,1,1,1,1,1,1}  //7
			};*/
	
	//Movement commands
	public void comMove() {
		System.out.println("In move");
		String direction = cc.reciever();
		System.out.println(direction);
		int dist = Integer.parseInt(cc.reciever());
		System.out.println(dist);
		//Turns the robots heading depending on the direction it wants to go
		
		int moveInt = 0;
		switch (direction) {
			case "UP":
						moveInt = 1;
						break;
			case "DOWN": 
						moveInt = 2;
						break;
			case "RIGHT":	
						moveInt = 4;
						break;
			case "LEFT":
						moveInt = 3;
						break;
		}
		//Repeats moving forward until it travels the correct distance 
		for (int i = 0; i < dist; i++ ) {
			me.move(moveInt);
			}
		Delay.msDelay(4000);
		comGoHome();
	}
	
	//Rotates the robot based on the command 
	public void comRotate() {
		String direction = cc.reciever();
		int angle = Integer.parseInt(cc.reciever());
		int newAngle = angle;
		if (direction == "LEFT") {
			newAngle = angle * -1;
		}
		me.currAngle = me.currAngle + newAngle;
		me.getPilot().rotate(newAngle);
	}
	
	/*
	 * This command uses a map to move the robot to a specified co-ordinate on the map
	 * If map is stored then the command can activate and return true to show that it worked
	 * If map is not stored then the command will cancel and return false
	 */
	public boolean comGoTo() {
		int xCord = Integer.parseInt(cc.reciever());
		int yCord = Integer.parseInt(cc.reciever());
		
		boolean comSuccess = false;
		//Checks to see if a map is stored.
		
		if (mapHeld == true) {
			me.astarMovement(map, xCord, yCord);
			comSuccess = true;
		}
		//comGoHome();
		
		return comSuccess;
	}
	
	
	/*
	 * Command that takes a long string from the reciever robot
	 */
	public String comMessage() {
		String message = cc.reciever();
		
		return message;
	}
	
	/*
	 * Command that makes the robot dance around randomly 
	 */
	public void comDance() {
		if (mapHeld == true) {
			me.astarMovement(map, 3, 3);		
		}
		Random rand = new Random();
		for (int i = 0; i < 10; i++) {
			int intChoice = rand.nextInt(2) + 1;
			switch (intChoice) {
				case 1:
						int intMove = rand.nextInt(15) + 1;
						me.getPilot().travel(intMove);
						break;
				case 2:
						int intRotate = rand.nextInt(90) + 1;
						me.getPilot().rotate(intRotate);
						break;
			}
		}
	}
	
	/*
	 * Method that brings the scout back to the terminal robot
	 */
	public void comGoHome() {
		if (mapHeld == true) {
			me.astarMovement(map, 1, 5);		
		}
		switch (me.currAngle) {
			case 0:	me.rotate180();
					break;
			case 90: me.turnRight();
					break;
			case -90: me.turnLeft();
					break;
			case 180: 
					break;
		}
	}
	
	public void comMap() {
		System.out.println("Scanning map");
		Boolean done = false;
		int row = 0;
		int col = 0;
		Delay.msDelay(3000);
		while (done == false) {
			String colourRes = me.scanCol();
			if (colourRes == "R") {
				map[row][col] = 1;
				
			}
			else if (colourRes == "B" ) {
				map[row][col] = 0;
			}
			
			
			if (row < 7) {
				row++;
			}
			else if (row == 7 && col < 7) {
				row = 0;
				col++;
			}
			else if (row == 7 && col == 7){
				done = true;
			}
			Delay.msDelay(3000);
		}
		
		mapHeld = true;
	}
}
