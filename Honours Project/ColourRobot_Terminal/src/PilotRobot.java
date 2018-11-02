import java.util.Stack;

import lejos.hardware.Brick;
import lejos.hardware.BrickFinder;
import lejos.hardware.Button;
import lejos.hardware.Sound;
import lejos.hardware.ev3.LocalEV3;
import lejos.hardware.motor.Motor;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.EV3ColorSensor;
import lejos.hardware.sensor.EV3TouchSensor;
//import lejos.hardware.sensor.NXTColorSensor;
import lejos.robotics.Color;
import lejos.robotics.SampleProvider;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.navigation.MovePilot;
import lejos.hardware.lcd.GraphicsLCD;
//import lejos.hardware.lcd.LCD;
//import lejos.robotics.navigation.Move;

public class PilotRobot {
	
	char colorChar;
	
	private MovePilot pilot;

	GraphicsLCD lcd = LocalEV3.get().getGraphicsLCD();

	
	public PilotRobot() {	
		/* Setup Pilot */
		Brick myEV3 = BrickFinder.getDefault();
		
	
	}
	
	//Method that returns the pilot to be used in other classes
	public MovePilot getPilot() {
		return pilot;
	}
	
	public void flashRed() {
		Motor.D.rotateTo(90);
	}
	
	public void flashBlue() {
		Motor.D.rotateTo(-90);
	}
	
	public void flashGreen() {
		Motor.D.rotateTo(0);
	}
	
	
	
	
	

	
	
	

}
