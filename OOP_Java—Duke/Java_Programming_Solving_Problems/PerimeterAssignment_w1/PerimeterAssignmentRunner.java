import edu.duke.*;
import java.io.File;

public class PerimeterAssignmentRunner {
    public double getPerimeter (Shape s) {
        // Start with totalPerim = 0
        double totalPerim = 0.0;
        // Start wth prevPt = the last point
        Point prevPt = s.getLastPoint();
        // For each point currPt in the shape,
        for (Point currPt : s.getPoints()) {
            // Find distance from prevPt point to currPt
            double currDist = prevPt.distance(currPt);
            // Update totalPerim by currDist
            totalPerim = totalPerim + currDist;
            // Update prevPt to be currPt
            prevPt = currPt;
        }
        // totalPerim is the answer
        return totalPerim;
    }

    public double getNumPoints (Shape s) {
        // Put code here
        double objects = 0;
        for (Point pt : s.getPoints()) {
          objects = objects + 1;
        }
        return objects;
    }

    public double getAverageLength(Shape s) {
        // Put code here
        double perimeter = getPerimeter(s);
        double numpoints = getNumPoints(s);
        double average = perimeter / numpoints;
        return average;
    }

    public double getLargestSide(Shape s) {
        // Put code here
        double largest = 0;
        double dist = 0;
        Point prevPt = s.getLastPoint();
        for (Point pt : s.getPoints()) {
            dist = pt.distance(prevPt);
            if (dist > largest) {
                largest = dist;
            }
        }
        return largest;
    }

    public double getLargestX(Shape s) {
        // Put code here
        return 0.0;
    }

    public double getLargestPerimeterMultipleFiles() {
        // Put code here
        double largest = 0;
        double perimeter = 0;
        DirectoryResource dr = new DirectoryResource();
        for (File f : dr.selectedFiles()) {
            FileResource fr = new FileResource(f);
            Shape s = new Shape(fr);
            perimeter = getPerimeter(s);
            if (perimeter > largest) {
                largest = perimeter;
            }
        }
        return largest;
    }

    public String getFileWithLargestPerimeter() {
        // Put code here
        double largest = 0;
        double perimeter = 0;
        File largestFile = null;
        DirectoryResource dr = new DirectoryResource();
        for (File f : dr.selectedFiles()) {
            FileResource fr = new FileResource(f);
            Shape s = new Shape(fr);
            perimeter = getPerimeter(s);
            if (perimeter > largest) {
                largest = perimeter;
                largestFile = f;
            }
        }
        return largestFile.getName();
    }

    public void testPerimeter () {
        FileResource fr = new FileResource();
        Shape s = new Shape(fr);
        double length = getPerimeter(s);
        System.out.println("perimeter = " + length);
    }

    public void testPerimeterMultipleFiles() {
        // Put code here
        double largest = getLargestPerimeterMultipleFiles();
        System.out.println("largest = " + largest);
    }

    public void testFileWithLargestPerimeter() {
        // Put code here
        String name = getFileWithLargestPerimeter();
        System.out.println("file = " + name);

    }

    // This method creates a triangle that you can use to test your other methods
    public void triangle(){
        Shape triangle = new Shape();
        triangle.addPoint(new Point(0,0));
        triangle.addPoint(new Point(6,0));
        triangle.addPoint(new Point(3,6));
        for (Point p : triangle.getPoints()){
            System.out.println(p);
        }
        double peri = getPerimeter(triangle);
        System.out.println("perimeter = "+peri);
    }

    // This method prints names of all files in a chosen folder that you can use to test your other methods
    public void printFileNames() {
        DirectoryResource dr = new DirectoryResource();
        for (File f : dr.selectedFiles()) {
            System.out.println(f);
        }
    }

    public static void main (String[] args) {
        PerimeterAssignmentRunner pr = new PerimeterAssignmentRunner();
        pr.testPerimeter();
    }

    public static void aveLen (String[] args) {
        PerimeterAssignmentRunner pr = new PerimeterAssignmentRunner();
        pr.testAveLen();
    }

    public void testAveLen(){
        FileResource fr = new FileResource();
        Shape s = new Shape(fr);
        double avle = getAverageLength(s);
        System.out.println("Average Length: " + avle);
    }

    public void testLargestSide() {
        FileResource fr = new FileResource();
        Shape s = new Shape(fr);
        double largest = getLargestSide(s);
        System.out.println("largest side = " + largest);
    }
}
