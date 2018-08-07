/* Processing: Variabler, setup() og draw()
 *
 * Vi tegner en græsplæne med et træ, og lærer det grundlæggende om Processing. 
 * Et program i Processing kaldes en sketch. Start med at "køre" denne sketch 
 * ved at trykke på Run-knappen herover (den med trekanten).
 *
 * En grundlæggende ting er brugen af kommentarer. Det er meget vigtigt. 
 * Alle sketches bør starte med nogle kommentarer om, hvad sketchen skal gøre. 
 * Kommentarer kan stå som her, markeret med stjerner, eller de kan stå efter
 * to skråstreger, //, som forklaring til ting i en linje. Alt hvad der står
 * i en linje efter sådan to skråstreger vil selve programmet springe over, 
 * når det kører.
 */

/* Først i koden plejer man at opskrive - "erklære" - navnene på de forskellige  
 * værdier, programmet skal bruge. De kaldes "variabler" og har hver 
 * en bestemt type og et bestemt navn. Æ, Ø og Å må ikke bruges i navnene.
 * Først definerer vi nogle farver
 */
color stamme = color(170, 80, 30); // Variabel af typen color med navnet stamme. En brun farve.
color blade = color(30, 170, 60);  // Farver på skærmen er sammensat af tre tal: Mængderne af hhv.
color graes = color(90, 230, 55);  // rød, grøn og blå (RGB). Tallene skal ligge mellem 0 og 255.
color aeble = color(240,50,0);     
color streg = color(255);          // Hvis der kun er et enkelt tal i parentesen, er der lige meget 
                                   // R, G og B i farven. 255 er hvid, 0 er sort, tal derimellem er grå.

/* Når Processing starter, køres først setup()-funktionen. Den kører een gang.
 * Alle Processing-sketches skal have en setup()-funktion og en draw()-funktion.
 */
void setup() {
  size(620, 800);    // Angiver størrelsen på vinduet, først bredde (x) og så højde (y)
  background(graes); // Angiver farven på baggrunden i vinduet.
}

/* Efter setup() køres draw()-funktionen. Den kører i princippet hele tiden i en løkke,
 * så hurtigt det kan lade sig gøre. Det er her, vi tegner de ting, der vises i vinduet.
 */
void draw() {
  // stroke(streg);             // Angiver, at figurernes kontur skal have farven "streg". 
                                // Linjen herover er "kommenteret ud", altså deaktiveret med //.
  fill(stamme);                 // Angiver at der skal udfyldes med farven "stamme", altså brun.
  rect(300, 500, 20, 120);      // Stammen er en firkant med x- og y-koordinat (øverste venstre   
                                // hjørne) samt bredde og højde (de to sidste tal).
  fill(blade);                  // Angiver at der skal tegnes med farven "blade", altså grøn
  ellipse(310, 400, 170, 250);  // Kronen er en ellipse med x- og y-koordinat (centrum) 
                                // samt bredde og højde.
  fill(aeble);                  
  ellipse(360, 450, 17, 17);    
}