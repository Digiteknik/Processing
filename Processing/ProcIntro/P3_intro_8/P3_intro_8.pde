/* Processing: At lave et spil med en brugerflade, samt at lave egne klasser, dvs. egne "skabeloner"
 * til at lave objekter fra. Klassenavne starter med stort, så man kan se at fx String og PImage,
 * som bruges her i sketchen, også er klasser af objekter. 
 * 
 * Vi vil nu lave et spil, hvor haren fra før skal løbe over skærmen og springe over forhindringer
 * (træer), som kommer ind fra højre. 
 
 * Trae er en ny klasse, som vi danner vores egne objekter fra, i dette tilfælde træer (eller buske,
 * som jo er træer uden stamme), og træerne lægges ind i et array og tegnes efterhånden, 
 * men fjernes igen når de er forbi kanten af skærmen. Klassen Trae ligger på et nyt faneblad 
 * øverst. I skal føje yderligere en klasse, Gulerod, til spillet senere.
 *
 * Når haren løber ud af skærmen vil der komme en knap øverst, som man kan trykke på og 
 * dermed få haren til at påny. Det er en del af brugerfladen. En anden del er felter til at 
 * vise forskellige former for scores, dem får I lov at lave.
 *
 * Selve spillets mekanik får I også selv lov at lave om på til sidst. 
 *
 * Opgaverne står fra linje 180. De kodeblokke, jeg ikke har ændret væsentligt på, står efter dem
 */

// Variabler
int baneBred = 1000;                       // Vinduets dimensioner
int baneHoj = 800;
color graes = color(100, 255, 55);
color himmel = color(170, 170, 255);
color sky = color(240, 240, 240);
float sky_1x, sky_2x, sky_1fart, sky_2fart;// Variablerne til at styre skyerne med.

float xSpeed, ySpeed;                      // Variabler til at styre banens/harens fart
float grav = 3;                            // "Gravitationskonstanten" - hvor hurtigt kommer haren ned

Trae[] traer;                              // array med objekter af typen Trae
int antalTraer = 0;                        // antallet af træer på banen

// Variabler til at styre knappen
float kx, ky, kw, kh;                      // Knappens position, bredde og højde
boolean knapTrykket = true;                // Flag: Er knappen trykket ned og haren i løb
String knapTekst = "Start igen";           // Teksten, der skal skrives på knappen
color knapFarve = color(255, 140, 0);      // Knappens farve (orange)

// Variabler til at styre haren. Der er fire forskellige billeder, som viser harens løb
PImage[] hare;                             // Array der skal rumme billederne af haren.
float hx, hy = -30;                        // Harebilledets koordinater. Starter med at være -30.
int hn, hNummer = 0;                       // Hvilket nummer harebillede skal tegnes?
boolean jumping = false;                   // Dette flag fortæller om haren er i spring
int godeHop, hareLiv = 0;                  // Point-variable til spillet

// settings()-metoden kører før setup()
void settings() {
  size(baneBred, baneHoj);
} // slut på settings()

// setup()-metoden giver en masse startværdier
void setup() {
  frameRate(20);
  background(graes);
  sky_1x = 440;                            // Skyernes fart og startposition                  
  sky_2x = 220;          
  sky_1fart = 2;                      
  sky_2fart = 3.5;
  xSpeed = 9;
  ySpeed = 0;
  kw = 150;
  kh = 40;
  kx = (baneBred-kw)/2;                    // Knappens koordinater
  ky = 20;
  traer = new Trae[10];
  hare = new PImage[4];                    // For at bruge et array skal det initialiseres og 
                                           // gives en størrelse. Her har vi de fire harebilleder.
  for(int h=0; h<4; h++) {
    hare[h] = loadImage("Hare"+h+".png");  // Billederne læses ind et ad gangen.
  }
} // slut på setup()

// draw()-metoden tegner nu, foruden himlen og haren, også banen med nogle buske, haren skal over.
void draw() {
  tegnBane();
  tegnHimmel();
  if(knapTrykket) {                        // tegnHare() kaldes en gang for hvert gennemløb af
    tegnHare();                            // draw()-metoden, så længe knapTrykket er sand.
  }                                        // tegnHare() skifter billede og flytter det hver gang.
  else {
    tegnKnap();                            // Mens haren løber skal knappen ikke tegnes.
  }                      
}  // slut på draw()

// Denne metode tegner banen og holder styr på træerne samt på harens point
void tegnBane() {
  fill(graes);                             // Først skal vi male græsset over mellem hvert billede,
  stroke(graes);                           // lige som vi bagefter gør med himlen
  rect(0,0,baneBred,baneHoj);
  
  // En hule, som haren måske kan søge tilflugt i, til højre på banen
  stroke(0, 100, 30);
  fill(100, 70, 0);
  ellipse(baneBred-40, baneHoj-50, 40, 60);
  
  // Nyt træ med jævne mellemrum, og forskellige steder på y-aksen
  if ((frameCount-5) % 40 == 0) {    
    float traeTop = random(40, 160);
    boolean erStor = true;
    if (traeTop < 100) erStor = false;
    traer[antalTraer] = new Trae(baneBred, 630, traeTop/2, traeTop, erStor);
    antalTraer += 1;
  }
  
  // Herefter tegner vi træerne og tjekker om haren har ramt dem eller om de er røget ud af syne
  boolean traeForbi = false;
  for(int t = 0; t < antalTraer; t++) { 
    Trae trae = traer[t];                   // Hent næste træ fra arrayet
    if(!trae.tegnTrae(xSpeed)) {            // Tegn træet og få at vide om det ryger ud af syne
       traeForbi = true;                    // og hvis det gør, så skal det væk
    }
    if (trae.traeRamt(hx,hy)) {             // Vi spørger træet om haren er hoppet over det
      hareLiv -= 1;                         // Hvis ikke, koster det et liv
    } 
    else {
      godeHop += 1;                         // Ellers får vi et point
    }
  }
  if (traeForbi) {                          // Hvis et træ er røget ud til venstre skal det fjernes
    antalTraer -= 1;
    for (int tt=0; tt<antalTraer; tt++) {   // I så fald er det arrayets første element, så ud med det
      traer[tt] = traer[tt+1];              // og så skubber vi alle de andre en plads frem
    }
  }
}  // slut på tegnBane()

// Denne metode tegner den løbende eller springende hare.
void tegnHare() {
  if (jumping) {                             // Tjek om haren er i spring
    if (hy > 550) {                          // Springet afsluttes, hvis den er tilbage på grundlinjen
      hy = 550; ySpeed = 0; jumping = false;
    }
    else                                     // Springet fortsætter ellers
    {
      hx += 12-xSpeed;
      hy -= ySpeed;
      ySpeed -= grav;                           
      image(hare[0], hx, hy);                // Fast billede af haren mens den springer
    }
  }
  else {
    hy = 550;                                // Harens y-kooordinat er fast, nede i bunden af skærmen
    hx += 12-xSpeed;                         // Haren flytter sig mod højre, træerne mod venstre.
    hn += 1;                                 // hn er en tællevariabel, som tæller en op for hver gang
                                             // draw()-metoden gennemløbes. 
    hNummer = (hn) % 4;                      // Operatoren % giver os divisionsresten, dvs. det, der 
                                             // bliver til overs når vi dividerer med tallet bagefter.
                                             // Her er tallet 4, og hNummer kan derfor få værdierne 0, 
                                             // 1, 2 eller 3, for vi har jo fire billeder.
    image(hare[hNummer], hx, hy);            // Dermed vælges billede 0, 1, 2, 3, 0, 1, 2, 3, 0, 1...
                                             // og for hver gang skubbes billedet mod højre.
    if (hx > baneBred) {
      knapTrykket = false;                   // Så er haren løbet ud af billedet og knappen skal tilbage
      hx = -80;                              // Næste gang haren tegnes skal den starte til venstre
    }
  }
} // slut på tegnHare()

// Disse to standardmetoder bruges til at få haren til at hoppe og til at ændre på banens fart
void keyPressed() {
  if (key == 'w') {
    jumping = true;
    ySpeed = 30;                             // "Kraften" i afsættet. Kan justeres om ønsket
  }
  if (key == 'a') {
    xSpeed = 15;                             // Buskene bevæger sig hurtigere, og haren baglæns
  }
  if (key == 'd') {
    xSpeed = 0;                              // Buskene står stille og haren hopper meget hurtigt
  }
}
void keyReleased() {
  if (key == 'a' || key == 'd') {            // tilbage til normaltilstanden
    xSpeed = 7;              
  }
}

// Opgave 1:  Spilstatus. Lav felter oppe øverst, der viser godeHop og hareLiv, og lav en 
//            tekst nederst, der forklarer hvad tasterne gør.

// Opgave 2:  Haren må ikke ramme buskene. Lav metoden til at tjekke om busken er ramt
//            Det er der gjort klar til i Trae-klassen i metoden traeRamt(x,y), men lige nu
//            returneres altid at træet ikke rammes. Hvordan kan det gøres?

// Opgave 3:  Lav en ny klasse, Gulerod, som sender billeder af en gulerod hen oveer banen,
//            så haren kan spise når guleroden kommer forbi og få mere liv.
//            Husk at gulerodsbilledet skal føjes til sketchen med "Sketch >> Add file.."

// Opgave 4:  Lav spillet sådan at haren skal ned i hulen ude i højre side for at "vinde"

// Opgave 5:  Lad haren løbe på midten hele tiden, og få i stedet solen til at bevæge sig hen over himlen. 
//            Gør det til et vinderkriterium at haren "har løbet hele dagen", dvs. indtil solen går ned,
//            uden at ramme et træ.

// Herunder står de af metoderne, der ikke er ændret nævneværdigt i forhold til de tidligere sketches

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
}

// mouseClicked() skal først undersøge, om museklikket er sket på knappen. Det gør vi 
// ved at undersøge om musens koordinater er inden for grænserne af knappens rektangel.
// Hvis de er, så skal haren løbe igen.
void mouseClicked() {
    if(mouseX > kx && mouseX < kx+kw && mouseY > ky && mouseY < ky+kh) {
      if (!knapTrykket) knapTrykket = true; // Knappen kan kun ses hvis den ikke er blevet 
                                        // trykket ned, ellers er den skjult og skal ikke 
                                        // kunne aktiveres igen før haren er løbet væk.
    }
}

// Metoden tegnHimmel() er den samme som før
void tegnHimmel() {
  fill(himmel);
  stroke(himmel);
  rect(0, 70, baneBred, 170);
  stroke(0);
  fill(sky);
  ellipse(sky_1x, 140, 200, 100);
  ellipse(sky_2x, 190, 130, 68);
  sky_1x += 1;
  if (sky_1x > baneBred+100) sky_1x = -100;
  sky_2x += 2;
  if (sky_2x > baneBred+100) sky_2x = -100;  
}
