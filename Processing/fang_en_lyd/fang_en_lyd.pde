  

import processing.sound.*;
AudioIn in;

void setup() {
  size(640, 360);
  background(255);
    
  // Create the Input stream
  in = new AudioIn(this, 0);
  in.play();
}      

void draw() {
}

/*

Tjek referencen: https://processing.org/reference/libraries/sound/index.html

Se om du kan tegne en cirkel på skærmen som viser volumen på optagelse

Se så om du kan få cirklen til at skifte farve når der kommer en høj lyd - fx et klap

*/