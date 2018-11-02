/**
 * The Attribute class stores the attribute name and the value of a single attribute.
 * The methods available in this class allow for the reading and writing of the attribute.
 * @author u5jn
 *
 */
public class Attribute {

	/**
	 * Class wide variables used in the Attribute class
	 * attVal stores the integer value of the attribute
	 * attName stores the name of the attribute
	 */
	private int attVal;
	private String attName;
	
	/**
	 * Constructor used to instantiate the attribute class
	 * @param n contains the name of the attribute that will be used
	 * @param v contains the value of the attribute that will be used
	 */
	public Attribute(String n, int v) {
		attName = n;
		attVal = v;	
	}
	
	/**
	 * Method that returns the attribute name on the card
	 * @return returns the attribute name 
	 */
	public String readCardName() {
		return attName;
	}
	
	/**
	 * Method that returns the value of the card
	 * @return returns the value 
	 */
	public int readCardValue() {
		return attVal;
	}
	
	/**
	 * Changes the current attribute name to the new name passed by the parameter
	 * @param newName the new attribute name that overrides the previous attribute name 
	 */
	public void editName(String newName) {
		attName = newName;
	}
	
	/**
	 * Changes the current attribute value to the new value passed by the parameter
	 * @param newValue the new value that overrides the previous value
	 */
	public void editValue(int newValue) {
		attVal = newValue;
	}
	
}
