var mic, recorder, soundFile;

var state = 0; // mousePress will increment from Record, to Stop, to Play

function setup() {
    createCanvas(400, 400);
    fill(20, 200, 0);
    noStroke();
    ellipse(200, 200, 300, 300);
    fill(0);
    textSize(14);
    text('Enable mic and click the mouse to begin recording', 20, 380);

    // create an audio in
    mic = new p5.AudioIn();

    // users must manually enable their browser microphone for recording to work properly!
    mic.start();

    // create a sound recorder
    recorder = new p5.SoundRecorder();

    // connect the mic to the recorder
    recorder.setInput(mic);

    // create an empty sound file that we will use to playback the recording
    soundFile = new p5.SoundFile();
}

function mousePressed() {
    background(255);
    // use the '.enabled' boolean to make sure user enabled the mic (otherwise we'd record silence)
    if (state === 0 && mic.enabled) {

        // Tell recorder to record to a p5.SoundFile which we will use for playback
        recorder.record(soundFile);

        fill(255, 20, 147);
        noStroke();
        ellipse(200, 200, 300, 300);
        fill(0);
        text('Recording now! Click to stop.', 20, 380);
        state++;
    } else if (state === 1) {
        recorder.stop(); // stop recorder, and send the result to soundFile

        fill(20, 200, 0);
        noStroke();
        ellipse(200, 200, 300, 300);
        fill(0);
        text('Recording stopped. Click to play & save', 20, 380);
        state++;
    } else if (state === 2) {
        soundFile.play(); // play the result!
        fill(20, 200, 0);
        noStroke();
        ellipse(200, 200, 300, 300);

        //saveSound(soundFile, 'mySound.wav'); // save file
        state++;
    }
}
