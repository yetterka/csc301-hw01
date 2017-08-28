import java.util.Comparator;


public class Point implements Comparator<Point>{
	int x;
	int y;
	
	public Point(int x, int y){
		this.x = x;
		this.y = y;
	}
	
	public void print(){
		System.out.printf("(%d, %d)\n", this.x, this.y);
	}
	
	public int diagonalValue(){
		return x-y;
	}
	
	public int compare(Point p1, Point p2){
		if(p1.diagonalValue() == p2.diagonalValue()){
			return p1.x - p2.x;
		}
		return p1.diagonalValue() - p2.diagonalValue(); 
	}

	public double distanceTo(Point p){
		return Math.sqrt(Math.pow(this.x - p.x, 2) + Math.pow(this.y - p.y, 2));
	}
}
