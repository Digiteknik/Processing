var mic
var vol = 0

function setup() {
    createCanvas(1200, 100);
    // Create an Audio input
    mic = new p5.AudioIn();
    // start the Audio Input.
    // By default, it does not .connect() (to the computer speakers)
    mic.start();
    let d = createElement('div', 'Tryk på cirklen for at tænde mikrofonen...').style('font-family:arial;color:gray').position(20, 70);
}

function draw() {
    // Get the overall volume (between 0 and 1.0)
    var vol = mic.getLevel();
    background(240);
    fill('hotpink');
    noStroke();
    // Draw an ellipse with height based on volume
    var h = map(vol, 0, 0.5, height, 0);
    ellipse(width/2, h - 25, 50, 50);
}

function touchStarted() {
    getAudioContext().resume()
}
