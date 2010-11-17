{{
Notes:  This Package (.11) is based off of SVN Version 35.  It is compatible with Current Documentation.
        Limitations:  Only supports direct control of the Vehicle, by either Remote Control or Interface.
        No communication between Remote Control and Interface is intended, due to AT Mode of Radio's.     
Done:
-Write Code to recieve and display Errors  
-Write Code to use Multi-UART
-Write Code for LCD Display
-Write Code for ADC
-Write Code for Digital Inputs
-Write Code for UART/Non-JAUS Protocol 
}} 
{{
Operation of Remote Control:
LED's:
LED 1 Blink during Initialization then Off
LED 1 Solid On during any Error Code after Initialization
LED 2 Blink during Manual Operation
LCD:
Line 1 - Operating Mode
Line 2 - Error Code
}}
{{
DATE:  4-Dec-09
DPG:   Started testing program on Proto-Board mockup.
DATE:  20-Sep-09
DPG:   Added GPS functionality to Remote Control, so Vehicle can navigate to "Home".
DATE:  1-Sep-09
DPG:   Fixed error in binary calculation with button inputs.
DATE:  20-Aug-09
DPG:   Went over Code thoroughly.
DATE:  26-July-09
DPG:   Changed so that LCD operates based on above lines, using LCD commands.  This means that outputting CR/LF to LCD is no
       longer necessary.
DATE:  25-July-09
DPG:   Changed so that Analog values are transmitted only when they change.  Also, will LCD overflow with current setup?
DATE:  24-July-09
DPG:   Added in more comments.  Is getradiorxbuffer() blocking?
DATE:  23-July-09
DPG:   Changed pin numbers, fixed error with buttonvalue calculation.
DATE:  8-July-09
DPG:   Added in support for going into Manual/Auto Modes.  Added some additional comments.
       Added some code for LCD Display.  Added in code for Error Generation.
DATE:  28-June-09
DPG:   Started working on file.  Wrote Code for basic functionality of Remote Control.  Would like to also
       add support in for GPS sensor on Remote Control and LCD Display
}}
{{
COG Usage:
COG 1:  Main Program
COG 2:  Radio, LCD UART
COG 3:  ADC
COG 4:  Floating Point Processor
}}
{{
******************************************
* main                                   *
* Author: David Gitz                     *
* Copyright (c) 2008 David Gitz          *
* See end of file for terms of use.      *
******************************************
}}
con
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

' Pin Names
  PINNOTUSED = -1
               
  radiotx = 30
  radiorx = 31
  gpsrx = 2

  digina1 = 3
  digina2 = 4
  digina3 = 5
  diginb1 = 6
  diginb2 = 7
  diginb3 = 8

  ADCClock = 9 
  ADCData =  10  
  ADCChipSelect = 11
   
  ledpin1 = 12
  ledpin2 = 13

  lcdtx = 14

  radioPort = 0
  radioBaudRate = 9600
  radioMode = %0000

  lcdPort = 1
  lcdBaudRate = 9600
  lcdMode = %0000

  GpsPort = 2 
  GpsBaudRate = 4800
  GpsMode = %1000

'LCD Definitions
  LCDCMD =   $FE
  LCDCLS =   $0F
  LCDLINE1 = $80
  LCDLINE2 = $C0
  
  
'ASCII Definitions
  CR = 13
  LF = 10
  period = 46
  periodCON = 46
  commaCON =  44
  asterickCON = 42
  minuscon = 45
' Timing
  waitdelay = 100_000
'XBox 360 Controller Mapping
 'Buttons
 AButton = 7  'A, Enters Manual/Auto Mode
 BButton = 6  'B, Turns off Vehicle
 XButton = 5  'X, Home
 YButton = 4  'Y
 DLButton = 3 'D-Pad Left
 DUButton = 2 'D-Pad Up, Enter TAKEOFF Mode
 DRButton = 1 'D-Pad Right, Enter HOVER Mode
 DDButton = 0 'D-Pad Down, Enter LAND Mode
 
 LBButton = 7 'Left Bumper
 RBButton = 6 'Right Bumper
 LTButton = 5 'Left Thumbstick
 RTButton = 4 'Right Thumbstick
 BKButton = 3 'Back
 STButton = 2 'Start
 
 'Analog
 LHAnalog =  3'Left Horizontal Stick
 LVAnalog =  1'Left Vertical Stick
 RHAnalog =  4'Right Horizontal Stick
 RVAnalog = 2 'Right Vertical Stick

  gyrox = 0
  gyroy = 1
  gyroref = 2
                  
var
  long stack[9]
  long dist                                 
  byte gpsbyte,radiobyte,rxinit, checksum
  byte radiorxbuffer[50]
  byte gpsrxbuffer[50]
  
  byte analogchanged
  byte lastyaw
  byte lastthrottle
  byte lastpitch
  byte lastroll

  long lat1
  byte lat1dir
  byte lat1str[7]
  long lat2
  byte lat2dir
  long lon1
  byte lon1dir
  byte lon1str[7]
  long lon2
  byte lon2dir
  long alt
  byte altstr[3]

  byte manual
  long rcerrorcode  'Error Codes for Remote Control 
  long vherrorcode  'Error Codes for Vehicle
  long inerrorcode  'Error Codes for Interface
  long cogsused
  
obj                            
  com:          "pcFullDuplexSerial4FC"                      'Radio uart
  fmath:        "DynamicMathLib"                        'floating point
  util:         "Util.spin"                             'utilities
  adc:          "MCP3208"                               'adc
  strconv:      "FloatString"
  gps:           "FullDuplexSerial"                        
    
PUB init | i,j,sum, tempstr1,temp1,tempstr2              
''DPG 28-June-09
    
  cogsused := 0
  rcerrorcode := 0
  vherrorcode := 0
  inerrorcode := 0
                     
  outa[ledpin1]~~
  waitcnt(3*clkfreq + cnt) ' Wait 3 seconds for XBee to Power UP
  dira[ledpin1]~~
  dira[ledpin2]~~
  !outa[ledpin1] 
  ''Initialize UART's
  com.init
  com.AddPort(radioPort,radiorx,radiotx,com#PINNOTUSED,com#PINNOTUSED,com#DEFAULTTHRESHOLD,radioMode,radioBaudRate) 
  com.AddPort(lcdPort,com#PINNOTUSED,lcdtx,com#PINNOTUSED,com#PINNOTUSED,com#DEFAULTTHRESHOLD,lcdMode,lcdBaudRate)
  com.AddPort(gpsPort,gpsrx,com#PINNOTUSED,com#PINNOTUSED,com#PINNOTUSED,com#DEFAULTTHRESHOLD,gpsmode,gpsBaudRate)
  
  !outa[ledpin1] 
  if com.start
    cogsused += 1 'Should be 1
    com.dec(radioport,cogsused)
  else                     
    rcerrorcode := 20001

  !outa[ledpin1] 
  ''Initialize ADC
  if adc.Start(ADCData, ADCCLock, ADCChipSelect, %11111111)
    cogsused += 1 'Should be 2
  else
    rcerrorcode := 20003

  !outa[ledpin1] 
  ''Initialize Floating Point
  if fmath.start
    cogsused += 1  'Should be 3
  else
    rcerrorcode := 20004
    
  !outa[ledpin1] 
  if cogsused <> 3
    !outa[ledpin1]
    rcerrorcode := 20008 
    
  fmath.allowfast

  if (rcerrorcode <> 0)
    outa[ledpin1] := TRUE
  else
    outa[ledpin1] := FALSE

  testgps
  datapacketmode

PUB testgps
  repeat
    getgpsrxbuffer(@gpsrxbuffer)
    com.str(radioport,gpsrxbuffer)
    !outa[ledpin2]
    waitcnt(waitdelay + cnt)                   
PUB testgyro
  repeat
    com.str(radioport,string("X: "))
    com.dec(radioport,adc.in(gyrox))
    com.str(radioport,string(" "))
    com.str(radioport,string("Y: "))
    com.dec(radioport,adc.in(gyroy))
    com.str(radioport,string(" "))
    com.str(radioport,string("Ref: "))
    com.dec(radioport,adc.in(gyroref))
    com.str(radioport,string(CR,LF))
    'waitcnt(waitdelay + cnt)
    !outa[ledpin2]
    
    
PUB datapacketmode | buttonvalueA, buttonvalueB, pitch, roll, yaw, throttle,temp,gpsvalid
  buttonvalueA := 0
  buttonvalueB := 0
  manual := 0
  analogchanged := TRUE
  gpsvalid := FALSE
  
  yaw := 0
  pitch := 0
  roll := 0
  throttle := 0
  repeat
   !outa[ledpin2]
    
     
    com.tx(lcdport,LCDCMD)
    com.tx(lcdport,LCDCLS)

  ''Check for Error Codes and Transmit and Display
    getradiorxbuffer(@radiorxbuffer)
    getgpsrxbuffer(@gpsrxbuffer)
    if strcomp(util.strtok(gpsrxbuffer,1),RMCCON)
      if strcomp(util.strtok(gpsrxbuffer,2),GPSValidCON)
        gpsvalid := TRUE
      else
        gpsvalid := FALSE
        rcerrorcode := 20013 
      
    if strcomp(util.strtok(radiorxbuffer,0),ERRORCON)
      temp := util.strntodec(util.strtok(radiorxbuffer, 1),0)
      if ((1 =< temp) AND (temp =< 10000))
        vherrorcode := temp
      elseif  ((20001 =< temp) AND (temp =< 22000))
        rcerrorcode := temp
      elseif  ((22001 =< temp) AND (temp =< 24000))
        inerrorcode := temp
    if rcerrorcode <> 0
      com.str(radioport,string("$ERROR,"))
      com.dec(radioport,rcerrorcode)
      com.str(radioport,string("*",CR,LF))

      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE2)
      com.str(lcdport,string("ERROR = "))
      com.dec(lcdport,rcerrorcode)

    elseif vherrorcode <> 0
      com.str(radioport,string("$ERROR,"))
      com.dec(radioport,vherrorcode)
      com.str(radioport,string("*",CR,LF))

      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE2)
      com.str(lcdport,string("ERROR = "))
      com.dec(lcdport,vherrorcode)
      
    elseif inerrorcode <> 0
      com.str(radioport,string("$ERROR,"))
      com.dec(radioport,inerrorcode)
      com.str(radioport,string("*",CR,LF))

      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE2)
      com.str(lcdport,string("ERROR = "))
      com.dec(lcdport,inerrorcode)

    else
      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE2)
      com.str(lcdport,string("NO ERROR"))    

    if gpsvalid
      if strcomp(util.strtok(gpsrxbuffer,0),RMCCON) 
        lat1 := util.strdeg2float(lat1str := util.strtok(gpsrxbuffer,3))
        lon1 := util.strdeg2float(lon1str := util.strtok(gpsrxbuffer,5))
        if strcomp(util.strtok(gpsrxbuffer,4),"N")
          'Do Nothing.
        elseif strcomp(util.strtok(gpsrxbuffer,4),"S")
          lat1 := fmath.FNeg(lat1)
        else
          rcerrorcode := 22000
        if strcomp(util.strtok(gpsrxbuffer,6),"E")
          'Do Nothing.
        elseif strcomp(util.strtok(gpsrxbuffer,6),"W")
          lon1 := fmath.FNeg(lat1)
        else
          rcerrorcode := 22000 
    if gpsvalid
      if strcomp(util.strtok(gpsrxbuffer,0),GGACON)
        alt  := util.strdeg2float(altstr := util.strtok(gpsrxbuffer,9))        
                
 ''Acquire Input values
    buttonvalueA := (!digina1 + 2*(!digina2 << 1) + 4*(!digina3 << 2)) 'Add encoderA lines together to get button value
    buttonvalueB := (!diginb1 + 2*(!diginb2 << 1) + 4*(!diginb3 << 2)) 'Add encoderB lines together to get button value
   
    lastyaw := yaw
    lastthrottle := throttle
    lastroll := roll
    lastpitch := pitch
     
    yaw := adc.in(LHAnalog) / 8  'Divide by 8 for scaling, input channel is read up to 4096, we want up to 256
    throttle := adc.in(LVAnalog) / 8
    roll := adc.in(RHAnalog) / 8
    pitch := adc.in(RVAnalog) / 8

  {  'Determine if any of the Analog values have changed.  If none have, don't bother transmitting again.  This reduces
    'Communications load.
    if((yaw <> lastyaw) OR (throttle <> lastthrottle) OR (pitch <> lastpitch) OR (roll <> lastroll))
      analogchanged := TRUE
    else
      analogchanged := FALSE  }
   
    case buttonvalueA
      AButton:  'Manual Control On/Off
        manual := ~manual
        com.str(radioport,string("$CON,"))
        case manual
          0:
            com.str(radioport,string("MANUAL"))

            com.tx(lcdport,LCDCMD)
            com.tx(lcdport,LCDLINE1)
            com.str(lcdport,string("MANUAL Mode"))
          1:
            com.str(radioport,string("AUTO"))

            com.tx(lcdport,LCDCMD)
            com.tx(lcdport,LCDLINE1)
            com.str(lcdport,string("AUTO Mode")) 
        com.str(radioport,string("*",CR,LF))
        waitcnt(waitdelay / 100 + cnt)  'Wait long enough to limit switch debounce 
      BButton: 'Kills Vehicle 
        com.str(radioport,string("$CON,OFF*",CR,LF)) 

        com.tx(lcdport,LCDCMD)
        com.tx(lcdport,LCDLINE1)
        com.str(lcdport,string("VEHICLE POWER OFF"))
      XButton:  'Vehicle navigates to "Home", i.e. Remote Control
        com.str(radioport,string("$WPT,ADD,"))
        com.str(radioport,lat1str)
        com.str(radioport,string(","))
        com.str(radioport,lon1str)
        com.str(radioport,string(","))
        com.str(radioport,altstr)
        com.str(radioport,string("*",CR,LF))
        com.str(radioport,string("$WPT,GO"))
      DUButton: 'Enter TAKEOFF Mode
        com.str(radioport,string("$CON,TAKEOFF*",CR,LF))

        com.tx(lcdport,LCDCMD)
        com.tx(lcdport,LCDLINE1)
        com.str(lcdport,string("TAKING OFF"))
      DRButton:  'Enter HOVER Mode  
        com.str(radioport,string("$CON,HOVER*",CR,LF)) 

        com.tx(lcdport,LCDCMD)
        com.tx(lcdport,LCDLINE1)
        com.str(lcdport,string("HOVERING"))
      DDButton: 'Enter LAND Mode 
        com.str(radioport,string("$CON,LAND*",CR,LF)) 

        com.tx(lcdport,LCDCMD)
        com.tx(lcdport,LCDLINE1)
        com.str(lcdport,string("LANDING"))
      OTHER:  'Recieved no MODE Commands.  Transmit Manual Commands }
   ' if(analogchanged == TRUE) 'Transmit if any analog values have changed.
          com.str(radioport,string("$MAN,YAW,"))
          com.dec(radioport,yaw)
          com.str(radioport,string("*"))
         
          com.str(radioport,string("$MAN,THROTTLE,"))
          com.dec(radioport,throttle)
          com.str(radioport,string("*"))
          waitcnt(waitdelay / 2 + cnt)
         
          com.str(radioport,string("$MAN,ROLL,"))
          com.dec(radioport,roll)
          com.str(radioport,string("*")) 
         
          com.str(radioport,string("$MAN,PITCH,"))
          com.dec(radioport,pitch)
          com.str(radioport,string("*",CR,LF)) 
        'else


    waitcnt(waitdelay * 10 + cnt)


PUB getradiorxbuffer(radiobuffptr) | i,radiobreak
  i := 0
  radiobreak := FALSE                               
  repeat until ((radiobyte := com.rxtime(radioport,10) == 13) OR radiobreak)
    if ((radiobyte == 0) OR (radiobyte == -1))
      radiobreak := TRUE
    if (radiobyte > 31 AND radiobyte < 126)
      byte[radiobuffptr][i] := radiobyte
      i++
    elseif (radiobyte == 42)                   
      i := 0

  byte[radiobuffptr][i++] := 0
PUB getgpsrxbuffer(gpsbuffptr) | i,break
  i := 0
  break := FALSE                              
  repeat until ((gpsbyte := com.rxtime(gpsport,10) == 13))' OR break)
    com.tx(radioport,gpsbyte)
    if ((gpsbyte == 0) OR gpsbyte == -1)
      break := TRUE
    if (gpsbyte > 31 AND gpsbyte < 126)
      byte[gpsbuffptr][i] := gpsbyte
      i++
    elseif (gpsbyte == 42)
      i := 0

  byte[gpsbuffptr][i++] := 0


DAT
  ERRORCON byte "ERROR",0
  RMCCON byte "GPRMC",0
  GGACON byte "GPGGA",0
  GPSValidCON byte "V",0       
  