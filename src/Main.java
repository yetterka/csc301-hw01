import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Set<Point> points = pointGenerator(10);
		List<Point> list = new ArrayList<Point>(points);
		double unsortedDistance = checkPathDistance(list);
		System.out.printf("Unsorted distance is: %f\n", unsortedDistance);
		
		Set<Point> closestPtSet = new HashSet<Point>(points);
		List<Point> closestPoints = closestPathFinder(closestPtSet);
		System.out.printf("Closet path algorithm distance: %f\n", checkPathDistance(closestPoints));
		
		Set<Point> diagonalPtSet = new HashSet<Point>(points);
		List<Point> diagonalPoints = diagonalPathFinder(diagonalPtSet);
		System.out.printf("Diagonal path algorithm distance: %f\n", checkPathDistance(diagonalPoints));
		
		Set<Point> randomPtSet = new HashSet<Point>(points);
		List<Point> randomPoints = randomPathFinder(randomPtSet);
		System.out.printf("Random path algorithm distance: %f\n", checkPathDistance(randomPoints));
		
		Set<Point> longestPtSet = new HashSet<Point>(points);
		List<Point> longestPoints = randomPathFinder(longestPtSet);
		System.out.printf("Longest path algorithm distance: %f\n", checkPathDistance(longestPoints));
	}
	
	/**
	 * Problem 2 Part A
	 * @param pointsToVisit: the set of points in the problem
	 * @return a list containing points organized by the closest path algorithm
	 */
	public static List<Point> closestPathFinder(Set<Point> pointsToVisit){
		List<Point> path = new ArrayList<Point>();
		Random rn = new Random();
		Point startPoint = (Point) pointsToVisit.toArray()[rn.nextInt(pointsToVisit.size())];
		path.add(startPoint);
		pointsToVisit.remove(startPoint);
		Point prevPoint = startPoint;
		while(!pointsToVisit.isEmpty()){
			Point minPoint = null;
			for(Point point : pointsToVisit){
				Double dist = point.distanceTo(prevPoint);
				if(minPoint == null || dist < minPoint.distanceTo(prevPoint)){
					minPoint = point;
				}
			}
			path.add(minPoint);
			pointsToVisit.remove(minPoint);
			prevPoint = minPoint;
		}
		return path;
	}
	
	/**
	 * Problem 2 Part B
	 * @param pointsToVisit: the set of points in the problem
	 * @return a list containing points organized by the diagonal path algorithm
	 */
	public static List<Point> diagonalPathFinder(Set<Point> pointsToVisit){
		List<Point> path = new ArrayList<Point>(pointsToVisit);
		path.sort(new Point(0,0));
		return path;
	}
	
	/**
	 * Problem 2 Part C
	 * @param pointsToVisit: the set of points in the problem
	 * @return a list containing points organized by the random path algorithm
	 */
	public static List<Point> randomPathFinder(Set<Point> pointsToVisit){
		List<Point> path = new ArrayList<Point>();
		List<Point> pointsToVisitList = new ArrayList<Point>(pointsToVisit);
		Random rn = new Random();
		while(!pointsToVisitList.isEmpty()){
			int index = rn.nextInt(pointsToVisitList.size());
			Point nextPoint = pointsToVisitList.get(index);
			path.add(nextPoint);
			pointsToVisitList.remove(index);
		}
		return path;
	}
	
	/**
	 * Problem 2 Part D
	 * @param pointsToVisit: the set of points in the problem
	 * @return a list containing points organized by finding the longest path to the next point
	 */
	public static List<Point> longestPathFinder(Set<Point> pointsToVisit){
		List<Point> path = new ArrayList<Point>();
		Random rn = new Random();
		Point startPoint = (Point) pointsToVisit.toArray()[rn.nextInt(pointsToVisit.size())];
		path.add(startPoint);
		pointsToVisit.remove(startPoint);
		Point prevPoint = startPoint;
		while(!pointsToVisit.isEmpty()){
			Point maxPoint = null;
			for(Point point : pointsToVisit){
				Double dist = point.distanceTo(prevPoint);
				if(maxPoint == null || dist > maxPoint.distanceTo(prevPoint)){
					maxPoint = point;
				}
			}
			path.add(maxPoint);
			pointsToVisit.remove(maxPoint);
			prevPoint = maxPoint;
		}
		return path;
	}
	
	/**
	 * Problem 2 Point generator
	 * @param n, number of points that you want generated
	 * @return a set containing the randomly selcected points
	 */
	public static Set<Point> pointGenerator(int num){
		Set<Point> pointsToVisit = new HashSet<Point>();
		Random rn = new Random();
		for(int i = 0; i < num; i++){
			Point nextAdd = new Point(rn.nextInt(100), rn.nextInt(100));
			boolean added = pointsToVisit.add(nextAdd);
			if(!added){
				i--; 
			}
		}
		return pointsToVisit;
	}
	
	/**
	 * @param path, the path you want to check the distance of
	 * @return double, the distance between points in that path
	 */
	public static double checkPathDistance(List<Point> path){
		double distance = 0;
		Point prevPoint = path.get(0);
		path.remove(0);
		for(Point point : path){
			distance += prevPoint.distanceTo(point);
		}
		return distance;
	}
}


