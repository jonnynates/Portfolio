/**
 * The Human class is a subclass of the player class.
 * It's used to select an attribute during the player's turn.
 * @author u5jn
 *
 */
import java.util.Scanner;


public class Human extends Player{
	
	private Scanner input = new Scanner(System.in);
	
	/**
	 * The constructor for the human class is the same as the constructor for the Player class
	 * @param dA the array with the name of the attributes in the deck
	 * @param dS the size of the deck used
	 * @param pN the name of the player
	 */
	public Human(String[] dA, int dS, String pN) {
		super(dA, dS, pN);
	}
	
	/**
	 * The pickAtt method asks for user input and then returns the position value of the
	 * selected attribute. This position is to be use in other methods
	 * @return returns the position of the selected attribute
	 */
	public int pickAtt() {
		int pselect = -1; //for testing: if -1 makes it through then there is an error in the code
		System.out.println("---------------");
		System.out.println(playName + "'s current held card: ");
		heldCard.writeCardDetails();
		System.out.println("---------------");
		
		do { //validation
			System.out.println("Select an attribute to play (input 1-4)");
			pselect = input.nextInt();
		} while ((pselect < 1) || (pselect > 4));
		return pselect;
	}
	
}
