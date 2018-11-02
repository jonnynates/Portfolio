//basic object that stores an X and Y value into a coord that is then assigned to a node
public class Coord {
	public int x;
	public int y;

	public Coord(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
	//overide method that checks if object being passed in contains a coord and then checks if coords equal to object being passed it
	@Override
	public boolean equals(Object obj)
	{
		if (obj == null) return false;
		if (obj instanceof Coord)
		{
			Coord c = (Coord) obj;
			return x == c.x && y == c.y;
		}
		return false;
	}
}
