/*
 * Super Simple Ajustable Strobe for Arduino - Learning Version
 * by TechNinja and SuperAwesomeSylvia - First release: September 2010
 *
 * Part of Sylvia's Super Awesome Maker Show! - Episode 3
 *  http://tn42.com/maker-show
 *  http://tn42.com/strobe
 *
 * Fork this on GitHub:
 *  http://github.com/techninja/adjustable_strobe-learning
 *
 * --------------------------------------------------------------
 * =    Licensed under the CC-GNU GPL version 2.0 or later      =
 * =      http://creativecommons.org/licenses/GPL/2.0/          =
 * --------------------------------------------------------------
 *
 * Strobes an LED connected to pin 13. The amount of time the LED will
 * be on and off depends on the value obtained by analogRead().
 *
 * Things needed to build it:
 * - Arduino (duh!)
 * - Bright LED
 * - Potentiometer (Semi-optional)
 * - Something spinning or moving quickly to try it on (Try a desk or CPU fan!)
 *
 * Build steps:
 * - Connect your LED to Ground and digital pin 13
 * - Connect the outer leads of your potentiometer to 5v and ground 
 * - Connect the middle lead of your potentiometer to analong in 2
 * - Upload this sketch
 * - Point the light at something spinning, and slowly rotate the potentiometer.
 * If the spinning object is within the given range, it will align the flashing
 * will align with the rate of the object and appear to slow it down. Stroboscopes rock!
 * 
 *
 * References:
 *  http://arduino.cc/en/Tutorial/AnalogInput
 *  http://arduino.cc/en/Tutorial/Blink
 *  http://cre.ations.net/creation/the-time-fountain
 */

/******* -----=====!! EASY STUFF TO MESS WITH !!=====------ ******/
  
  // What analog pin should we use to read the value from the potentiometer?
  int potentiometer_pin = 2; // Yep, you heard right: The coolest of the Analog pins...
  
  // What pin is the LED connected to?
  int led_pin = 13; // Contains a built in resistor (though it doesn't seem to matter much for strobes)
  
  // How much time should the light stay on between delay times (in Micro Seconds)? 
    /* Big number = more blur, more perceived brightness
     * Small number = less blur, less perceived brightness  */
  int on_time = 100; // 100 uSeconds makes a reasonable tradeoff
  
  // How much should we multiply the incoming value by?
    /* Big number = less precision, more range
     * Small number = more precision, less range  */
  int analog_value_multiplier = 15; // 15 Seems to work well for fans =)
  
  // What should the minimum delay be (in Micro Seconds)?
  // This sets the bottom delay range of the strobe, as a delay of 0 doesn't actually flash =P
  int minimum_delay = 500;
  
/******* -----=====^^ EASY STUFF TO MESS WITH ^^=====------ ******/


// Initialize the number to hold our strobe delay. Isn't used till we get to the main loop
int strobe_delay = 0;  

void setup() {
  // Tell the arduino to use the led_pin as an output. 
  pinMode(led_pin, OUTPUT);  
}

void loop() {
  // Read the value from the potentiometer, and use it to make our strobe delay
  // by adding the minimum delay, then increasing it to a useful value with analog_value_multiplier
  strobe_delay = minimum_delay + analogRead(potentiometer_pin) * analog_value_multiplier;
  
  // Switch the led_pin to HIGH! Sends out 5v to the led_pin.
  digitalWrite(led_pin, HIGH);
  
  // Delay for the given on_time. (Limits Bluring)
  delayMicroseconds(on_time);
  
  // Turn off the led. Switch the led_pin to LOW.
  digitalWrite(led_pin, LOW);
  
  // Delay for the strobe_delay time read from the potentiometer
  // (less the time we already spent from leaving the LED on.
  delayMicroseconds(strobe_delay - on_time); 
}
