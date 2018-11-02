/**
 * The Game class contains most of the logic needed in order to run the game.
 * @author u5jn
 *
 */
import java.util.*;

public class Game {
	
	/**
	 * Class wide variables used within the Game class.
	 * The arrAttributeNames is used to store the names of all the attributes used in the deck
	 * The arrPlayers is used to store the Player object of all the players in the game
	 * The dsize refers to the amount of cards in the deck
	 */
	private Scanner input = new Scanner(System.in);
	private String[] arrAttributeNames = new String []{ "","","",""};
	private ArrayList<Player> arrPlayers = new ArrayList<Player>();
	private int dsize;
			
	/**
	 * Constructor for the Game class. 
	 * Sets preset values for some of the variables in case the user doesn't edit 
	 * the deck type or size
	 */
	public Game() {
		dsize = 10;
		arrAttributeNames[0] = "Strength";
		arrAttributeNames[1] = "Inteligence";
		arrAttributeNames[2] = "Speed";
		arrAttributeNames[3] = "Agility";
	}
	
	/**
	 * This method allows the user to setup the game. Allowing them to change how the
	 * game is played. For example they can't decide if they want to edit the deck type.
	 */
	public void startGame() {
		int userInput;
		do{
			System.out.println("----Card Game----");
			System.out.println("Welcome to Top Trumps!");
			System.out.println("Select an option from the menu:");
			System.out.println("1. Random Computer (Starts Game).");
			System.out.println("2. Predictable Computer (Starts Game).");
			System.out.println("3. Change Deck Type (Optional).");
			System.out.println("4. Change Deck size (Default is 10).");
			System.out.println("5. Exit Game");
			System.out.println("-----------------");
			userInput = input.nextInt();
		
			switch(userInput){
			case 1: gameLogic(1);
					break;
			case 2: gameLogic(2);
					break;
			case 3: setDeckType();
					break;
			case 4: setDeckSize();
					break;
			} 
			
			if ((userInput<1) || (userInput >5)) {
				System.out.println("Incorrect input. Try again");
			}
		} while(userInput != 5);
		System.exit(0);
	}
	
	/**
	 * This method allows the user to select which deck they want to use. 
	 * There are 3 pre-set decks to choose from as well as the option to create a custom deck
	 */
	public void setDeckType() {
		int dtype;
		do { //validation
			System.out.println("What type of deck do you want to use? Super Heroes (1), Cars (2), Pokemon (3) or Create your own(4)? ");
			dtype = input.nextInt();
			if ((dtype < 1) || (dtype > 4)) {
				System.out.println("Incorrect input. Try again");
			}
			
		} while ((dtype < 1) || (dtype > 4));
		
		switch(dtype){
		//Heroes
		case 1: arrAttributeNames[0] = "Strength";
				arrAttributeNames[1] = "Inteligence";
				arrAttributeNames[2] = "Speed";
				arrAttributeNames[3] = "Agility";
				System.out.println("Deck type has been sucessfully changed to: Superheroes Deck.");
				break;
		//Car
		case 2: arrAttributeNames[0] = "Top Speed";
				arrAttributeNames[1] = "Acceleration";
				arrAttributeNames[2] = "Handling";
				arrAttributeNames[3] = "Price";
				System.out.println("Deck type has been sucessfully changed to: Car Deck.");
				break;
		//Pokemon
		case 3: arrAttributeNames[0] = "Attack";
				arrAttributeNames[1] = "Defense";
				arrAttributeNames[2] = "Accuracy";
				arrAttributeNames[3] = "Speed";
				System.out.println("Deck type has been sucessfully changed to: Pokemon Deck.");
				break;
		//Custom Deck
		case 4: System.out.println("Enter the name for Attribute One:");
				arrAttributeNames[0] = input.nextLine();
				System.out.println("Enter the name for Attribute Two:");
				arrAttributeNames[1] = input.nextLine();
				System.out.println("Enter the name for Attribute Three:");
				arrAttributeNames[2] = input.nextLine();
				System.out.println("Enter the name for Attribute Four:");
				arrAttributeNames[3] = input.nextLine();
				System.out.println("Your custom deck has sucessfully been created.");
				break;		
		}
	}
	
	/**
	 * This method sets the size of the deck that each player will play with.
	 */
	public void setDeckSize() {
		do { //validation
			System.out.println("What size deck would you like to play with? (Between 1-25 only)");
			dsize = input.nextInt();
			if ((dsize < 1) || (dsize > 25)) {
				System.out.println("Incorrect input. Try again");
			}
		} while ((dsize < 1) || (dsize > 25));
		System.out.println("The deck size has sucessfully been changed to " + dsize);
	}
	
	/**
	 * This method is used to create objects for all players playing the game
	 * @param cpuType this variable decides what type of CPU opponent needs to be created
	 */
	public void createPlayers(int cpuType) {
		//adds human player
		String pname;		
		System.out.println("Player 1 please input your name: ");
		input.nextLine();
		pname = input.nextLine();
		Player humanPlayer = new Human(arrAttributeNames, dsize, pname);
		arrPlayers.add(humanPlayer);
		
		//adds cpu player
		switch (cpuType) {
		case 1: Player cpuRPlayer = new RandomComputer(arrAttributeNames, dsize, "CPU");
				arrPlayers.add(cpuRPlayer);
				break;
		case 2: Player cpuPPlayer = new PredictableComputer(arrAttributeNames, dsize, "CPU");
				arrPlayers.add(cpuPPlayer);
				break;
		}
		
	}
	
	/**
	 * This method draws a card for every player in the game
	 */
	public void drawCards() {
		Player player1 = arrPlayers.get(0);
		player1.drawCard();
		Player player2 = arrPlayers.get(1);
		player2.drawCard();
	}
	
	/**
	 * This method determines which player is the winner of the current round.
	 * The player with the highest valued attribute wins.
	 * @param attNum the attribute number that was chosen for that round
	 * @return the player that won the round
	 */
	public Player checkWinner(int attNum) {
		int valPlay1, valPlay2;
		Player win;
		Player player1 = arrPlayers.get(0);
		Player player2 = arrPlayers.get(1);
		valPlay1 = player1.getAttVal(attNum);
		valPlay2 = player2.getAttVal(attNum);
		if (valPlay1 > valPlay2) {
			win = player1;
		}
		else win = player2;
		return win;
	}
	
	/**
	 * This method adds the cards used in the previous round to the winner's deck
	 * @param win the player that won the previous round
	 */
	public void addCards(Player win) {
		Player currPlayer;
		Card currCard;
		for (int i = 0; i < 2; i++) {
			currPlayer = arrPlayers.get(i);
			currCard = currPlayer.getCurrCard();
			win.addCard(currCard);
		}
	}
	
	/**
	 * This method checks if any of the players have run out of cards in their deck
	 */
	public void checkEmptyDeck() {
		Player currPlayer;
		boolean emptyDeck;
		for (int i = 0; i < 2; i++) {
			emptyDeck = false;
			currPlayer = arrPlayers.get(i);
			emptyDeck = currPlayer.playOut();
			if (emptyDeck == true) {
				System.out.println(currPlayer.getPlayName() + " has run out of cards.");
				arrPlayers.remove(currPlayer);
			}
		}
	}
	
	/**
	 * This method is responsible for printing the amount of cards left in each player's decks
	 */
	public void printDeckCardNum() {
		Player currPlayer;
		for (int i = 0; i < 2; i++) {
			currPlayer = arrPlayers.get(i);
			System.out.println(currPlayer.getPlayName() + " has " + currPlayer.cardsDeck() + " cards left in their deck");
		}
	}
	
	/**
	 * This method is responsible for handling the game's flow.
	 * It brings all the methods together to create the game's logic
	 * @param cpuType the type of CPU opponent
	 */
	public void gameLogic(int cpuType) {
		arrPlayers.clear();
		boolean gameEnd = false;
		createPlayers(cpuType);
		Player win = arrPlayers.get(0); //sets the winner to the first player so that player 1 takes the first turn

		while (gameEnd == false) {
			printDeckCardNum();
			drawCards();
			int attSelection = win.pickAtt();
			System.out.println(win.getPlayName() + " has selected the " + arrAttributeNames[attSelection - 1] + " attribute");
			win = checkWinner(attSelection);
			System.out.println(win.getPlayName() + " has won the round. The winning attribute was " + win.getAttVal(attSelection));
			addCards(win);
			System.out.println("-----Round End-----");
			checkEmptyDeck();
			if (arrPlayers.size() == 1 ) { //If only one player remains in the list that means there is a winner
				gameEnd = true;
				System.out.println(win.getPlayName() + " has won the game.");
				System.out.println(win.getPlayName() + " had " + win.cardsDeck() + " cards left in their deck.");
			}
		}
	}
}
