public class Circle {
    //coordinate polari
    private int radius;
    private int x;
    private int y;
    private boolean last=false;
    private color c;

    public Circle(int x, int y, int radius) {
        this.x=x;
        this.y=y;
        this.radius=radius;
    }

    public void setLast(boolean b) {
        last=b;
    }

    public int getX() {
        return this.x;
    }

    public int getY() {
        return this.y;
    }

    public int getR() {
        return this.radius;
    }

    void setColor(color a) {
        this.c = a;
    }

    color getColor() {
        return this.c;
    }

    boolean Compare(Circle c) {
        return (c.last==true && this.last==true) ? true : false;
    }
}