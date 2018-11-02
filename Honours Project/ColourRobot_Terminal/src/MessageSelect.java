import lejos.hardware.ev3.LocalEV3;
import lejos.hardware.lcd.GraphicsLCD;
import lejos.utility.Delay;
import lejos.hardware.lcd.Font;

public class MessageSelect {
	PilotRobot me;
	ColourClass cc;
	GraphicsLCD lcd = LocalEV3.get().getGraphicsLCD();
	
	private static int map[][] = {
			   //0 1 2 3 4 5 6 7
				{1,1,1,1,1,1,1,1}, //0
				{1,0,0,0,0,0,0,1}, //1
				{1,0,0,1,0,1,0,1}, //2
				{1,0,1,0,0,0,0,1}, //3
				{1,0,0,0,0,0,0,1}, //4
				{1,0,0,0,0,1,1,1}, //5
				{1,1,0,0,0,0,0,1}, //6
				{1,1,1,1,1,1,1,1}  //7
			};
	
	public void drawMessageSelect() {	
		lcd.clear();
		lcd.setFont(Font.getDefaultFont());
		lcd.drawString("Command List", 20 , 0, 0);
		lcd.drawString("UP: MOVEMENT", 0 , 20, 0);
		lcd.drawString("DOWN: DANCE", 0 , 40, 0);
		lcd.drawString("LEFT: MAP", 0 , 60, 0);
		lcd.drawString("RIGHT: MESSAGE", 0 , 80, 0);
		lcd.setFont(Font.getSmallFont());
		lcd.drawString("ESC: EXIT", 0 , 120, 0);
		
		
	}
	
	public void drawMovementSelect() {
		lcd.clear();
		lcd.setFont(Font.getDefaultFont());
		lcd.drawString("Movement List", 20 , 0, 0);
		lcd.drawString("UP: MOVE", 0 , 20, 0);
		lcd.drawString("DOWN: ROTATE", 0 , 40, 0);
		lcd.drawString("RIGHT: GO TO", 0 , 60, 0);
		lcd.setFont(Font.getSmallFont());
		lcd.drawString("ESC: BACK", 0 , 120, 0);
	}
	
	public void drawRunning() {
		lcd.clear();
		lcd.drawString("Message currently being sent", 0, 60, 0);
	}
	
	public void drawDone() {
		lcd.clear();
		lcd.setFont(Font.getDefaultFont());
		lcd.drawString("Message sent", 30 , 60, 0);
		Delay.msDelay(3000);
		drawMessageSelect();
	}
	
	public void msgMove() {
		drawRunning();
		cc.sender("MOVE");
		Delay.msDelay(4000);
		cc.sender("UP");
		Delay.msDelay(4000);
		cc.sender("2");
		drawDone();
	}
	
	public void msgRotate() {
		drawRunning();
		cc.sender("ROTATE");
		Delay.msDelay(4000);
		cc.sender("RIGHT");
		Delay.msDelay(4000);
		cc.sender("45");
		drawDone();
	}
	
	public void msgMessage() {
		drawRunning();
		cc.sender("MESSAGE");
		Delay.msDelay(4000);
		cc.sender("HELLO WORLD");
		drawDone();
	}
	
	public void msgGoTo() {
		drawRunning();
		cc.sender("GOTO");
		Delay.msDelay(4000);
		cc.sender("1");
		Delay.msDelay(4000);
		cc.sender("5");
		drawDone();
	}
	
	public void msgDance() {
		drawRunning();
		cc.sender("DANCE");
		drawDone();
	}
	
	public void msgMap() {
		drawRunning();
		cc.sender("MAP");
		Delay.msDelay(4000);
		int rows = map.length;
		int cols = map[0].length;
		//String test = "";
		for (int i = 0; i < rows; i++) 
		{
			for (int j = 0; j < cols; j++) 
			{
				if (map[i][j] == 1) {
					me.flashRed();
					//test = test + "R";
				}
				if (map[i][j] == 0) {
					me.flashBlue();
					//test = test + "B";
				}
				Delay.msDelay(4000);
			}
			//System.out.println(test);
			//test = "";
		}
		me.flashGreen();
		drawDone();
	}
	
	
	
}
