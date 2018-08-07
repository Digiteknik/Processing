/* Processing: Kodeblokke, Funktioners parametre, Egne funktioner
 *
 * I stedet for en blomst vil vi nu gerne have processing til at tegne et træ mere, 
 * når musen klikkes. Derved kan vi efterhånden lave en skov.
 *
 * Vi kunne bare gentage koden der tegner træet inde i mouseClicked()-funktionen. Men det
 * er upraktisk - hvis vi vælger at lave noget om (fx. sætte et æble på), så skal vi rette  
 * koden to steder. Derfor vil vi nu lave vores egen metode, tegnTrae(xx, yyy). Så sparer
 * vi lidt kode og skal kun rette et sted. OG det hele bliver lidt mere overskueligt.
 *
 * Til gengæld kræver det, at vi tænker grundigt over, hvad der er udgangspunktet, altså x- 
 * og -y-koordinaterne, når vi skal tegne træet. Jeg har vedtaget, til start, at udgangspunktet 
 * er der, hvor den firkant, der udgør stammen, bliver tegnet - altså dens øverste venstre 
 * hjørne. Senere bliver det din opgave at ændre dette, så det bliver træets rod (dvs. bunden
 * af stammen), der er det sted, x- og y-værdien refererer til. Det er mere "logisk".
 */
 
color stamme = color(170, 80, 30);    // Samme som før.
color blade = color(30, 170, 60);     
color graes = color(120, 220, 15);    // Pænere end først. Men ret gerne til din egen græs-farve.
color himmel = color(130, 190, 255);  // Igen pænere end før, men find gerne din egen himmelblå.
color sky = color(240);               

float sky_1x, sky_2x,                 // Variabler til at styre skyerne med.
      sky_1fart, sky_2fart;           // Bemærk: Processing læser dette som een linje, der slutter ved ; 

void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;                       // Skyerne starter samme steder som før
  sky_2x = 220;          
  sky_1fart = 1;                      // Og ligeså deres hastigheder. Intet nyt.
  sky_2fart = 1.5;
}

void draw() {
  fill(himmel);                       // Som før tegner vi himmel og skyer.
  stroke(himmel);        
  rect(0, 0, 620, 200);               // Himlen tegnes stadig hver gang draw() gennemløbes. 
  
  fill(sky);                          // Og skyerne også som før
  stroke(100);                      
  ellipse(sky_1x, 70, 280, 100);     
  ellipse(sky_2x, 130, 150, 80);    
  sky_1x += sky_1fart;                // Skyerne rykker sig lidt for hvert gennemløb af draw().
  sky_2x += sky_2fart;               

  if (sky_1x > 800) sky_1x = -200;    // Og skyerne kan starte forfra, når de kommer uden for vinduet. 
  if (sky_2x > 720) sky_2x = -100;  
  
  tegnTrae(300, 600);                 // Nu kalder vi den nye funktion
  
} // Klammen her er meget vigtig. Den afslutter draw()-funktionens kodeblok.


/*  
 * Her starter den nye tegnTrae()-funktion.
 * Funktionen får to parametre (xx og yy), begge af typen float. De står inde i parentesen efter 
 * funktionens navn, og de angiver den position, vi laver tegningen ud fra. 
 *
 * Disse parametre bruges inde i funktionen som "lokale variabler", altså variabler, der ikke er 
 * defineret for hele programmet men kun for den kodeblok, hvori de står.
 * 
 * På dette sted (over kommentaren her) kan du indsætte din egen, nye tegnHimmel()-funktion. 
 * Husk krøllede parenteser. 
 */
void tegnTrae(float xx, float yy) {   // Denne linje definerer hvordan man kan kalde funktionen

  stroke(0);                          // Vi skal stadig have de samme farver
  fill(stamme);
  rect(xx, yy, 20, 120);              // Her benytter vi så, i stedet for tal, de variabler,
                                      // vi angiver i funktionskaldet. xx og yy er positionen
                                      // for stammens øverste venstre hjørne, men de tal, der er 
                                      // gemt i variablerne og som anvendes i beregningerne, 
                                      // bliver sendt til funktionen derfra hvor den bliver 
                                      // kaldt. I dette tilfælde kommer tallene enten fra første træ, 
                                      // oppe i draw(), eller fra musens koordinater i mouseClicked().
                                      // Fidusen ved at lave tegnTrae til en funktion er netop,
                                      // at man kan genbruge koden uden at skulle vælge disse
                                      // koordinater på forhånd
  fill(blade);
  ellipse(xx+10, yy-180, 150, 180);   // Ellipsen skal selvfølgelig ikke tegnes samme sted som stammen.
                                      // Derfor skal den forskubbes. Jeg har ikke fået gjort det pænt,
                                      // du kommer til at rette det...
                                      //
                                      // Sæt også æblet på
}

/* 
 * mouseClicked() er nu lavet om, så den kalder tegnTrae(..) i stedet for at tegne blomsten.
 */
void mouseClicked() {
  tegnTrae(mouseX, mouseY);
}

/* Hernede kunne du også placere nye funktioner, fx tegnHimmel() */

  // Opgave 1:  Ret funktionen tegnTrae(..) til, så kronen står pænt i forhold til stammen, og så
  //            der er et æble på træet igen.
  //
  // Opgave 2:  Ret funktionen tegnTrae(..) til, så museklikket angiver træets rod, dvs. midt på
  //            bunden af stammen. Det giver mere mening. Men det kræver, at du regner på, hvilke
  //            koordinater stamme, krone og æble så skal tegnes i forhold til.
  //
  // Opgave 3:  Lav selv en ny funktion. Tag alle de kodelinjer, der bruges for at tegne himmel 
  //            og skyer, klip dem ud og sæt dem ned som en selvstændig metode (funktion), lige som 
  //            tegnTrae(...). Kald den nye funktion for tegnHimmel() og skriv void foran, lige som 
  //            de andre funktioner (void betyder "intet" eller "tomhed". Disse funktioner skal ikke 
  //            returnere en værdi). Oppe i draw()-metoden, hvorfra du fjernede alle kodelinjerne,
  //            skriver du nu i stedet blot et kald til den nye funktion, sådan her: tegnHimmel();
  //            Det gør din draw()-metode meget mere overskuelig.
  //
  //            Det er helt afgørende, at du får placeret den nye funktion rigtigt i kodeteksten.
  //            Læg mærke til de krøllede parenteser (klammer). Inde mellem sådan to står en såkaldt 
  //            "kodeblok". Den kodeblok, der lige nu hører til draw()-funktionen, slutter med den
  //            klamme, der står lige efter tegnTrae(300,600);   Din nye funktion skal placeres lige 
  //            efter den, altså uden for draw()-funktionen.
  