/* Processing: At lave et lille Whack-a-Mole spil. 
 *
 * Spillet skal have en muldvarp, der dukker op tilfældige steder og forsvinder igen
 * kort efter. Man skal nå at ramme den med musen (som er blevet til en hammer). Hvis man 
 * rammer vises et splat, hvis den når at dykke værk igen vises et muldvarpeskud. Der er 
 * også pointfelter, og det bliver sværere og sværere at nå at ramme, jo flere man får.
 * 
 */

// Variabler
color jord = color(170, 80, 30);
color graes = color(100, 215, 55);

// Variabler til at styre pointfeltet
int pointAntal, missAntal = 0;
float kx, ky, kw, kh;                  // Pointfelternes position, bredde og højde
String knapTekst = "Point: ";          // Teksten, der skal skrives i pointfeltet
String missTekst = "Misses: ";         // Teksten, der skal skrives i miss-feltet
color knapFarve = color(255, 140, 0);  // Pointfeltets farve (orange)

// Variabler til billedet af muldvarpen
PImage mole, pile, blood;              // Billeder til skærmen af muldvarp, jordbunke og blod
PImage hammer, hammerH;                // Billeder til cursoren
float mx, my, mw, mh = 0;              // Muldvarpens position, bredde og højde
float rx, ry = 0;                      // Dens tidligere position, hvor der enten er jord eller blod
float mTimer, mLimit, rTimer, cTimer = 0;  // Timere, så muldvarp, blod eller jord kun ses kort tid
                                           // Timerne kører ikke på absolut tid men på antal gennemløb
                                           // af draw()-metoden
boolean moleSynlig = false;            // Flag: Kan muldvarpen ses eller ej?
boolean knapTrykket = false;           // Flag: Er muldvarpen blevet ramt eller ej?
boolean blodSynlig = false;            // Flag: Er der blod på banen?
boolean jordSynlig = false;            // Flag: Er der jord på banen?

// setup()-metoden dimensionerer nu også pointfelterne
void setup() {
  size(620, 800);
  background(graes);
  textSize(24);                        // Til pointfelterne: Fontstørrelse 24
  textAlign(CENTER);                   // Teksterne justeres med midten ved de givne koordinater
  mole = loadImage("muldvarp.png");    // Henter billedet af muldvarpen. Lige nu 85 x 85 pixler
  pile = loadImage("jordbunke.png");   // Billedet af muldvarpeskuddet
  blood = loadImage("blodplet.png");   // Billedet af blodklatten
  hammer = loadImage("hammer.png");    // Hammer (lavet af Alexander Skowalsky fra The Noun Project)
  hammerH = loadImage("hammerH.png");
  cursor(hammer);                      // Hammer bruges til cursoren. Billedet max 32 x 32 pixler.
                                       
  mw = mole.width;                     // Her findes bredden af billedet "mole"
  mh = mole.height;                    // Tilsvarende også højden af billedet
  kx = 450;                            // De følgende tal handler om pointfelterne
  ky = 40;
  kw = 150;
  kh = 40;
}

// draw()-metoden tester først, om der er en synlig muldvarp. Hvis der er en muldvarp, 
// så kaldes en metode, der overvejer om det er tid at fjerne den igen. Hvis ikke, 
// så kaldes en metode, der overvejer om det er tid at tegne en. Derpå undersøges, om
// resterne efter den foregående muldvarp skal forblive eller fjernes (blod eller jord).
//
// Når dette er gjort, tegnes de forskellige ting, herunder også pointfelter.

void draw() {
  // Først tjekker vi, om der skal ske statusændringer mht. muldvarpen
  if(moleSynlig) {
    tjekMole();                        // Hvis muldvarpen er på banen skal vi se om den forsvinder
  }
  else {
    createMole();                      // Hvis ikke den er på banen, ser vi om den skal dukke op
  }
  // Derefter status med hensyn til blod og jordbunke
  if(rTimer > 0) {                     // Hvis timeren stadig er positiv, skal den tælles ned
    rTimer -= 0.02;
  } 
  else {                               // Hvis timeren er udløbet skal de forsvinde fra spillepladen
    blodSynlig = false;
    jordSynlig = false;
  }

  // Herefter tegner vi, hvad der skal tegnes
  background(graes);                   // Altid først tegne alt det gamle over
  if(moleSynlig) {
    image(mole, mx, my);               // Billedet af muldvarpen, mx og my er øverste venstre hjørne
  }
  if(jordSynlig) {                     // Muldvarpeskuddet tegnes hvor muldvarpen senest var
    image(pile, rx, ry);
  }
  if(blodSynlig) {                     // Blodsplatten tegnes hvor muldvarpen senest blev ramt
    image(blood, rx, ry);              // Blod og jordbunke er ikke synlige samtidig.
  }
  tegnPointfelter();                   // Pointfelterne tegnes op til sidst
}

// Denne funktion tjekker dels om muldvarpen er blevet ramt og i givet fald gøres
// blodsplatten synlig i stedet for muldvarpen. Hvis ikke muldvarpen er ramt, skal
// det undersøges, om den dykker ned igen og kun efterlader muldvarpeskuddet. Der 
// kan kun være en "rest" efter muldvarpen på banen ad gangen (kun et sæt rx- og ry-
// koordinater). Hvis intet ændres, tælles timeren mTimer lidt op.
void tjekMole() {
  if(knapTrykket) {                    // Så er muldvarpen ramt. Den skal erstattes med blod
    moleSynlig = false;
    blodSynlig = true;
    jordSynlig = false;                // Hvis der i forvejen var en jordbunke skal den væk
    rx = mx;                           // Splatten skal være hvor muldvarpen var indtil nu
    ry = my;
    rTimer = 1;                        // Blodklatten skal vises i kort tid, så forsvinde
    mTimer = 0;
    knapTrykket = false;
  }
  else if(mTimer > mLimit) {           // Så forsvinder muldvarpen og skal erstattes med jord
    moleSynlig = false;
    blodSynlig = false;                // Hvis der i forvejen var en blodklat skal den væk
    jordSynlig = true;                 // og nu skal der jo vises et muldvarpeskud
    rx = mx;                           // Jordbunken skal være hvor muldvarpen var indtil nu
    ry = my;
    rTimer = 1;                        // Muldvarpeskuddet skal vises i kort tid, så forsvinde
    mTimer = 0;
    cTimer = random(10);
    missAntal++;
  } 
  mTimer += 0.02;
}

// Hvis ikke der er en muldvarp på banen, skal det undersøges om en ny skal dukke op.
// Vi sammenligner mTimer med den cTimer, der blev fastlagt da muldvarpen sidst 
// forsvandt eller blev slået ned. Når mTimer er størst sættes en muldvarp på, ellers
// tælles mTimer lidt op.
void createMole() {
  if(mTimer > cTimer) {                // Er muldvarpens timer nået op til cTimer (createTimer), som
    moleSynlig = true;                 // vi satte, da muldvarpen sidst forsvandt? Så laver vi en ny
    mx = random(20, 540);
    my = random(100, 700);
    mLimit = 3 - (pointAntal*0.04) + random(1); // Det skal gå stadig hurtigere men også tilfældigt
    mTimer = 0;                        // Til sidst skal vi starte muldvarpens timer forfra
  }
  else {
    mTimer += 0.07;
  }
}

// Denne funktion optegner pointfelter i vinduets øverste højre hjørne.
void tegnPointfelter() {
  fill(knapFarve);                     // Felterne er orange
  rect(kx, ky, kw, kh);                // Vi laver to pointfelter
  rect(kx, ky+60, kw, kh);
  fill(0);                             // Teksten i felterne skal være sort.
  String pt = knapTekst + pointAntal;  // Det ene felt viser antallet af point (hits).
  text(pt, kx+kw*0.5, ky+kh*0.5+8);    // Koordinaterne angiver midten af tekstens grundlinje.
                                       // I forhold til feltets koordinater (dets venstre hjørne)
                                       // må vi justere.
  String mt = missTekst + missAntal;   // Det andet felt viser antallet af fejlslag (misses).
  text(mt, kx+kw*0.5, ky+kh*0.5+68);
}

// mouseClicked() skal nu undersøge, om museklikket er sket på muldvarpen.
// Hvis det er, så får man et point, og så skal muldvarpen fjernes (men 
// det ordner tjekMole()), ellers skal antallet af fejlslag tælles op.
void mouseClicked() {
  if(moleSynlig) {
    if(mouseX > mx && mouseX < mx+mw && mouseY > my && mouseY < my+mh) {
      knapTrykket = true;
      pointAntal++;
      cTimer = random(10); // Hvornår skal den næste muldvarp komme frem?
    }
    else {
      // Missed. Skal måske straffes med lyd eller tekst
      knapTrykket = false;
      missAntal++;
    }
  }
  else {
    // Intet at ramme. Straffes?
    missAntal++;
  }
}

// Disse to metoder er tilføjet for at cursoren (hammeren) kan animeres
void mousePressed() {
  cursor(hammerH);    // Hammeren slår ned
}

void mouseReleased() {
  cursor(hammer);     // Hammeren løftes igen
}

// Opgave 1: Prøv at tilføje en hare, der sprinter over skærmen en gang imellem, 
//           som man også skal ramme. 
//
//           Prøv eventuelt at se om du kan få den til at løbe begge veje over skærmen, 
//           og om du kan finde en måde at spejlvende billederne, så den ikke løber 
//           baglæns den ene vej.

// Opgave 2: Prøv at tilføje en slutbetingelse: Hvis du laver 3 miss i træk, så er spillet 
//           ovre. Så skal du vise en slutskærm med din score, og der skal være en knap,
//           der kan starte spillet forfra.

// Opgave 3: Prøv at finde ud af, hvordan du kan bruge systemets ur til at styre animationer
//           og hændelser med, i stedet for blot at bruge antallet af gange draw()-metoden 
//           har kørt (Hvilket jo kan variere meget fra computer til computer). Hint: Start 
//           med at kigge på funktionerne framerate() og millis() i "Help >> Reference".

// Opgave 4: Prøv at tilføje nogle ekstra billeder, som kan vises i stedet for muldvarp og 
//           hare, og som man IKKE må ramme: Hvis du smadrer bedstemors blomst, eller dræber 
//           drengen på cykel, så dør du...