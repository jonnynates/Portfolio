import java.io.*;
import java.net.*;
import java.util.*;
/**
 * This class is responsible for the connection and input of users to and from the chat server
 * @author u5jn
 *
 */
public class ClientInstance implements Runnable {

  /**
   * Declaring various class wide variables
   */
  //Socket declaration for the client
  private Socket clientSocket = null;
  // PrintWriter decleration
  private PrintWriter out = null;
  // BufferedReader decleration
  private BufferedReader br = null;
  private Scanner scan = new Scanner(System.in);
  /* This variable is used to tell if the BufferedReader, PrintWriter 
  	 and the socket are closed or not*/
  private boolean closed = false;
  // DataInputStream decleration
  private static DataInputStream is = null;
  
  /**
   * Method used to allow the user to change the server host address
   * @return the host address String
   */
  public String changeAddress() {
	System.out.println("Enter the desired server host:");
	String temp = scan.nextLine();
	return temp;
  }
  
  /**
   * Method used to allow the user to change the server port
   * @return the port number Int
   */
  public int changePort() { 
	System.out.println("Enter the desired server Port:");
	int temp = scan.nextInt();
	return temp;
  }
  
  /**
   * Method used to connect to the server which allows for communication.
   * Initialises the BufferedReader and PrintWriter this allows for input and output.
   */
  public void start() {
   /**
    * Default port and host host
	*/
	int portNum = 1111;
	String host = "localhost";
	
    int useChoice = 0;
    do { //Gives the user a choice between default settings or custom
    System.out.println("Do you want to use the default host/port or input a custom host/port?\n" 
    				+ "(1) Default (2) Custom");
    useChoice = scan.nextInt();
    if ((useChoice < 1) || (useChoice > 2)) {
    	System.out.println("Incorrect input.");
    }
    } while ((useChoice < 1) || (useChoice > 2));
    
    if (useChoice == 2) {
    	host = changeAddress();
		portNum = changePort();
    }
    
   //Attempts to connect to the server. Then opens the client socket.
    try {
    	System.out.println("Trying to connect to the chat server.");
	    clientSocket = new Socket(host, portNum);
	    //Initialises the BufferedReader, InputStream and PrintWriter
	    br = new BufferedReader(new InputStreamReader(System.in));
	    is = new DataInputStream(clientSocket.getInputStream());
	    out = new PrintWriter(new OutputStreamWriter(clientSocket.getOutputStream()));
    } catch (UnknownHostException e) { 
    	System.err.println("Unknown host error:");
    	System.err.println(e.getMessage());
	} catch (IOException e) {
		System.err.println("I/O Exception error:");
		System.err.println(e.getMessage());
    }


    if (clientSocket != null && out != null && br != null) {
      try {

        //Creates a thread used to handle reading from the server
        new Thread(new ClientInstance()).start();
        while (!closed) {
          out.println(br.readLine().trim()); //Handles writing to the server
          out.flush();
        }
        //Closes the socket and output/input
        out.close();
        br.close();
        clientSocket.close();
      } catch (IOException e) {
    	  System.err.println("I/O Exception error:");
    	  System.err.println(e.getMessage());
      }
    }
  }

  /**
   * Controls the termination of the client instance. 
   */
  public void run() {
	  String response; //holds text recieved from the server
	  boolean quit = false;
    
	  try {
		  while ((response = is.readLine()) != null && quit == false) {
			  System.out.println(response);
			  if (response == "Disconnected from the server")
				  quit = true;
		  }
		  closed = true;
	  } catch (IOException e) {
		  System.err.println("I/O Exception error:");
		  System.err.println(e.getMessage());
    }	
}
}