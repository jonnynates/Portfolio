import lejos.hardware.Button;
import lejos.robotics.Color;

public class Main {

	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PilotRobot me = new PilotRobot();
		ColourClass cc = new ColourClass();
		CommandClass command = new CommandClass();
		
		me.command = command;
		me.cc = cc;
		cc.me = me;
		command.cc = cc;
		command.me = me;
		
		
		while (!Button.ESCAPE.isDown()){
			me.getMessages();
			
		} 
		
	}

}
               