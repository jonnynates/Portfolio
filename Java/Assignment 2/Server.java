import java.io.*;
import java.net.*;
import java.util.*;

/**
 * This class is responsible for running the chat server and handling the connection of clients
 * @author u5jn
 *
 */
public class Server {

  // The server socket.
private static ServerSocket servSocket= null;
  // The client socket.
private static Socket clientSocket = null;
  // This chat server can accept up to servClientCap clients' connections.
private static final int servClientCap = 10;
  // An array that holds all the client threads
private static final clientThread[] t = new clientThread[servClientCap];
private static long servUptime; //Ammount of time the server has been running
 
/**
 * This method is responsible for intialising the server socket
 * It also manages new connections
 * @param args
 */
public static void main(String args[]) {

    // The default port number.
	int portNum = 1111;

    try {
      System.out.println("Attemping to start the server.\n" + "Using the port number: " + portNum);
      servSocket = new ServerSocket(portNum);
      System.out.println("The Chat Server is now active.");
      servUptime = System.currentTimeMillis(); //Starts the server timer
    } catch (IOException e) {
    	System.err.println("I/O Exception error:");
    	System.out.println(e.getMessage());
    }

    /*
     * A client socket is assigned to every new connection
     * A new thread is also created for every new user
     */
    while (true) {
      try {
        clientSocket = servSocket.accept();
        int i = 0;
        for (i = 0; i < servClientCap; i++) {
          if (t[i] == null) {
            (t[i] = new clientThread(clientSocket, t,servUptime)).start();
            System.out.println("A new user has connected.");
            break;
          }
        }
        if (i == servClientCap) { //In the case that the server is full
          PrintStream out = new PrintStream(clientSocket.getOutputStream());
          out.println("Server is full. Try again later.");
          out.flush();
          out.close();
          clientSocket.close();
        }
      } catch (IOException e) {
    	  System.err.println("I/O Exception error:");
    	  System.out.println(e.getMessage());
      }
    }
  }
}

/**
 * This class is responsible for handling a single user by 
 * assigning it it's own thread
 * @author u5jn
 *
 */
class clientThread extends Thread {

	/**
	 * Declaring various class wide variables
	 */
private String uname = null;
private long servUptime;
private long userTimer;
private BufferedReader in = null;
private PrintWriter out = null;
private Socket clientSocket = null;
private final clientThread[] t;
private final int servClientCap;
//Hashset that stores the usernames of all the new users
private Set<String> clientList = Collections.synchronizedSet(new HashSet<String>());

/**
 * Constructor for the clientThread class
 * @param cs the client socket
 * @param thread the array of threads
 * @param time the up time of the server
 */
  public clientThread(Socket cs, clientThread[] thread, Long time) {
    clientSocket = cs;
    t = thread;
    servClientCap = thread.length;
    userTimer = System.currentTimeMillis();
    servUptime = time;
  }
  
  /**
   * Method responsible for broadcasting a new client joining the server to all
   * users in the server
   * @param out the PrintWriter
   */
  public void clientJoined(PrintWriter out) {
	   synchronized (this) {
	        for (int i = 0; i < servClientCap; i++) {
	          if (t[i] != null && t[i] != this) {
	            t[i].out.println("-----" + uname + " has entered the chat server-----");
	            out.flush();
	          }
	        }
	      }
  }
  
  /**
   * Method responsible for broadcasting when a client leaves the server to all
   * users in the server
   * @param out the PrintWriter
   */
  public void clientLeaves(PrintWriter out) {
	  synchronized (this) {
	        for (int i = 0; i < servClientCap; i++) {
	          if (t[i] != null && t[i] != this   && t[i].uname != null) {
	            t[i].out.println("-----" + uname  + " has disconnected from the chat server-----");
	            out.flush();
	          }
	        }
	      } 
  }
  
  /**
   * Method responsible for broadcasting a message to all users in the chat
   * @param out PrintWriter
   * @param line String containing the message being sent
   */
  public void servCommunication(PrintWriter out, String line) {
	  synchronized (this) {
          for (int i = 0; i < servClientCap; i++) {
            if (t[i] != null && t[i].uname != null) {
              t[i].out.println("<" + uname + ">: " + line);
              out.flush();
            }
          }
        }
  }
  
  /**
   * Method responsible for dealing with command requests.
   * @param out PrintWriter
   * @param line String containing the command
   */
  public void servCommands(PrintWriter out, String line) {
	  synchronized (this) {
		  switch (line) {
		  //List of available commands
		  case "/help": 
			  out.println("/cct : returns the client's connection time on the server");
			  out.println("/sct : returns the server's up time");
			  out.println("/sip : returns the server's IP address");
			  out.println("/nc : returns the number of users connected to the chat server");
			  out.println("/help : returns a list of available commands");
			  out.println("/quit : disconnects the user from the server");
			  out.flush();
			  break;
		  //Up time of the client in seconds
		  case "/cct": 
			  out.println(((System.currentTimeMillis() - userTimer) / 1000) + " seconds.");
			  out.flush();
			  break;
		  //Up time of the server in seconds
		  case "/sct":
			  out.println(((System.currentTimeMillis() - servUptime) / 1000) + " seconds.");
			  out.flush();
			  break;
		  //IP address of the server
		  case "/sip":
			  try {
					out.println(InetAddress.getLocalHost());
					out.flush();
				} catch (UnknownHostException e) {
					System.err.println("Unknown Host Exception: ");
					System.err.println(e.getMessage());
				} break;
		  //The number of users on the server
		  case "/nc": 
			  out.println(clientList.size());
			  out.flush();
		  }
	  }
  }

  /**
   * Execution of the thread begins here.
   * Reads from the BufferedReader and determines which action to take
   */
  public void run() {

    try {
      in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
      out = new PrintWriter(new OutputStreamWriter(clientSocket.getOutputStream()));

      while (true) {
    	  //Gets the username for new users
    	  out.println("Enter your username.");
    	  out.flush();
    	  uname = in.readLine().trim();
    	  if (clientList.contains(uname)) { 
    		  out.println("The username is already taken.");
              out.flush();
        } else {
        	clientList.add(uname);
            break;
        }
      }

      out.println("You have entered the chat server.\nTo disconnect from the server enter /quit.\nEnter /help for a list of system commands.");
      out.flush();
      clientJoined(out);
     
      boolean quit = false;
		while(quit == false){
			String line = in.readLine();
			//Checks if the line inputted is a quit command
			if (line == "/quit")
				quit = true;
			else{
				if(line.startsWith("/")){
					//If the message begins with a / it is considered a command
					servCommands(out,line);
				} else{
					//Broadcasts message to other users
					servCommunication(out, line);
				}
			}
		}
      
      clientLeaves(out);
      out.println("-----Disconnected from chat server-----");
      out.flush();


      //Removes this thread from the array to allow new users to join
      synchronized (this) {
        for (int i = 0; i < servClientCap; i++) {
          if (t[i] == this) {
            t[i] = null;
          }
        }
      }
      
      in.close();
      out.close();
      clientSocket.close();
    } catch (IOException e) {
    	System.err.println("I/O Exception error:");
    	System.err.println(e.getMessage());
    }
  }
}