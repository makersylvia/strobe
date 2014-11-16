
// Gray text with two slashes are just helpful comments, you don’t need to type them. :)

/******* -----=====!! EASY STUFF TO MESS WITH !!=====------ ******/

  // What analog pin should we use to read the value from the potentiometer?
  int analogPin = 2; // Yep, you heard right: The coolest of the Analog pins...

  // What pin is the LED connected to?
  int ledPin = 13; // Contains a built in resistor!

  // How much time should the light stay on between delays, in Microseconds (millionths of a second)?
    /* Big number = more blur, more perceived brightness
     * Small number = less blur, less perceived brightness  */
  long onTime = 250;

  // What should the minimum delay be in milliseconds (thousandths of a second)?
  // This sets the bottom delay range of the strobe, as a delay of 0 doesn't actually flash =P
  // The strobe starts with this as the "fastest" mode, and goes slower from there, adding to the delay
  int minDelay = 1; // 1 is the lowest we can actually do without a better delay function	

  // What should the maximum delay be in milliseconds?
  // This is the longest time that the biggest potentiometer value will be mapped to, and longest
  // time between strobe flashes.
  int maxDelay = 100;


/******* -----=====^^ EASY STUFF TO MESS WITH ^^=====------ ******/

// Initialize the number to hold our strobe delay. Isn't used till we get to the main loop
long strobe_delay = 0;

void setup() {
 pinMode(ledPin, OUTPUT); // Setup ledPin as an output.
}

void loop() {
  // To make the math easier, we use map(value, fromMin, fromMax, toMin, toMax) to convert the
  // 0 to 1023 range we get from analogRead, into our strobe delay range of 1 to 100 :D
  strobeDelay = map(analogRead(analogPin), 0, 1023, minDelay, maxDelay);

  digitalWrite(ledPin, HIGH); // Switch the ledPin to HIGH, turn it on!
  delayMicroseconds(onTime); // Delay while on, for the given onTime.
  digitalWrite(ledPin, LOW); // Switch the ledPin to LOW, turn if off!
  delay(strobeDelay); // Delay while off, for given strobeDelay.
}