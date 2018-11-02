/**
 * The PredictableComputer class is a subclass of the Player class.
 * This class is responsible for deciding how the predictable class selects attributes
 * @author u5jn
 *
 */
import java.util.Random;

public class PredictableComputer extends Player {
	
	private int cselect;
	
	/**
	 * The constructor for the RandomComputer class is the same as the constructor for the Player class
	 * @param dA the array with the name of the attributes in the deck
	 * @param dS the size of the deck used
	 * @param pN the name of the player
	 */
	public PredictableComputer(String[] dA, int dS, String pN) {
		super(dA, dS, pN);
		Random rand = new Random();
		cselect = rand.nextInt(4) + 1;
	}
	
	/**
	 * The pick attribute method will return the same attribute solution every time it's called
	 * @return cselect value.
	 */
	public int pickAtt() {
		return cselect;
	}
}
