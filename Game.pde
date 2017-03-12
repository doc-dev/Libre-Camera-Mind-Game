import java.util.ArrayList;

public class Game {
    private ArrayList<Circle> cerchi = new ArrayList<Circle>();
    private int xc, yc, r, index;
    int[] sizes = new int[3];
    private int xstart, ystart;
    private Circle c;
    private boolean saturo=false;

    public Game() {
    }

    public void setSaturo(boolean b) {
        this.saturo=b;
    }

    public boolean randomize() {
        int timer=0;
        do {
            if (timer>5000) {
                saturo=true; 
                break;
            }
            index = (100+((int)(random(width/4))));            
            this.r=index; 
            xc =(int)(random((width)));
            yc =(int)(random((height)));
            timer++;
        } while (((xc-r<=0)||(xc+r>=width)) || ((yc-r<=0)||(yc+r>=height)) ||  !notCollide());
        c = new Circle(xc, yc, r);
        return saturo;
    }

    public boolean notCollide() {
        boolean re = true;
        for (int i=0; i<cerchi.size() && re==true; i++) {
            Circle temp = cerchi.get(i);            
            if (((xc-r>temp.getX()+temp.getR() || xc+r<temp.getX()-temp.getR())) || ((yc-r>temp.getY()+temp.getR() ||  yc+r<temp.getY()-temp.getR()))) re=true;
            else re=false;
        }
        return re;
    }

    public void drawCircle() {
        if (!saturo) {
            color a = color(1+random(255), 1+random(255), 1+random(255));
            fill(a);
            xstart = xc-r;
            ystart = yc-r;

            stroke(a); //Just a random color to display circles ;)
            ellipse(xc, yc, r, r);

            c = new Circle(xc, yc, r);
            c.setColor(a);
            cerchi.add(c);
            if (cerchi.size()<1) {
                c.setLast(true);
            } else {
                cerchi.get(cerchi.size()-1).setLast(false);
                c.setLast(true);
            }
        }
    }
    
    public Circle getLast() {
        return cerchi.get(cerchi.size()-1);
    }
}