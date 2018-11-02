/**
 * This class calls the ClientInstance class and calls on the start method to start the execution 
 * of a ClientInstance
 * @author u5jn
 *
 */
public class ClientMain {
	
	/**
	 * Method used to call on the ClientInstance class
	 * and start execution
	 * @param args
	 */
	public static void main(String[] args) {
		ClientInstance client = new ClientInstance();
		client.start();

	}

}
