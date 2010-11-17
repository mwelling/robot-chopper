{{
Tasks:
-Write Code for UART/JAUS Protocol
-Optional:  Write Code for GPS functionality
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
DATE:  19-June-10
DPG:   Modified code to support comm protocol revisions
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
COG 2:  Radio
COG 3:  LCD UART
COG 4:  ADC
COG 5:  Floating Point Processor
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
  gpsrx = 16

  digina1 = 4
  digina2 = 5
  digina3 = 6


  ADCClock = 10
  ADCData =  11  
  ADCChipSelect = 12
   
  ledpin1 = 1
  ledpin2 = 0

  lcdtx = 14

  radioPort = 0
  radioBaudRate = 115200
  radioMode = %0000

  lcdPort = 1
  lcdBaudRate = 9600
  lcdMode = %0000

  GpsPort = 2 
  GpsBaudRate = 4800
  GpsMode = %0000

'LCD Definitions
  LCDCMD =   $FE
  LCDCLS =   $0F
  LCDLINE1 = $80
  LCDLINE2 = $C0
  
  rcAddr = 0
  vhAddr = 1
  inAddr = 2
  
'ASCII Definitions
  CR = 13
  LF = 10
  period = 46
  periodCON = 46
  commaCON =  44
  asterickCON = 42
  minuscon = 45

'LED Definitions
  ON = false
  OFF = true
' Timing
  waitdelay = 100_000
'XBox 360 Controller Mapping
 'Buttons
 AButton = 0  'A, Enters Manual/Auto Mode
 BButton = 1  'B, Turns off Vehicle
 XButton = 2  'X
 YButton = 3  'Y
 DLButton = 4 'D-Pad Left
 DUButton = 5 'D-Pad Up, Enter TAKEOFF Mode
 DRButton = 6 'D-Pad Right, Enter HOVER Mode
 DDButton = 7 'D-Pad Down, Enter LAND Mode
 
 LBButton = 0 'Left Bumper
 RBButton = 1 'Right Bumper
 LTButton = 2 'Left Thumbstick
 RTButton = 3 'Right Thumbstick
 BKButton = 4 'Back
 STButton = 5 'Start
 
 'Analog
 LHAnalog = 0 'Left Horizontal Stick
 LVAnalog = 1 'Left Vertical Stick
 RHAnalog = 2 'Right Horizontal Stick
 RVAnalog = 3 'Right Vertical Stick 
                  
var
  long stack[9]
  long dist                                 
  byte rxbyte,rxinit, checksum
  byte radiorxbuffer[50]
  byte gpsrxbuffer[50]

  byte networkvalid
  
  byte analogchanged
  byte lastyaw
  byte lastthrottle
  byte lastpitch
  byte lastroll

  long lat1
  long lat2
  long lon1
  long lon2

  byte manual
  long rcerrorcode  'Error Codes for Remote Control 
  long vherrorcode  'Error Codes for Vehicle
  long inerrorcode  'Error Codes for Interface
  long cogsused
  
obj
  com:          "pcFullDuplexSerial4FC"                      'Radio uart
  'fmath:        "DynamicMathLib"                        'floating point
  'util:         "Util.spin"                             'utilities
  adc:          "MCP3208"                               'adc
  strconv:      "FloatString"
  radio:        "XBee_Object"
  num:          "Numbers"
  cp:           "CommProtocolDriver"
  str:          "STRINGS"                      
    
PUB init | i,j,sum, tempstr1,temp1,tempstr2              
''DPG 28-June-09
    
  cogsused := 0
  rcerrorcode := 0
  vherrorcode := 0
  inerrorcode := 0
  dira[ledpin1]~~
  dira[ledpin2]~~
  dira[digina1]~
  dira[digina2]~
  dira[digina3]~                   
  outa[ledpin1] := ON
  outa[ledpin2] := OFF
  waitcnt(3*clkfreq + cnt) ' Wait 3 seconds for XBee to Power UP
  
  
  !outa[ledpin1]
  ''Initialize Radio
  'if radio.Start(radiorx,radiotx,radiomode,radioBaudRate)
  if cp.start(radiorx,radiotx,radiomode,radioBaudRate)
    cogsused += 1 'Should be 1
    cogsused += 1 'Should be 2
    
  else
    rcerrorcode := 20001
  testbutton
  !outa[ledpin1]  
  ''Initialize UART's
  com.init
  'com.AddPort(radioPort,radiorx,radiotx,com#PINNOTUSED,com#PINNOTUSED,com#DEFAULTTHRESHOLD,radioMode,radioBaudRate)
  com.AddPort(lcdPort,com#PINNOTUSED,lcdtx,com#PINNOTUSED,com#PINNOTUSED,com#DEFAULTTHRESHOLD,lcdMode,lcdBaudRate)
  
  if com.start
    cogsused += 1 'Should be 3
  else
    rcerrorcode := 20002
  !outa[ledpin1] 
  
  ''Initialize ADC
  if adc.Start(ADCData, ADCCLock, ADCChipSelect, %00001111)
    cogsused += 1 'Should be 4
  else
    rcerrorcode := 20003
  !outa[ledpin1] 

  ''Initialize Floating Point
  'if fmath.start
  '  cogsused := 1  'Should be 4
  'else
  '  rcerrorcode := 20004

  if cogsused <> 4
    rcerrorcode := 20008 
  !outa[ledpin1]   
  'fmath.allowfast
  'num.init
  
  'radio.AT_Config(string("ATAP 1"))  'Configure XBee as API Mode
  'Test Network
  'networkvalid := true
  if (testnetwork <> 1)
    rcerrorcode := 20020    
   !outa[ledpin1] 
  if (rcerrorcode <> 0)
     outa[ledpin1] := ON
  else
     outa[ledpin1] := OFF

  
  nonjausdatapacketmode
                 
PUB testbutton| buttonvalueA
  buttonvalueA := 0
  repeat
    waitcnt(clkfreq/10 + cnt)
    !outa[ledpin1]
    buttonvalueA := (!ina[digina1] + 2*(!ina[digina2] << 1) + 4*(!ina[digina3] << 2)) 'Add encoderA lines together to get button value
    cp.dec(buttonvalueA)
    cp.tx(CR)
    cp.tx(LF)
     
    
PUB nonjausdatapacketmode | buttonvalueA, buttonvalueB, pitch, roll, yaw, throttle,temp,err_sizeerror,tempstr
  buttonvalueA := 0
  buttonvalueB := 0
  manual := 0
  analogchanged := FALSE
  repeat
    if networkvalid
     !outa[ledpin2]
     com.tx(lcdport,LCDCMD)
     com.tx(lcdport,LCDCLS)
   
   ''Check for Error Codes and Transmit and Display
     err_sizeerror := cp.err_size - num.fromstr(cp.err_packetsize,num#DEC)
     if (err_sizeerror == 0)'Check if there is a Packet Sentence Error
       temp  := num.fromstr(cp.err_msg,num#DEC)
       if ((1 =< temp) AND (temp =< 10000))
         vherrorcode := temp
       elseif  ((20001 =< temp) AND (temp =< 22000))
         rcerrorcode := temp
       elseif  ((22001 =< temp) AND (temp =< 24000))
         inerrorcode := temp
     if rcerrorcode <> 0
       tempstr := string("$ERROR,")
       tempstr := str.combine(tempstr,num.tostr(rcerrorcode,num#DEC))
       tempstr := str.combine(tempstr,string("*"))
       temp := strsize(tempstr)
       tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
       cp.str(tempstr)
   
       com.tx(lcdport,LCDCMD)
       com.tx(lcdport,LCDLINE2)
       com.str(lcdport,string("ERROR = "))
       com.dec(lcdport,rcerrorcode)
   
     elseif vherrorcode <> 0
       tempstr := string("$ERROR,")
       tempstr := str.combine(tempstr,num.tostr(vherrorcode,num#DEC))
       tempstr := str.combine(tempstr,string("*"))
       temp := strsize(tempstr)
       tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
       cp.str(tempstr)
   
       com.tx(lcdport,LCDCMD)
       com.tx(lcdport,LCDLINE2)
       com.str(lcdport,string("ERROR = "))
       com.dec(lcdport,vherrorcode)
       
     elseif inerrorcode <> 0
       tempstr := string("$ERROR,")
       tempstr := str.combine(tempstr,num.tostr(inerrorcode,num#DEC))
       tempstr := str.combine(tempstr,string("*"))
       temp := strsize(tempstr)
       tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
       cp.str(tempstr)
   
       com.tx(lcdport,LCDCMD)
       com.tx(lcdport,LCDLINE2)
       com.str(lcdport,string("ERROR = "))
       com.dec(lcdport,inerrorcode)
   
     else
       com.tx(lcdport,LCDCMD)
       com.tx(lcdport,LCDLINE2)
       com.str(lcdport,string("NO ERROR"))
                 
  ''Acquire Input values
     buttonvalueA := (!ina[digina1] + 2*(!ina[digina2] << 1) + 4*(!ina[digina3] << 2)) 'Add encoderA lines together to get button value
     'buttonvalueB := (!diginb1 + 2*(!diginb2 << 1) + 4*(!diginb3 << 2)) 'Add encoderB lines together to get button value
   
     lastyaw := yaw
     lastthrottle := throttle
     lastroll := roll
     lastpitch := pitch 
     yaw := adc.in(LHAnalog) / 16  'Divide by 16 for scaling, input channel is read up to 4096, we want up to 256
     throttle := adc.in(LVAnalog) / 16
     roll := adc.in(RHAnalog) / 16
     pitch := adc.in(RVAnalog) / 16
   
     'Determine if any of the Analog values have changed.  If none have, don't bother transmitting again.  This reduces
     'Communications load.
     if((yaw <> lastyaw) OR (throttle <> lastthrottle) OR (pitch <> lastpitch) OR (roll <> lastroll))
       analogchanged := TRUE
     else
       analogchanged := FALSE
   
     case buttonvalueA
       AButton:  'Manual Control On/Off
         manual := ~manual
         tempstr := string("$CON,")
         case manual
           0:
             tempstr := str.combine(tempstr,string("MANUAL*")) 
             com.tx(lcdport,LCDCMD)
             com.tx(lcdport,LCDLINE1)
             com.str(lcdport,string("MANUAL Mode"))
           1:
             tempstr := str.combine(tempstr,string("AUTO*"))
             com.tx(lcdport,LCDCMD)
             com.tx(lcdport,LCDLINE1)
             com.str(lcdport,string("AUTO Mode"))
               
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
         cp.str(tempstr)
         waitcnt(waitdelay / 100 + cnt)  'Wait long enough so limit switch debounce 
       BButton: 'Kills Vehicle
         tempstr := string("$CON,OFF*")
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
         cp.str(tempstr)         
   
         com.tx(lcdport,LCDCMD)
         com.tx(lcdport,LCDLINE1)
         com.str(lcdport,string("VEHICLE POWER OFF"))
       DUButton: 'Enter TAKEOFF Mode
         tempstr := string("$CON,TAKEOFF*")
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
         cp.str(tempstr) 
   
         com.tx(lcdport,LCDCMD)
         com.tx(lcdport,LCDLINE1)
         com.str(lcdport,string("TAKING OFF"))
       DRButton:  'Enter HOVER Mode  
         tempstr := string("$CON,HOVER*")
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
         cp.str(tempstr) 
   
         com.tx(lcdport,LCDCMD)
         com.tx(lcdport,LCDLINE1)
         com.str(lcdport,string("HOVERING"))
       DDButton: 'Enter LAND Mode 
         tempstr := string("$CON,LAND*")
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
         cp.str(tempstr) 
   
         com.tx(lcdport,LCDCMD)
         com.tx(lcdport,LCDLINE1)
         com.str(lcdport,string("LANDING"))
       OTHER:  'Recieved no MODE Commands.  Transmit Manual Commands
         if(analogchanged == TRUE) 'Transmit if any analog values have changed.
           tempstr := string("$MAN,") 
           tempstr := str.combine(tempstr,num.tostr(pitch,num#DEC))
           tempstr := str.combine(tempstr,string(","))
           tempstr := str.combine(tempstr,num.tostr(roll,num#DEC))
           tempstr := str.combine(tempstr,string(","))
           tempstr := str.combine(tempstr,num.tostr(yaw,num#DEC))
           tempstr := str.combine(tempstr,string(","))
           tempstr := str.combine(tempstr,num.tostr(throttle,num#DEC))
           tempstr := str.combine(tempstr,string("*"))
           temp := strsize(tempstr)
           tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
           cp.str(tempstr)
         else
           waitcnt(waitdelay / 2 + cnt)
   
     if strcomp(cp.net_query,@TESTNET)
       outa[ledpin1] := ON
       outa[ledpin2] := OFF    
       networkvalid := 0
       outa[ledpin1] := false
       tempstr := string("$NET,ACK*")
       temp := strsize(tempstr)
       tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
       cp.str(tempstr)
       repeat until networkvalid == 1
         !outa[ledpin1]
         
         if strcomp(cp.net_query,@ACKNET)
           networkvalid := 1
           outa[ledpin1] := OFF
         else
           tempstr := string("$NET,ACK*")
           temp := strsize(tempstr)
           tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
           cp.str(tempstr)
           networkvalid := 0
         waitcnt(clkfreq/10 + cnt)
    waitcnt(waitdelay / 2 + cnt)

{PUB testnetworknonjaus | status

  status := FALSE
  'Network Test
  radio.api_str(inAddr,string("$NET,TEST*"))  'Look for Interface
  getradiorxbuffer(@radiorxbuffer)
  if strcomp(util.strtok(radiorxbuffer,1),ACKCON)
      radio.api_str(inAddr,string("$NET,ACK"))
      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE1)
      com.str(lcdport,string("INTERFACE FOUND"))
  else
      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE1)
      com.str(lcdport,string("INTERFACE NOT FOUND"))     
      rcerrorcode := 20011 

  radio.api_str(vhAddr,string("$NET,TEST*"))  'Look for Interface
  getradiorxbuffer(@radiorxbuffer)
  if strcomp(util.strtok(radiorxbuffer,1),ACKCON)
      radio.api_str(inAddr,string("$NET,ACK"))
      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE1)
      com.str(lcdport,string("VEHICLE FOUND"))
  else
      com.tx(lcdport,LCDCMD)
      com.tx(lcdport,LCDLINE1)
      com.str(lcdport,string("VEHICLE NOT FOUND"))     
      rcerrorcode := 20012
      status := TRUE

  return status
}
pub testnetwork| tempstr,temp
  networkvalid := 0
  outa[ledpin1] := ON
  outa[ledpin2] := OFF
  repeat until networkvalid == 1
      !outa[ledpin1]
      tempstr := string("$NET,TEST*")
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
      cp.str(tempstr)
      repeat until networkvalid == 1
        !outa[ledpin1]
        if strcomp(cp.net_query,@ACKNET)
          outa[ledpin1] := OFF
          outa[ledpin2] := ON
          networkvalid := 1
          tempstr := string("$NET,ACK*")
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)

          com.tx(lcdport,LCDCMD)
          com.tx(lcdport,LCDLINE2)
          com.str(lcdport,string("NETWORK OK"))
        else
          !outa[ledpin1]
          tempstr := string("$NET,TEST*")
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)
          com.tx(lcdport,LCDCMD)
          com.tx(lcdport,LCDLINE2)
          com.str(lcdport,string("NETWORK ERROR"))  
        waitcnt(clkfreq/10 + cnt)
      waitcnt(clkfreq/10 + cnt)
  return networkvalid
DAT

'Man Constants
  PITCHCON byte "PITCH",0
  YAWCON   byte "YAW",0
  ROLLCON  byte "ROLL",0
  THROTTLECON byte "THROTTLE",0
'Control Constants
  MANCON byte "MAN",0
  TAKEOFFCON byte "TAKEOFF",0
  LANDCON byte "LAND",0
  OFFCON byte "OFF",0
  HOVERCON byte "HOVER",0
  MANUALCON byte "MANUAL",0
  AUTOCON byte "AUTO",0
  RESETCON byte "RESET",0
  BOOTCON byte "BOOT",0
  PRIMARYCON byte "PRIMARY",0
  SECONDARYCON byte "SECONDARY",0
'Network Constants
  ACKNET byte "ACK",0
  NCKNET byte "NCK",0
  TESTNET byte "TEST",0
  IDNET byte "ID",0
  NETWORKID byte "VEHICLE-SECONDARY",0
'Other Constants
  ERRORCON byte "ERROR",0
  
  
  
  
  
        
  