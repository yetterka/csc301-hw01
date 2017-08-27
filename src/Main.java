import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
	}
	
	public static List<Point> closestPathFinder(List<Point> pointList){
		List<Point> path = new ArrayList<Point>();
		Random rn = new Random();
		Point startPoint = pointList.get(rn.nextInt(pointList.size()));
		path.add(startPoint);
		startPoint.visited = true;
		for(Point point : pointList){
			point.distanceTo(startPoint);
		}
		return path;
	}

}
