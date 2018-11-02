/**
 * The player class allows for interaction between the cards in the deck and the player.
 * @author u5jn
 *
 */
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class Player {
	/**
	 * Class wide variables used for the Player class.
	 * Variables include: the size of the deck, an array that holds all the attribute names,
	 * the card currently held by the player and a queue to hold the deck of cards.
	 */
	protected String playName;
	protected int deckSize;
	protected String[] deckAttribute; 
	protected Card heldCard;
	protected BlockingQueue<Card> deck = new LinkedBlockingQueue<Card>();
	
	/**
	 * Constructor for the Player class.
	 * Used to populate the deck with random values
	 * @param dA the array with the name of the attributes in the deck
	 * @param dS the size of the deck used
	 * @param pN the name of the player
	 */
	public Player(String[] dA, int dS, String pN) {
		deckAttribute = dA;
		deckSize = dS;
		playName = pN;
		for (int i = 0; i < deckSize; i++) {
			Card card = new Card(deckAttribute);
			deck.add(card);
		}
		
	}
	
	/**
	 * This method draws the top card from the deck (queue) and sets
	 * it to the heldCard variable.
	 */
	public void drawCard() {
		heldCard = deck.remove();
		System.out.println(playName + " has drawn a card");
	}
	
	/**
	 * This method returns the current card held
	 * @return the Card object heldCard
	 */
	public Card getCurrCard() {
		return heldCard;
	}
	
	/**
	 * Adds a card to the bottom of the queue (deck)
	 * @param c is the new card being added to the deck
	 */
	public void addCard(Card c) {
		deck.add(c);
	}
	
	/**
	 * This method is used to check if the player's deck is out of cards
	 * @return true if the player has ran out of cards
	 *  	   false if the player still has cards in their deck
	 */
	public boolean playOut() {
		return deck.isEmpty();
	}
	
	/**
	 * This method returns the number of cards left in the queue/deck
	 * @return number of cards left in the queue
	 */
	public int cardsDeck() {
		return deck.size();
	}
	
	/**
	 * This method returns the value of the selected attribute 
	 * @param attNum the position of the attribute in the array
	 * @return the value of the attribute
	 */
	public int getAttVal(int attNum) {
		int val = heldCard.getVal(attNum);
		return val;
	}
	
	/**
	 * This method returns the player's name
	 * @return player's name
	 */
	public String getPlayName() {
		return playName;
	}
	
	/**
	 * This method is just a base case method. It will be overwritten by the subclasses.
	 * The value 0 is used for debugging. If teh value 0 shows up there is an error somewhere
	 * in the code.
	 * @return
	 */
	public int pickAtt() {
		return 0; // value is 0 because there is no case 0 in the card get attribute value method
	}
	
}
