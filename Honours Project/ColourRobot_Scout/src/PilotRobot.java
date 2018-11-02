import java.util.Stack;

import lejos.hardware.Brick;
import lejos.hardware.BrickFinder;
import lejos.hardware.Button;
//import lejos.hardware.Button;
import lejos.hardware.Sound;
import lejos.hardware.ev3.LocalEV3;
import lejos.hardware.motor.Motor;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.EV3ColorSensor;
import lejos.hardware.sensor.EV3TouchSensor;
//import lejos.hardware.sensor.NXTColorSensor;
import lejos.robotics.Color;
import lejos.robotics.SampleProvider;
import lejos.robotics.chassis.Chassis;
import lejos.robotics.chassis.Wheel;
import lejos.robotics.chassis.WheeledChassis;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.navigation.MovePilot;
import lejos.utility.Delay;
import lejos.hardware.lcd.Font;
import lejos.hardware.lcd.GraphicsLCD;
//import lejos.hardware.lcd.LCD;
//import lejos.robotics.navigation.Move;

public class PilotRobot {
	
	
	
	private MovePilot pilot;
	CommandClass command;
	ColourClass cc;
	
	

	private EV3UltrasonicSensor uSensor;
	public EV3ColorSensor ColorSensorBot, ColorSensorHead;
	private double uRange;
	private SampleProvider lPress, rPress, uDistance, RGBProvider, IDProvider;
	private float[] lSample, rSample, uSample, RGBSample, IDSample;
	private OdometryPoseProvider opp;
	GraphicsLCD lcd = LocalEV3.get().getGraphicsLCD();
	
	private static final double WHEEL_DIAMETER = 4.32;
	
	//Current heading of the robot
	public int currAngle = 180;
	
	//Current X and Y cords
	private int xcurrent = 1;
	private int ycurrent = 5;
	
	public PilotRobot() {
		/* Setup Pilot */
		Brick myEV3 = BrickFinder.getDefault();
		Wheel leftWheel = WheeledChassis.modelWheel(Motor.B, WHEEL_DIAMETER).offset(-5.7);
		Wheel rightWheel = WheeledChassis.modelWheel(Motor.D, WHEEL_DIAMETER).offset(5.7);
		Chassis myChassis = new WheeledChassis( new Wheel[]{leftWheel, rightWheel}, WheeledChassis.TYPE_DIFFERENTIAL);
		pilot = new MovePilot(myChassis);
		pilot.setAngularSpeed(15);
		pilot.setLinearSpeed(8);
		pilot.setLinearAcceleration(5);
		
		/* Setup Pose Provider */
		opp = new OdometryPoseProvider(pilot);
		
		
		
		/* Setup Ultrasonic sensor */
		uSensor = new EV3UltrasonicSensor(myEV3.getPort("S3"));
		uSensor.close();
		uDistance = uSensor.getDistanceMode();
		uSample = new float[uDistance.sampleSize()];
		uRange = 0.4;
		
		/* Setup Colour Sensor */
		ColorSensorBot = new EV3ColorSensor(myEV3.getPort("S2"));
		//ColorSensorBot.close();
		ColorSensorHead = new EV3ColorSensor(myEV3.getPort("S1"));
		//ColorSensorHead.close();
		RGBProvider = ColorSensorHead.getRGBMode();
		IDProvider = ColorSensorBot.getColorIDMode();
		RGBSample = new float[RGBProvider.sampleSize()];
		IDSample = new float[IDProvider.sampleSize()];
	}
	
	//Method that returns the pilot to be used in other classes
	public MovePilot getPilot() {
		return pilot;
	}
	
	public void getMessages() {
		lcd.clear();
		lcd.drawString("Ready", 40 , 60, 0);
		String word = cc.reciever();
		System.out.println(word);
		switch (word) {
		case "MOVE": command.comMove();
					break;
		case "DANCE": command.comDance();
					break;
		case "GOTO": command.comGoTo();
					break;	
		case "MAP": command.comMap();
					break;
		case "ROTATE": command.comRotate();
					break;
		case "MESSAGE": command.comMessage();
					break;
		}
		lcd.clear();
		lcd.setFont(Font.getDefaultFont());
		lcd.drawString("Action Complete", 30 , 60, 0);
		lcd.clear();
		Delay.msDelay(3000);
		
	}
	
	public float[] getRGBColor() {
		RGBProvider.fetchSample(RGBSample,0);
		return RGBSample;
	}
	
	public float getIDColor() {
		IDProvider.fetchSample(IDSample,0);
		
		return IDSample[0];
	}
	
	//Scans the colour
	public String scanCol() {
		float[] sample = getRGBColor();
		float r = sample[0];
		float g = sample[1];
		float b = sample[2];
		String colorChar;
		if (r > 0.1 && g < 0.1 && b < 0.1) {
			colorChar = "R";
			Sound.beep();
		}
		else if (r < 0.1 && g < 0.1 && b < 0.1) {
			colorChar = "B";
			Sound.buzz();
		}
		else if (r > 0.1 && g > 0.1 && b < 0.1) {
			colorChar = "G";
			Sound.buzz();
			Sound.beep();
		}
		else {
			colorChar = "N";
		}
		return colorChar;
	}
	
	//Turns the robot right
	public void turnRight() {
		pilot.rotate(90);
	}
	
	//Turns the robot left
	public void turnLeft() {
		pilot.rotate(-90);
	}
	
	//Turns the robot 180 degrees around
	public void rotate180() {
		pilot.rotate(180);
	}
	
	//Basic movement method for moving the robot forward
	public void moveForward() {
			
			pilot.forward();
			while (!(getIDColor() == Color.BLACK)) {
				Thread.yield();
			}
			pilot.stop();
			pilot.travel(12);
		}
	
	/*
	 * Advanced movement method dealing with the robots heading.
	 * If the robot wants to move in a certain direction but the current heading is wrong
	 * this method will adjust the heading to the desired direction.
	 * This method also updates the current x-y co-ordinate of the robot as well as updates the heading
	 */
	public void move( int moveDirection) {
		//Move North
		int newAngle = currAngle;
		if (moveDirection == 1) 
		{
			if (currAngle == 0)
			{
				moveForward();
			}
			else 
			{
				switch (currAngle) {
				case 90:
						turnLeft();
						break;
				case -90: 
						turnRight();
						break;
				case 180: 
						rotate180();
						break;
				}
				moveForward();
			}
			newAngle = 0;
			ycurrent = ycurrent - 1; 
		}
		//Move South
		else if (moveDirection == 2) 
		{
			if (currAngle == 180)
			{
				moveForward();
			}
			else 
			{
				switch (currAngle) {
				case 90: 
						turnRight();
						break;
				case -90: 
						turnLeft();
						break;
				case 0: 
						rotate180();
						break;
				}
				moveForward();
			}
			newAngle = 180;
			ycurrent = ycurrent + 1; 
		} 
		//Move West
		else if (moveDirection == 3) 
		{
			if (currAngle == -90)
			{
				moveForward();
			}
			else 
			{
				switch (currAngle) {
				case 0: 	
						turnLeft();
						break;
				case 180:
						turnRight();
						break;
				case 90: 
						rotate180();
						break;
				}
				moveForward();
			}
			newAngle = -90;
			xcurrent = xcurrent - 1; 
		} 
		
		//Move East
		else if (moveDirection == 4) 
		{
			if (currAngle == 90)
			{
				moveForward();
			}
			else 
			{
				switch (currAngle) {
				case 180: 
						turnLeft();
						break;
				case 0: 
						turnRight();
						break;
				case -90: 
						rotate180();
						 break;
				}
				moveForward();
			}
			newAngle = 90;
			xcurrent = xcurrent + 1; 
		} 
//		grid.symbolMap();
//		grid.robotLocation();
		currAngle = newAngle;
	}
	
	/*
	 * Method that deals with the astar search movement commands
	 * stores the direction results from the astar search into a stack and carries them out
	 */
	public void astarMovement(int[][] map, int xcord, int ycord) {
		Astar star = new Astar(map);
		Stack<Integer> moveStack = star.findPath(xcurrent, ycurrent, xcord , ycord);
		while (!moveStack.empty()) 
		{
			int val = moveStack.pop();
			move(val);
		}

		
	}
	
	
	

}
