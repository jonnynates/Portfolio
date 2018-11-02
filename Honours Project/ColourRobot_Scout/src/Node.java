//Node object that implements comparable list that can be used to check all created nodes
public class Node implements Comparable <Node> {
		public Coord coord; //coord object for storing X and Y
		public Node parent; // connected node in path
		public int G; //stores distance from start of current node
		public int H; //stores Heuristic of current node

		//constructor for creating a node without knowing the h and g values
		public Node(int x, int y)
		{
			this.coord = new Coord(x, y);
		}
		
		//constructor that adds parent, g and h values
		public Node(Coord coord, Node parent, int g, int h)
		{
			this.coord = coord;
			this.parent = parent;
			G = g;
			H = h;
		}
		
		//method that compares nodes and orders them by F value in A* (G(n) + H(n)
		@Override
		public int compareTo(Node o)
		{
			if (o == null) return -1;
			if (G + H > o.G + o.H)
				return 1;
			else if (G + H < o.G + o.H) return -1;
			return 0;
		}
}
