/* Processing: At lave en knap og bruge et array. 
 * 
 * Vi vil nu lave en knap på skærmen, som man kan trykke på og dermed få en
 * hare til at løbe over skærmen. Hvis musen klikkes på et andet sted end på
 * knappen, tegnes stadig et træ.
 */

// Variabler
color stamme = color(170, 80, 30);
color blade = color(30, 170, 60);
color graes = color(100, 255, 55);
color himmel = color(170, 170, 255);
color sky = color(240, 240, 240);

// Variabler til at styre knappen
float kx, ky, kw, kh;                      // Knappens position, bredde og højde
boolean knapTrykket = false;               // Flag: Er knappen trykket ned eller ej
String knapTekst = "Start";                // Teksten, der skal skrives på knappen
color knapFarve = color(255, 140, 0);      // Knappens farve (orange)

// Variabler til at styre haren. Der er fire forskellige billeder, som viser harens løb
PImage[] hare;                             // Array der skal rumme billederne af haren.
                                           // Et array er en liste over en bestemt slags data. Man
                                           // erklærer det ved hjælp af de kantede parenteser [].
                                           // Her er det altså et array med elementer af typen PImage.
                                           // Senere, nede i setup()-metoden bliver det initialiseret.
float hx, hy = -80;                        // Harebilledets koordinater. Starter med at være -80.
int hn, hNummer = 0;                       // Hvilket nummer harebillede skal tegnes?

float sky_1x, sky_2x, sky_1fart, sky_2fart;// Variablerne til at styre skyerne med.

boolean skovIkkeTegnet = true;             // Dette flag fortæller om draw() skal tegne en skov.

// setup()-metoden dimensionerer nu også knappen
void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;                            // Skyernes fart og startposition                  
  sky_2x = 220;          
  sky_1fart = 1;                      
  sky_2fart = 1.5;
  kx = 510;                                // Knappens koordinater
  ky = 740;
  kw = 90;
  kh = 40;
  hare = new PImage[4];                    // For at bruge et array skal det initialiseres og 
                                           // gives en størrelse. Her har vi fire harebilleder.
  for(int h=0; h<4; h++) {
    hare[h] = loadImage("Hare"+h+".png");  // Billederne læses ind et ad gangen med en for-løkke
                                           // Bemærk hvorledes vi indsætter nummeret i filnavnet.
                                           // Det første element i et array har nummer 0 (nul).
  }
} // slut på setup()

// draw()-metoden tegner nu både skov og himmel som før, men også enten en knap eller haren.
void draw() {
  
  if(skovIkkeTegnet) tegnSkov(50);
  if(knapTrykket) tegnHare();              // tegnHare() kaldes en gang for hvert gennemløb af
                                           // draw()-metoden, så længe knapTrykket er sand.
                                           // tegnHare() skifter billede og flytter det hver gang.
  else tegnKnap();                         // Mens haren løber skal knappen ikke tegnes.
  tegnHimmel();
} // slut på draw()

// Metoden der tegner en knap. Den tegner den kun men undersøger ikke om man
// har trykket på knappen eller bestemmer hvad der så skal ske
void tegnKnap() {
  fill(knapFarve);
  rect(kx, ky, kw, kh);
  fill(0);                                 // Teksten på knappen skal skrives med sort
  textSize(24);                            // og med fontstørrelse 24 (kunne sættes i setup()
  textAlign(CENTER);                       // Teksten justeres med midten ved de givne koordinater
  text(knapTekst, kx+kw*0.5, ky+kh*0.5+8); // Koordinaterne angiver så midten af tekstens grundlinje.
                                           // I forhold til knappens venstre hjørne må vi justere.
} // slut på tegnKnap()

// Metoden der tegner den løbende hare.
void tegnHare() {
  fill(graes);                             // Først skal vi tegne græsset over mellem hvert billede,
  stroke(graes);                           // lige som vi gør med himlen
  rect(0,685,620,115);
  hy = 690;                                // Harens y-kooordinat er fast, nede i bunden af skærmen
  hx += 18;                                // Haren flytter sig mod højre. Værdien 18 må man sjusse
                                           // sig frem til i dette tilfælde
  hn += 1;                                 // hn er en tællevariabel, som tæller en op for hver gang
                                           // draw()-metoden gennemløbes. 
  hNummer = (hn) % 4;                      // Operatoren % giver os divisionsresten, dvs. det, der 
                                           // bliver til overs når vi dividerer med tallet bagefter.
                                           // Her er tallet 4, og hNummer kan derfor få værdierne 0, 
                                           // 1, 2 eller 3, for vi har jo fire billeder.
  image(hare[hNummer], hx, hy);            // Dermed vælges billede 0, 1, 2, 3, 0, 1, 2, 3, 0, 1...
                                           // og for hver gang skubbes billedet mod højre.
  if (hx > 620) {
    knapTrykket = false;                   // Så er haren løbet ud af billedet og knappen skal tilbage
    hx = -80;                              // Næste gang haren tegnes skal den starte til venstre
  }
} // slut på tegnHare()

void tegnSkov(int antalTraer) {
  for(int t = 0; t < antalTraer; t++) {
    float rr = random(30, 115);            // Mængden af Rød varierer mellem 30 og 115.
    float gg = random(130, 255);           // Mængden af Grøn varierer mellem 130 og 255.
    float bb = random(30, 115);            // Mængden af Blå varierer mellem 30 og 115.
    color krone = color(rr, gg, bb);       // Ud fra de tre talværdier laver vi nu en ny farve,
                                           // som vi sender til tegnTrae(...).
    tegnTrae(random(50, 570), 490+t*4, krone); // Og hvert nyt træ tegnes lidt længere nede end før
  }
  skovIkkeTegnet = false;                  // Skoven er nu tegnet, flaget skal "ned"
} // slut på tegnSkov()

void tegnHimmel() {
  fill(himmel);
  stroke(himmel);
  rect(0, 0, 620, 170);
  stroke(0);
  fill(sky);
  ellipse(sky_1x, 70, 200, 100);
  ellipse(sky_2x, 120, 130, 68);
  sky_1x += 1;
  if (sky_1x > 800) sky_1x = -100;
  sky_2x += 2;
  if (sky_2x > 800) sky_2x = -100;  
} // slut på tegnHimmel()

void tegnTrae(float xx, float yy, color ff) {
  stroke(0);
  fill(stamme);                        // Stammen får stadig den samme brune farve
  rect(xx-10, yy-120, 20, 120);       
  fill(ff);                            // Kronens farve får vi nu derfra hvor funktionen kaldes.
  ellipse(xx, yy-210, 150, 180);       
  // Husk også at sætte æblet på.
} // slut på tegnTrae()

// mouseClicked() skal nu som det første undersøge, om museklikket er sket på knappen. Det
// gør vi ved at undersøge om musens koordinater er inden for grænserne af knappens rektangel.
// Hvis de er, så skal haren løbe, ellers skal der ske noget andet (tegnes et træ, som før).
void mouseClicked() {
    if(mouseX > kx && mouseX < kx+kw && mouseY > ky && mouseY < ky+kh) {
      if (!knapTrykket) knapTrykket = true; // Knappen kan kun ses hvis den ikke er blevet 
                                        // trykket ned, ellers er den skjult og skal ikke 
                                        // kunne aktiveres igen før haren er løbet væk.
    }
    else {                              // Hvis ikke man rammer knappen med musen, tegnes et træ.
      float rr = random(255);           // Mængden af Rød varierer mellem 0 og 255.
      float gg = random(100, 255);      // Mængden af Grøn varierer mellem 100 og 255.
      float bb = random(255);           // Mængden af blå varierer mellem 0 og 255.
      color krone = color(rr, gg, bb);  // Ud fra de tre talværdier laver vi nu en ny farve,
      tegnTrae(mouseX, mouseY, krone);  // som vi sender til tegnTrae(...) sammen med musens
                                        // koordinater.
    }
} // slut på mouseClicked()

// Opgave 1:  Lav en knap mere, som skifter musens funktion fra at tegne flere træer
//            til at tegne billeder af sommerfugle. Husk at billederne skal tilføjes 
//            sketchen med "Sketch >> Add file.."

// Opgave 2:  Tegn knappen også mens haren løber, og lad den stoppe animationen, når
//            den er i gang. Også af skyerne.

// Opgave 3:  Overvej, hvad der vil ske, hvis du gør harens y-koordinat random. 
//            Giv svaret til din makker, før I prøver at gøre det.

// Opgave 4:  Lav en knap, som gør vejret dårligt: Grå himmel, mørke skyer, regnvejr.

// Opgave 5:  Få solen til at bevæge sig hen over himlen. Husk, den bevæger sig i en 
//            bue, og den er rød når den står op og går ned men gul imellem. Og den kan
//            naturligvis ikke ses i dårligt vejr.
