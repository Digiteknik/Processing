/* Processing: Animation, betingelser. 
 * Vi tegner en himmel med drivende skyer ved at udnytte, at draw()-funktionen hele tiden gentages
 */

color stamme = color(170, 80, 30);    // Som før
color blade = color(30, 170, 60);     // Som før
color graes = color(220, 180, 15);    // Vissent som før. Husk at rette denne til din egen græs-farve
color himmel = color(190, 130, 255);  // Ny farve - himmelblå. Sådan da - gør den gerne selv bedre.
color sky = color(240);               // Ny farve - lysegrå til skyerne.

float sky_1x, sky_2x;    // To variabler af typen float (kommatal). De skal indeholde skyernes position.

/* Vi kan godt erklære flere variabler af samme type i en linje, men så kan vi 
 * ikke give dem værdier her. Det gør vi derfor nedenfor i setup().
 */

/* 
 * setup()-funktionen. Altid med. 
 */
void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;          // Sky_1 starter ude til højre
  sky_2x = 220;          // Sky_2 starter ca. midt på
}

/* 
 * draw()-funktionen. Altid med. 
 */
void draw() {
  fill(himmel);          // Først skal vi have tilføjet en himmel bag skyerne.
  stroke(himmel);        // Og himlen skal ikke have en sort kant omkring, 
                         // så derfor lader vi kanten få himlens farve.
  rect(0, 0, 620, 200);  // Himlen skal tegnes hver gang draw() gennemløbes. 
  
  // Opgave 1: Se hvad der sker, hvis du sætter // foran linjen: rect(0, 0, 620, 200);
  //           Grimt, ikke sandt? Det er derfor, vi tegner himlen op hver gang.
  
  fill(sky);                        // Dernæst skal skyerne fyldes med sky-farve
  stroke(100);                      // Skyerne skal have en mellemgrå kant
  ellipse(sky_1x, 70, 280, 100);    // Skyerne tegnes som ellipser, lige som trækronen neden for, 
  ellipse(sky_2x, 130, 150, 80);    // men i stedet for et tal står nu navnet på en variabel 
                                    // som x-værdi for ellipsens position.
  sky_1x += 1;                      // Når skyen er tegnet, lægger vi lidt til den startværdi, 
  sky_2x += 1.5;                    // x-positionerne fik fra starten, og vi lader sky_2 bevæge 
                                    // sig lidt hurtigere end sky_1. 

  /* Skrivemåden += betyder, at vi øger variablens værdi med det tal, der står efter lighedstegnet.
   * Bemærk også, at decimaltegnet er . (punktum) ikke komma som på dansk.
   */
   
  if (sky_1x > 620) sky_1x = -100;  // Skyerne flytter mod højre og vil bevæge sig ud af vinduet. Når 
  if (sky_2x > 620) sky_2x = -100;  // de kommer til højre kant, lader vi dem derfor starte forfra 
                                    // til venstre for vinduet. Variabler kan godt være negative.
  /* Bemærk if(...)-sætningen. Dette kaldes en betingelse. 
   * HVIS, og KUN HVIS udsagnet inde i parentesen er sandt, vil instruktionen bagefter blive udført.
   */
  
  // Opgave 2: Skyerne når ikke helt ud til højre før de blinker bort. Ret det.
  //           Den store af skyerne starter heller ikke helt uden for venstre kant. Ret også det.
  
  // Til sidst skal vi igen have tegnet træet.
  stroke(0);                        // Træet skal have sin sorte kant.
  fill(stamme);                     // Og stammen skal have sin brune farve, som før.
  rect(300, 530, 20, 120); 
  fill(blade);                      // Det samme gælder kronen. 
  ellipse(310, 450, 150, 180);      // Kronen er lidt pænere nu, men det er dig, der bestemmer.
  
  // Opgave 3: Sæt igen et æble på træet, som i den forrige sketch
  
  // Opgave 4: Lav nogle nye variable i starten, sky_1fart og sky_2fart, af typen float lige som 
  //           positionerne, og brug dem i stedet for tallene 1 og 1.5 i linje 44 og 45.
  
  // Opgave 5: Få en af skyerne (eller begge) til at drive den modsatte vej.
}