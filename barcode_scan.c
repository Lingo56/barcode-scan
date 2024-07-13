#pragma config(Sensor, S2,     Light_Sensor,   sensorEV3_Color)
#pragma config(Motor, motorA, leftMotor, tmotorEV3_Large, PIDControl, encoder)
#pragma config(Motor, motorD, rightMotor, tmotorEV3_Large, PIDControl, encoder)
//*!!Code automatically generated by 'ROBOTC' configuration wizard               !!*//

//#pragma config(Sensor, S2,     LightEyes,      sensorEV3_Color)

task main()
{
    // The first argument is a datalog index number.
    // The filename will be saved in the rc-data folder as
    // datalog-<INDEX>.txt
    // The format is a comma separated value file.
    // The 2nd argument is the number of columns you wish to have in the file
    // The 3rd argument specifies if you wish to append to the datalog ('right'),or if you want to overright ('flase').

    datalogFlush();
    datalogClose();

    // Variables for motor speed and duration
  int motorSpeed = 3; // Adjust motor speed as needed
  int startTime = nPgmTime; // Get start time

    if (!datalogOpen(111, 2, false)){
        displayCenteredTextLine(4,"Unable to open datalog");
    } else {
        displayCenteredTextLine(4,"Datalog open");
        // Start moving forward slowly
      motor[leftMotor] = motorSpeed;
      motor[rightMotor] = motorSpeed;
    }

    // You can add an entry at the specified column number
    for (int i = 0; i < 6000; i++)
    {
               int newLightValue;

               if (getColorReflected(S2) >= 50) {
                   newLightValue = 100;
               }
               else {
                   newLightValue = 0;
           }

      datalogAddFloat(1, newLightValue);
      datalogAddFloat(0, i+2);
      displayCenteredTextLine(5,"Add: %d", getColorReflected(S2), "converted to", newLightValue);

      sleep(1);
    }

    motor[leftMotor] = 0;
      motor[rightMotor] = 0;

    // Make sure you close the file properly
        datalogClose();
}

//csvread