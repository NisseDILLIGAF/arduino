/*
 * Append a line to a file - demo of pathnames and streams
 */
#include <SdFat.h>

// SD chip select pin
const uint8_t chipSelect = SS_PIN;

// file system object
SdFat sd;

// define a serial output stream
ArduinoOutStream cout(Serial);
//------------------------------------------------------------------------------
/*
 * Append a line to LOGFILE.TXT
 */
void logEvent(const char *msg) {
  // create dir if needed
  sd.mkdir("LOGS/2011/JAN");

  // create or open a file for append
  ofstream sdlog("LOGS/2011/JAN/LOGFILE.TXT", ios::out | ios::app);

  // append a line to the file
  sdlog << msg << endl;

  // check for errors
  if (!sdlog) sd.errorHalt("append failed");

  // file will be closed when sdlog goes out of scope
}
//------------------------------------------------------------------------------
void setup() {
  Serial.begin(9600);

  // pstr stores strings in flash to save RAM
  cout << pstr("Type any character to start\n");
  while (Serial.read() < 0) {}

  // initialize the SD card at SPI_HALF_SPEED to avoid bus errors with
  // breadboards.  use SPI_FULL_SPEED for better performance.
  if (!sd.init(SPI_HALF_SPEED, chipSelect)) sd.initErrorHalt();

  // append a line to the logfile
  logEvent("Another line for the logfile");

  cout << "Done - check /LOGS/2011/JAN/LOGFILE.TXT on the SD" << endl;
}
//------------------------------------------------------------------------------
void loop() {}
