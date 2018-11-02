/**
 * The main class starts the execution of the program by calling the Game class which 
 * then runs all the logic for the game
 * @author u5jn
 *
 */
public class Main {
	
	/**
	 * The main method is responsible for calling the Game class which then runs
	 * the rest of the game
	 * @param args
	 */
	public static void main(String[] args) {
		Game topTrumps = new Game();
		topTrumps.startGame();
	}

}
