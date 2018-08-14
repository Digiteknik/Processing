/* Processing: Lyt efter musen og indsæt et billede
 * Oven på den foregående sketch med træ, græs, himmel og drivende skyer, 
 * vil vi nu tegne et foto af en blomst, hver gang vi klikker med musen.
 *
 * Det meste af sketchen her er altså det samme som de tidligere. Og derfor
 * kommer opgaverne til denne sketch også først til allersidst.
 */

color stamme = color(170, 80, 30);    // Samme som før.
color blade = color(30, 170, 60);     
color graes = color(220, 180, 15);    // Vissent som først. Husk at rette denne til din egen græs-farve
color himmel = color(190, 130, 255);  // Lilla igen - find din egen himmelblå farve frem.
color sky = color(240);               

float sky_1x, sky_2x,                 // Variabler til at styre skyerne med.
      sky_1fart, sky_2fart;           // Bemærk: Processing læser dette som een linje, der slutter ved ; 

PImage blomst;                        // Vi skal sætte et billede ind med musen. Vi gemmer det i en 
                                      // variabel af typen PImage (P står for Processing) med navnet 
                                      // blomst. Du skal som det første hente billedet fra Lectio,
                                      // hvor det ligger i præsentationen under navnet tulipan.png.
                                      // Du gør det derpå tilgængeligt for programmet ved at gå op i 
                                      // programmets menu-linje og vælge Sketch >> Add file...
                                      // Så bliver det lagt i en mappe hvor Processing kan finde det.

void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;                       // Skyerne starter samme steder som før
  sky_2x = 220;          
  sky_1fart = 1;                      // Og vi angiver deres hastigheder heroppe. Ellers intet nyt.
  sky_2fart = 1.5;
  
  blomst = loadImage("tulipan.png");  // Her indlæser Processing billedet så sketchen kan bruge det.
                                      // HVIS altså du har lagt det ind som angivet ovenfor, ellers
                                      // melder programmet fejl.
                                      // Billedet er her et .PNG-billede, fordi det billedformat kan
                                      // indeholde gennemsigtige områder. GIF- og JPG-filer duer også.
}

/* Hele draw()-funktionen er som før. Det nye står efter den. */
void draw() {
  fill(himmel);                       // Som før tegner vi himmel og skyer.
  stroke(himmel);        
  rect(0, 0, 620, 200);               // Himlen tegnes stadig hver gang draw() gennemløbes. 
  
  fill(sky);                          // Og skyerne også som før
  stroke(100);                      
  ellipse(sky_1x, 70, 280, 100);     
  ellipse(sky_2x, 130, 150, 80);    
  sky_1x += sky_1fart;                // Disse variabler lavede du selv i foregående sketch 
  sky_2x += sky_2fart;               

  if (sky_1x > 800) sky_1x = -200;    // Betingelserne for at "genstarte" skyerne. 
  if (sky_2x > 720) sky_2x = -100;    // Sådan cirka fik du forhåbentlig også selv rettet koden til.
  
  stroke(0);                          // Til sidst skal vi igen have tegnet træet.
  fill(stamme);                       // Stammen først
  rect(300, 530, 20, 120);
  fill(blade);                        // Og derpå kronen. Helt som i de første sketches. 
  ellipse(310, 450, 150, 180);        // Og sæt så gerne selv et æble på igen.
}

/* mouseClicked() er det nye i denne sketch.
 * Når en sketch kører, holder Processing hele tiden øje med musens position (inden for vinduet).
 * Denne position kan man hele tiden få adgang til ved at bruge mouseX og mouseY.
 *
 * mouseClicked() er en af de indbyggede funktioner - når musen klikkes (trykkes og slippes samme sted),
 * vil det, der står mellem klammerne i funktionen blive udført. 
 *
 * Her er det at indsætte det billede, vi loadede i setup()-funktionen. 
 * Det gøres med funktionskaldet image(<filnavn>, <x-position>, <y-position>); 
 */
void mouseClicked() {
  image(blomst, mouseX, mouseY);      // Tegner det angivne billede det angivne sted.
}

// Opgave 1: Forklar din sidemand, 
//           hvorfor man ikke kan tegne blomsten oven på træet eller oppe på himlen.

// Opgave 2: Billedet bliver ikke indsat lige der hvor musen er. Det er fordi x- og y-koordinaterne 
//           angiver billedets øverste venstre hjørne. Hvis du trækker lidt fra de værdier, der kommer
//           fra mouseX og mouseY bliver det bedre. (Forklar din sidemand hvorfor).
//           Prøv at lave det så museklikket angiver midten af billedet. Eller blomstens stilk. 
//           (Hint: Find ud af, hvor mange pixler billedet er på hver led).

// Opgave 3: Prøv at sætte et andet billede ind. Husk, at det skal gøres tilgængeligt for Processing,
//           dvs. lægges i den rigtige mappe, ved at bruge Sketch >> Add File... i menu-linjen.
//           Måske er billedet nu alt for stort. Du kan gøre det mindre ved at kalde image()-funktionen
//           med lidt flere parametre, således:
//               image(<filnavn>, <x-position>, <y-position>, <x-størrelse>, <y-størrelse>);
//
//           (Hint: Billedfilens størrelse kan skaleres ved at bruge ordene width og height inde i
//           kaldet til image()-funktionen. Så kan du selv gange eller dele med en passende faktor.
//           Læg mærke til, at ordene bliver røde lige som mouseX og mouseY. Det er tegn på, at 
//           Processing kender og bruger de pågældende ord).