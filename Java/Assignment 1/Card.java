/**
 * The card class is used to store individual card details.
 * It has the ability to store four attributes for a single card.
 * @author u5jn
 *
 */
import java.util.Random;

public class Card {

	/**
	 * Class wide variables used throughout the Card class.
	 * These attribute variables are used to store information about the card
	 */
	 private Attribute att1 = new Attribute("",0);
	 private Attribute att2 = new Attribute("",0);
	 private Attribute att3 = new Attribute("",0);
	 private Attribute att4 = new Attribute("",0);
	 
	
	/**
	 * Constructor for the Card class
	 * The attribute names are received through an array and the attribute values
	 * are decided through a randomiser. The values will be between 0-9
	 * @param arrAttribute an array that has all the attribute names
	 */
	public Card(String[] arrAttribute) {
		Random rand = new Random();
		att1.editName(arrAttribute[0]);
		att1.editValue(rand.nextInt(10));
		att2.editName(arrAttribute[1]);
		att2.editValue(rand.nextInt(10));
		att3.editName(arrAttribute[2]);
		att3.editValue(rand.nextInt(10));
		att4.editName(arrAttribute[3]);
		att4.editValue(rand.nextInt(10));
	}
	
	/**
	 * This method returns the requested attribute value
	 * @param reqNum the position of the attribute 
	 * @return the value of the attribute
	 */
	public int getVal(int reqNum) {
		int temp = -1;
		switch (reqNum) {
			case 1: 	temp = att1.readCardValue();
						break;
			case 2: 	temp = att2.readCardValue();
						break;
			case 3: 	temp = att3.readCardValue();
						break;
			case 4: 	temp = att4.readCardValue();
						break;
		}
		return temp;
	}
	
	/**
	 * Method that writes down all the card's attribute names and their corresponding values
	 */
	public void writeCardDetails() {
		System.out.println("(1)" + att1.readCardName() + " : " + att1.readCardValue() );
		System.out.println("(2)" + att2.readCardName() + " : " + att2.readCardValue() );
		System.out.println("(3)" + att3.readCardName() + " : " + att3.readCardValue() );
		System.out.println("(4)" + att4.readCardName() + " : " + att4.readCardValue() );
	}
}
