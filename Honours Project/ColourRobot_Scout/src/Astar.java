import java.util.*;
public class Astar {
	private int map[][]; //2D map array from GridMap
	//DirectionVector Dvector; //object used to output direction vectors (north[1,0],south[-1,0],east[0,1],west[0,-1]) to the robot 
	private final static int OBSTACLE = 1; //constant for checking if array cell is occupied
	private final static int MOVECOST = 1; //constant for working out G
	private final static int ARR_SIZE = 8;
	int startX, startY, goalX, goalY; //integer variables for storing x,y of start and goal states
	Node startNode, endNode; //objects to store start and goal positions
	Stack<Integer> movementStack;  //stack of direction vectors for storing shortest path vectors
	Queue<Node> openList = new PriorityQueue<Node>(); //open list for adding all nodes connected to curren selected node
	List<Node> closeList = new ArrayList<Node>();  //closed list for adding nodes relevant to shortest path 
	
	
	//constructor that creates an instance of the occupency matrix with obstacles
	public Astar(int occupencyMatrix[][]) {
		map = occupencyMatrix;
	}
	
	//method to be called in main robot program that passes in start and end coordinates and returns a stack of direction vectors
	public Stack <Integer> findPath (int sX, int sY, int gX, int gY) {
		movementStack = new Stack<Integer>();
		startNode = new Node (sX, sY);
		endNode = new Node (gX, gY);
		startX = sX;
		startY = sY;
		goalX = gX;
		goalY = gY;
		openList.clear(); //clears open list in case algorithm is used again
		closeList.clear();  //clears closed list in case algorithm is used again
		openList.add(startNode); //adds the starting node to open
		moveNodes(); //calls moveNodes 
		return movementStack;
	}
	
	//method that checks if there are nodes in open list and if there are adds one from top of the open list to the closed list and checks its neighbour
	private void moveNodes() {
		//while list that loops until open list is empty
		while (!openList.isEmpty()) {
			//checks if current node is next to goal if so call plan route to create list of 
			if (isCoordInClose(endNode.coord)) {
				planRoute(endNode, startNode);
				break;
			}
			Node current = openList.poll();
			closeList.add(current);
			addNeighbourToOpen(current);
		}
	}
	
	//method that takes in 2 nodes for start and end to return a stack of vectors 
	private void planRoute(Node end, Node start) {
		//while end node doesnt equal start loop
		while (end != start) {
			Coord current = end.coord;
			//if statement that checks current nodes coord against end coords parent
			if (current.y != end.parent.coord.y) { 
				if (1 == (current.y - end.parent.coord.y)) {
					//adds a movement vector to move North to the bottom of the list
					movementStack.push(2);	
				}
				else {
					//adds as movement vector to move South to the bottom of the list
					movementStack.push(1);
				}
			}
			//Checks if there is a change in X pos
			else if (current.x != end.parent.coord.x) { 
				if (1 == (current.x - end.parent.coord.x)) {
					//adds a movement vector to move West to the bottom of the list
					movementStack.push(4);
				}
				else {
					//adds a movement vector to move East to the bottom of the list
					movementStack.push(3);
				}
			}
			//changes node end to parent moving backwards from goal until it finds start
			end = end.parent;
		}
	}
	
	//method that takes in current node and calls method to check if available and add to parent for all adjacent cells
	private void addNeighbourToOpen(Node current) {
		int x = current.coord.x;
		int y = current.coord.y;
		addNeighbourToOpen(current, x + 1, y, MOVECOST); //adds to north
		addNeighbourToOpen(current, x - 1, y, MOVECOST); //adds to south
		addNeighbourToOpen(current, x, y - 1, MOVECOST); //adds to east
		addNeighbourToOpen(current, x, y + 1, MOVECOST); //adds to west
	}

	//method that checks if neighbour can be added to current cell then attaches a parent
	private void addNeighbourToOpen(Node current, int x, int y, int value) {
		//if statement that calls canAddNode function to check if cell does not have an obstacle or out of bounds
		if (nodeAvailable(x, y)) {
			Node end= endNode;
			Coord coord = new Coord(x, y);
			int G = current.G + value; //works out G
			Node child = findNodeInOpen(coord);
			if (child == null) {
				int H=calcH(end.coord,coord);
				// if statement that checks if coord is at goal 
				if(isEndNode(end.coord,coord)) {
					child=end;
					child.parent=current;
					child.G=G;
					child.H=H;
				}
				else {
					child = new Node(coord, current, G, H);
				}
				openList.add(child); //adds child to open list
			}
			else if (child.G > G) {
				child.G = G;
				child.parent = current;
				openList.add(child); //adds child to list if further from start
			}
		}
	}
	
	//method that takes in a coord and checks if position is in open list returning that particular node 
	private Node findNodeInOpen(Coord coord) {
		//if value passed in is null or list is empty return null
		if (coord == null || openList.isEmpty()) {
			return null;
		}
		//for loop that loops for every node in open list
		for (Node node : openList) {
			//if a node if found in list with same coordinates then return node
			if (node.coord.equals(coord)) {
				return node;
			}
		}
		return null;
	}
	
	//calculates the manhatten heuristic of the coordinate by returning the x and y distance from current coord to end node 
	private int calcH(Coord end,Coord coord) {
		return Math.abs(end.x - coord.x) + Math.abs(end.y - coord.y);
	}
	
	//method that checks if current current coordinates are the same as the end coordinates
	private boolean isEndNode(Coord end,Coord coord) {
		return coord != null && end.equals(coord);
	}
	
	//method that checks if current node position can be added to open list
	private boolean nodeAvailable(int x, int y) {
		//if the coordinates are out of bounds of the grid map return false
		if (x < 0 || x >= ARR_SIZE || y < 0 || y >= ARR_SIZE) {
			return false;
		//if the occupency value for particular X and Y is above 0.75 cell is occupied with an obstacle so returns false
		} else if (map[y][x] >= OBSTACLE) {
			return false;
		//if the current coordinate is already in the closed list then return false
		} else if (isCoordInClose(x, y)) {
			return false;
		} else {
		return true;
		}
	}
	
	//method that checks if current current coordinates is in close 
	private boolean isCoordInClose(Coord coord) {
		return coord!=null&&isCoordInClose(coord.x, coord.y);
	}
	
	//method called by same method but with different parameters to check if current coord is close
	private boolean isCoordInClose(int x, int y) {
		if (closeList.isEmpty()) {
			return false;
		}
		for (Node node : closeList) {
			if (node.coord.x == x && node.coord.y == y) {
				
				return true;
			}
		}
		return false;
	}
}