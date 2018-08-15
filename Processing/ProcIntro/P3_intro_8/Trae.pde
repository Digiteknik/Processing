// Skabelon for objekter af typen Træ
class Trae {
  // Objektvariabler - så at sige træets "egenskaber"
  float xpos, ypos, hojde, bredde;    // Træets position og dimensioner.
                                      // Positionen angiver træets bund ("rod").
  color farve, stamme;                // Træets farver
  boolean harStamme;                  // Er det et træ eller en busk?
  
  // Konstruktør, som bruges til at lave ("instantiere") et nyt objekt af typen Trae med.
  // Denne konstruktør tager position og dimensioner som parametre og laver selv træets
  // øvrige egenskaber. 
  Trae(float xx, float yy, float bb, float hh) {
    xpos = xx;
    ypos = yy;
    bredde = bb;
    hojde = hh;
    harStamme = true;
    farve = color(random(30, 120), random(150,230), random(80));
    stamme = color(170, 80, 30);    
  }
  
  // Konstruktør,
  // som før men tager desuden en boolean, der angiver om træet har stamme eller er en busk
  Trae(float xx, float yy, float bb, float hh, boolean st) {
    xpos = xx;
    ypos = yy;
    bredde = bb;
    hojde = hh;
    farve = color(random(30, 120), random(150,230), random(80));
    stamme = color(170, 80, 30);
    harStamme = st;
  }
  
  // Konstruktør
  // som før, men tager desuden løvets farve som parameter 
  Trae(float xx, float yy, float bb, float hh, boolean st, color krone) {
    xpos = xx;
    ypos = yy;
    hojde = hh;
    bredde = bb;
    farve = krone;
    stamme = color(170, 80, 30);
    harStamme = st;
  }

  // Funktion der tegner træet - med eller uden stamme
  boolean tegnTrae(float speed) {
    xpos -= speed;                         // Flyt træets position før tegning
    if (xpos < -bredde/2) {                // Så er træet uden for skærmens venstre kant
      return false;                        // og vi behøver ikke tegne det
    }
    stroke(0);  // Sort kontur
    if (harStamme) {
      fill(stamme);                        // Stammen
      rect(xpos-10, ypos-hojde/2, 20, hojde/2);   
      fill(farve);                         // Kronen
      ellipse(xpos, ypos-hojde*0.75, bredde, hojde/2); 
    }
    else {
      fill(farve);
      ellipse(xpos, ypos-hojde/2, bredde, hojde);  // Bare en busk
    }
    return true;
  }
  
  // Funktion til at afgøre om træet rammes af haren? Hvordan kan vi finde ud af det?
  // Funktionen tager en position som parametre. Hvilken position er det i forhold til
  // haren. Er det tilstrækkelig information? Og hvornår og hvor tit skal der spørges?
  boolean traeRamt(float objX, float objY) {
    return false;                          // Lige nu rammes træet aldrig
  }
  
  // Bruges ikke lige nu. Find på noget at bruge denne funktion til
  void grow() {
    hojde *= 1.1;
    bredde *= 1.05;
  }
}
