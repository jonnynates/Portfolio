import lejos.hardware.Button;
import lejos.robotics.Color;
import lejos.utility.Delay;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		ColourClass cc = new ColourClass();
		MessageSelect msgSel = new MessageSelect();
		PilotRobot me = new PilotRobot();
		msgSel.me = me;
		msgSel.cc = cc;
		
		
		msgSel.drawMessageSelect();
		do {
			while (cc.occupied = false || !Button.ESCAPE.isDown()) {
				if (Button.UP.isDown()) {
					
					msgSel.drawMovementSelect();
					Delay.msDelay(1000);
					do {
					while (cc.occupied = false || !Button.ESCAPE.isDown()) {
						if (Button.UP.isDown()) {
							
							msgSel.msgMove();
						}
						if (Button.DOWN.isDown()) {
				
							msgSel.msgRotate();
						}
						if (Button.RIGHT.isDown()) {
					
							msgSel.msgGoTo();
						}
					}
					} while (!Button.ESCAPE.isDown());
					msgSel.drawMessageSelect();
				}
				if (Button.DOWN.isDown()) {
		
					msgSel.msgDance();
				}
				if (Button.LEFT.isDown()) {
					msgSel.msgMap();
				}
				if (Button.RIGHT.isDown()) {
			
					msgSel.msgMessage();
				}
			}
			
		} while (!Button.ESCAPE.isDown());
			
		

		
		
	}

}
               