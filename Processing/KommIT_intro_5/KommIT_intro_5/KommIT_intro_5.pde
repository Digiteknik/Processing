/* Processing: random()-funktionen, lokale variabler
 * 
 * random()-funktionen er et eksempel på en funktion, der sender noget retur, når man kalder den.
 * Funktionen bruges til at lave et tilfældigt tal. Den skal også bruge nogle parametre i kaldet, 
 * som angiver grænsen eller grænserne for det interval, man ønsker at tallet skal ligge inden for.
 * Hvis der er en parameter, er det den øvre grænse - man får altså et tilfældigt tal mellem 0 og
 * det tal, man angiver. Hvis der er to tal, er det nedre og øvre grænse.
 *
 * I denne sketch bruges random() til at danne tilfældige farver til kronen (se mouseClicked()-
 * funktionen nederst). Du skal prøve i opgaverne også at bruge det til at skabe variation i
 * træernes form.
 */

// Variabler. Alt er det samme som før. Du kan ændre dem som du selv synes
color stamme = color(170, 80, 30);    
color blade = color(30, 170, 60);     
color graes = color(120, 220, 15);   
color himmel = color(130, 190, 255);  
color sky = color(240);               

float sky_1x, sky_2x, sky_1fart, sky_2fart;  // Variablerne til at styre skyerne med.

// setup() er også  magen til foregående sketch.
void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;                       
  sky_2x = 220;          
  sky_1fart = 1;                      
  sky_2fart = 1.5;
}

// draw()-metoden, derimod, er meget mere overskuelig nu, der er kun to linjer. 
// Men bemærk: tegnTrae() er anderledes end før.
void draw() {
  tegnTrae(300, 600, blade);          // tegnTrae(...)-funktionen er lavet om, så den både
                                      // skal have et koordinatsæt og en farve til kronen.
                                      // Her er farven den samme som det hele tiden har været.
  tegnHimmel();                       // tegnHimmel-funktionen er den, du selv forhåbentlig
                                      // fik lavet i den foregående sketch.
}

/*
 * Funktionen tegnTrae() er lavet om, så den nu får tre parametre: De to er stadig koordinater til 
 * træets position (til roden - det gjorde du selv i foregående sketch). Den tredje er en farve, 
 * som bruges til kronen. 
 */
void tegnTrae(float xx, float yy, color ff) {
  stroke(0);
  fill(stamme);                        // Stammen får stadig den samme brune farve
  rect(xx-10, yy-120, 20, 120);       
  fill(ff);                            // Kronens farve får vi nu derfra hvor funktionen kaldes.
  ellipse(xx, yy-210, 150, 180);       
  // Husk også at sætte æblet på.
}

/* 
 * mouseClicked() er også ændret. Når vi sætter et nyt træ, vil vi gerne have variation 
 * i farven, så vi bruger vi funktionen random(). Den genererer et tilfældigt tal inden 
 * for et interval, og den tager enten en eller to parametre (enten en øvre grænse for 
 * intervallet eller både en nedre og en øvre).
 */
void mouseClicked() {
  // rr, gg, bb og krone er fire lokale variabler. 
  // De gemmes et kort øjeblik men bliver glemt igen, når kodeblokken er løbet igennem.
  float rr = random(255);             // Mængden af Rød varierer mellem 0 og 255.
  float gg = random(100, 255);        // Mængden af Grøn varierer mellem 100 og 255.
  float bb = random(255);             // Mængden af Blå varierer mellem 0 og 255.
  color krone = color(rr, gg, bb);    // Ud fra de tre talværdier laver vi nu en ny farve,
                                      // som vi sender til tegnTrae(...) sammen med musens
                                      // koordinater.
  tegnTrae(mouseX, mouseY, krone);
}

/* 
 * tegnHimmel()-funktionen står nu for sig selv. Men kodelinjerne er de samme, og metoden gør 
 * fuldstændig det samme som de gjorde, da de stod oppe i draw()-metoden. I den foregående sketch
 * flyttede du også selv disse kodelinjer til deres egen funktion.
 *
 * draw()-metoden er meget mere overskuelig, når den ikke rummer al koden.
 * 
 * tegnHimmel() har ingen parametre i funktionskaldet: Parentesen er tom. Og den returnerer 
 * heller ikke noget til draw()-metoden: Returtypen (ordet før funktionens navn) er void.
 */
void tegnHimmel() {
  fill(himmel);                       
  stroke(himmel);        
  rect(0, 0, 620, 200);               // Himlen tegnes stadig hver gang draw() gennemløbes. 
  
  fill(sky);                          // Og skyerne også, som før.
  stroke(100);                      
  ellipse(sky_1x, 70, 280, 100);     
  ellipse(sky_2x, 130, 150, 80);    
  sky_1x += sky_1fart;                // Skyerne rykker sig stadig lidt for hvert gennemløb af draw().
  sky_2x += sky_2fart;               

  if (sky_1x > 800) sky_1x = -200;    // Og de starter stadig forfra, når de kommer uden for vinduet. 
  if (sky_2x > 720) sky_2x = -100; 
  
} // Her slutter tegnHimmel()-funktionens kodeblok

// Opgave 1:  Gule, lilla eller turkisblå træer er grimme. Ret farve-intervallerne i mouseClicked() 
//            til, så der er variation i de grønne farver, uden at det ser helt skørt ud.

// Opgave 2:  Prøv at lave en lokal variabel i tegnTrae()-funktionen, som kan gemme kronens bredde. 
//            Giv kronen en tilfældig bredde, så der også er lidt variation i træernes form.

// Opgave 3:  Sæt et æble på træet, og prøv at lade æblets position variere med random():

// Opgave 4:  Hvis du er ambitiøs, kan du også lade kronens og stammens højder variere. Men så
//            sker der noget med placeringen af træets forskellige dele i forhold til hinanden,
//            som kræver at du bruger de pågældende variabler som dele i regnestykker inde i de
//            funktioner, der tegner stamme og krone (rect()- og ellipse()-funktionerne). Spring
//            denne opgave over, hvis du synes det bliver for rodet.

// Opgave 5:  Prøv til sidst at lave draw()-metoden om, så træet får tilfældige koordinater. Sæt
//            denne linje ind i stedet for den der står der nu:
//               tegnTrae(random(50, 570), random(500, 780), blade);
//            Snak med din makker om, hvordan denne linje virker og se hvad der sker, når det kører. 
//            Og prøv om du nu kan tegne træer med musen oven på det første træ.