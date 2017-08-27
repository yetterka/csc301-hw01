
public class Point {
	int x;
	int y;
	boolean visited;
	
	public Point(int x, int y){
		this.x = x;
		this.y = y;
		visited = false;
	}

	public double distanceTo(Point p){
		return Math.sqrt(Math.pow(this.x - p.x, 2) + Math.pow(this.y - p.y, 2));
	}
}
