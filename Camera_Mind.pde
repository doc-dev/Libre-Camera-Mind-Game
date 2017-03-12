/*
This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;
import android.content.Context;
import android.app.Activity;
import android.view.KeyEvent;

Game g = new Game();
PImage img;
boolean start_game=false;
boolean settings=false;
Point [] p = new Point[6];
short a, b, c=0;
short state=0;

@Override
    public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Toast.makeText(getContext(), "Have Fun And Prove your Memory Skills :) !", Toast.LENGTH_SHORT).show();
}


void onBackPressed() {
    mouseX = mouseY = 0; // <-- TOP !!
    if (start_game) {
        a--;
        img = loadImage("rsz_intro.png");
        image(img, 0, 0, width, height);
        start_game=false;
        settings=false;
    }
    if (settings) {
        b--;
        settings=true;
        start_game=false;
    }

    if (!start_game) {
        System.exit(0);
    }

    // super.onBackPressed();
}

void setup() {
    //inizializzazione punti del menu
    mouseX=mouseY=0;
    noStroke();
    //play
    p[0]= new Point((int)((width*180)/1242), (int)((1377*height)/2208));
    p[1]= new Point((int)((width*927)/1242), (int)((1545*height)/2208));
    //settings
    p[2]= new Point((int)((width*177)/1242), (int)((1665*height)/2208));
    p[3]= new Point((int)((width*1011)/1242), (int)((1833*height)/2208));
    //quit
    p[4]= new Point((int)((width*153)/1242), (int)((1938*height)/2208));
    p[5]= new Point((int)((width*888)/1242), (int)((2124*height)/2208));   

    fullScreen();
    background(255);
}

boolean scritta, end, lose=false;
Circle tmp;
void draw() {   
    frameRate(10);
    if (lose) {
        background(0);
        fill(255);
        textSize(width/9);
        text("You Lose!", width/4, height/2);
    }
    if (!end) {   
        if (scritta) {
            if (frameCount >= 16) {
                scritta=false;
                background(255);
                thread("update");
                mouseX=mouseY=0;
                if (!g.randomize()) g.drawCircle();
                else end=true;
                return;
            }
            background(0);
            fill(255);
            textSize(width/12);
            text("Livello superato!", width/4.8, height/2);
        } else if (start_game) {
            if (a==0) {
                a++;
                background(255);
                if (!g.randomize()) g.drawCircle();
                else end=true;
            } else {

                tmp = g.getLast();

                if ((mouseX>tmp.getX()-tmp.getR() && mouseX<tmp.getX()+tmp.getR()) && (mouseY>tmp.getY()-tmp.getR() && mouseY<tmp.getY()+tmp.getR())) {
                    scritta=true;
                    frameCount = 0;
                } else {
                    thread("check");
                }
            }
        }
    } else {
        background(0);
        fill(255);
        textSize(width/10);
        text("Partita finita!", width/4, height/2);
    }
    if (settings && b==0) {
        b++;
        background(200, 0, 0);
    }

    if (!start_game && !settings) {
        img = loadImage("rsz_intro.png");
        image(img, 0, 0, width, height);

        if ((mouseX>=p[0].getX() && mouseX<=p[1].getX()) && (mouseY>=p[0].getY() && mouseY<=p[1].getY())) {
            start_game=true;
            settings=false;
            background(255);
            mouseX = mouseY = 0;
        }
        if ((mouseX>=p[2].getX() && mouseX<=p[3].getX()) && (mouseY>=p[2].getY() && mouseY<=p[3].getY())) {
            settings=true;
            start_game=false;
            background(200, 0, 0, 35);
            mouseX = mouseY = 0;
        } 

        if ((mouseX>=p[4].getX() && mouseX<=p[5].getX()) && (mouseY>=p[4].getY() && mouseY<=p[5].getY())) {
            settings=false;
            start_game=false;
            System.exit(0);
        }
    }
}

void check() {
    Circle tmp;
    for (int i=0; i<g.cerchi.size()-1 && lose==false; i++) {
        tmp = g.cerchi.get(i);
        if ((mouseX>tmp.getX()-tmp.getR() && mouseX<tmp.getX()+tmp.getR()) && (mouseY>tmp.getY()-tmp.getR() && mouseY<tmp.getY()+tmp.getR())) {
            lose=true;
        }
    }
}

void update() {
    for (int i=0; i<g.cerchi.size(); i++) {
        fill(g.cerchi.get(i).getColor());
        ellipse(g.cerchi.get(i).getX(), g.cerchi.get(i).getY(), g.cerchi.get(i).getR(), g.cerchi.get(i).getR());
    }
}