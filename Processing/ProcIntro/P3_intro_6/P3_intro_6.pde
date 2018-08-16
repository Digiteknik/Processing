/* Processing: for-løkker, betingelser og flag. 
 * 
 * Den foregående sketch sluttede med, at der blev tegnet mængder af træer uden stop.
 * Nu vil vi lave en hel skov, men det skal stoppe når der er tegnet 50 træer. Derefter 
 * kan vi tilføje flere træer med musen. For at kunne det, skal vi til at bruge noget, der
 * kaldes en løkke og noget, der kaldes en betingelse. 
 *
 * En løkke i programmering er noget, der gentages igen og igen. draw()-metoden er en løkke,
 * og den stopper ikke. En for-løkke, derimod, indeholder en betingelse, som siger hvornår 
 * den skal stoppe. Vi laver en ny metode, der hedder tegnSkov(.), som får en parameter der
 * siger hvor mange træer vi vil have i skoven. I tegnSkov(.)-metoden lægger vi en sådan 
 * for-løkke, og vi vil gerne have løkken til at stoppe, når der er tegnet 50 træer. 
 *
 * Imidlertid er det ikke nok at stoppe for-løkken. Næste gang draw()-metoden kører (og den kører
 * jo igen og igen) skal man sørge for at for-løkken ikke bliver kørt en gang til og tegner nye
 * 50 træer. For at holde styr på, om draw()-metoden skal tegne en skov eller ej, laver vi en 
 * særlig type variabel: Et såkaldt "flag".
 */

// Variabler. 
// Der er en ny på listen, af typen boolean. Det betyder, at den kan være enten sand eller falsk.
// Den slags variabler kaldes somme tider for et "flag", som fortæller noget om en "tilstand" i
// programmet. Her er flaget "hejst", hvis ikke skoven er blevet tegnet, men det "tages ned" 
// (sættes til "falsk"), så snart vi har skoven på plads.
color stamme = color(170, 80, 30);
color blade = color(30, 170, 60);
color graes = color(100, 215, 55);
color himmel = color(170, 170, 255);
color sky = color(240, 240, 240);

float sky_1x, sky_2x, sky_1fart, sky_2fart;  // Variablerne til at styre skyerne med.

boolean skovIkkeTegnet = true;          // Dette er flaget, der siger om draw() skal tegne en skov.
                                        // Det skal draw()-metoden kun gøre, hvis ikke skoven allerede 
                                        // er blevet tegnet, og det er den jo ikke fra starten, så til
                                        // at starte med er flaget "hejst", altså sat til "true".

// setup()-metoden er ikke ændret
void setup() {
  size(620, 800);
  background(graes);
  sky_1x = 440;                       
  sky_2x = 220;          
  sky_1fart = 1;                      
  sky_2fart = 1.5;
} // her slutter setup()

// draw()-metoden tegner nu en hel skov. tegnSkov()-funktionen står lige neden under.
void draw() {
  if(skovIkkeTegnet) tegnSkov(50);      // Vi vil gerne have tegnet en skov med 50 træer.
                                        // Men vi vil KUN have det gjort en gang. Hvis der
                                        // allerede er tegnet en skov, så springer vi denne
                                        // linje over og tegner kun himlen hvor skyerne
                                        // driver afsted.
  tegnHimmel();
} // her slutter draw()

/* tegnSkov()-metoden tegner det antal træer, den får besked på. Det sker med
 * parameteren antalTraer, der er et helt tal og derfor af typen int (for "integer").
 *
 * Øverst i koden står vores for-løkke. I for-parentesen står der 3 linjer kode, 
 * adskilt af semikolon. Først erklæres vores tællevariabel t (et helt tal, derfor 
 * af typen int ), som her tæller antallet af træer, der allerede er blevet tegnet. 
 * Betingelsen, at vi ikke allerede har tegnet 50 træer, står i midten, og til sidst 
 * "inkrementerer" vi tællevariablen (lægger 1 til værdien) med t++. På den måde 
 * tegnes træerne et efter et, indtil antalTraer er nået.
 */
void tegnSkov(int antalTraer) {
  for(int t = 0; t < antalTraer; t++) { // Her starter for-løkken. 
                                        // Vi skal have lavet en farve til trækronen. 
                                        // Det gør vi for hvert enkelt træ.
    float rr = random(30, 115);         // Mængden af Rød varierer mellem 30 og 115.
    float gg = random(130, 255);        // Mængden af Grøn varierer mellem 130 og 255.
    float bb = random(30, 115);         // Mængden af Blå varierer mellem 30 og 115.
    color krone = color(rr, gg, bb);    // Ud fra de tre talværdier laver vi en farve.

    tegnTrae(random(50, 570), random(400, 780), krone); // Så kalder vi tegnTrae(...), 
                                        // nu med tilfældige koordinater, som vi gjorde
                                        // sidst i foregående sketch
  } // her slutter for-løkkens kodeblok
  
  skovIkkeTegnet = false;               // Til sidst "sænker vi flaget": Nu er skoven blevet 
                                        // tegnet, så skal det ikke gøres igen.
} // Her slutter tegnSkov()-metoden

// tegnHimmel()-metoden er ikke ændret.
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
} // her slutter tegnHimmel()

// tegnTrae()-metoden er ikke ændret. Husk selv æblet
void tegnTrae(float xx, float yy, color ff) {
  stroke(0);
  fill(stamme);                        
  rect(xx-10, yy-120, 20, 120);       
  fill(ff);                            
  ellipse(xx, yy-210, 150, 180);       
}

// mouseClicked() er som før, vi kan stadig "plante nye træer". Ret selv farveintervallerne.
void mouseClicked() {
  float rr = random(255);             // Mængden af Rød varierer mellem 0 og 255.
  float gg = random(100, 255);        // Mængden af Grøn varierer mellem 100 og 255.
  float bb = random(255);             // Mængden af blå varierer mellem 0 og 255.
  color krone = color(rr, gg, bb);    // Ud fra de tre talværdier laver vi nu en ny farve,
                                      // som vi sender til tegnTrae(...) sammen med musens
                                      // koordinater.
  tegnTrae(mouseX, mouseY, krone);
}

// Opgave 1:  Prøv at ændre på antallet af træer i skoven.

// Opgave 2:  Hvad sker der, hvis du ikke tager hensyn til flaget, altså sletter
//              if(skovIkkeTegnet) oppe i draw()-metoden (men lader tegnSkov(5); stå)?

// Opgave 3:  Træerne står ikke pænt - de øverste får toppen klippet af af himlen, og de 
//            "forreste", som er dem, der er blevet tegnet sidst, står oppe i grenene på dem 
//            bagved. Vi kan bruge tællevariablen t til at få skoven til at se lidt pænere ud 
//            ved at kræve, at træerne bliver tegnet "oppe fra og ned", sådan at de træer, der 
//            tegnes sidst, kommer til at stå længst nede mod bunden. Prøv at indsætte dette:
//              tegnTrae(random(50, 570), 400 + t*5, krone);
//            oppe i for-løkken. Det vil gøre, at det første træ tegnes med y-koordinaten 400
//            (fordi t er 0 første gang), og hvert følgende træ rykker 5 pixler længere ned
//            mod bunden. Det ser lidt pænere ud.
// 
//            Sørg til sidst for, at startværdien for y-koordinaterne rykkes ned, så træerne
//            har top på.
