/**
 * The RandomComputer class is a subclass of the Player class.
 * This class is responsible for deciding how the random CPU takes a turn.
 * @author u5jn
 *
 */
import java.util.Random;

public class RandomComputer extends Player{
	
	/**
	 * The constructor for the RandomComputer class is the same as the constructor for the Player class
	 * @param dA the array with the name of the attributes in the deck
	 * @param dS the size of the deck used
	 * @param pN the name of the player
	 */
	public RandomComputer(String[] dA, int dS, String pN) {
		super(dA, dS, pN);
	}
	
	/**
	 * The pickAtt method selects a random number between 1-4 this randomly decides
	 * what attribute the CPU will play that round
	 * @return a random number between 1-4
	 */
	public int pickAtt() {
		int cselect = -1; //for testing: if -1 makes it through then there is an error in the code
		Random rand = new Random();
		cselect = rand.nextInt(4) + 1;
		return cselect;
		
	}
}
