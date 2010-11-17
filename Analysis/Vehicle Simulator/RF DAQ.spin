
{{******************************************
* main                                   *
* Author: David Gitz                     *
* Copyright (c) 2008 David Gitz          *
* See end of file for terms of use.      *
******************************************
}}
{{
Tasks:

Done:

}} 
{{
Operation:

Outputs Data in this format:
$TIME,LATITUDE,LONGITUDE,RSSI*

}}
{{
DATE:  21-Nov-09
DPG:   Created Initial File.
}}
{{
COG Usage:
COG 1:  Main Program 
COG 2:  Communications UART
COG 3:  GPS UART
COG 4:  Floating Point Unit
}}
{{

}}
con
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

' Pin Names
  PINNOTUSED = -1
               

  comtx = 30
  comrx = 31

  radiotx = 0
  radiorx = 1

  gpsrx = 27

  xbeepwm = 15

  ledpinstart = 16
  ledpinstop = 25

   radioPort = 0
  radioBaudRate = 115200
  radioMode = %0000

   GpsPort = 2 
  GpsBaudRate = 57600
  GpsMode = %0000

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
  dollarCON = 36
  minuscon = 45
' Timing
  waitdelay = 100_000
                  
var
  long stack[9]
  long dist                                 
  byte rxbyte,rxinit, checksum
  byte radiorxbuffer[50]
  byte gpsrxbuffer[50]
  
  long rssi
  
  long lat1
  long lat2
  long lon1
  long lon2

  byte ledcount
  byte leddir
  long cogsused
  
obj
  radio:         "XBee_Object"                          'Radio uart
  com:           "XBee_Object"
  gps:           "GPS_IO_mini"
  fmath:        "DynamicMathLib"                        'floating point
  util:         "Util.spin"                             'utilities
  strconv:      "FloatString"
  num:          "Numbers"
  readpwm:      "readpwm"
    
PUB init | i,j,sum, tempstr1,temp1,tempstr2              
''DPG 28-June-09

 
  cogsused := 0

  dira[ledpinstart..ledpinstop]~~  'Make all LED Pins outputs                    
  outa[ledpinstart..ledpinstop] := TRUE


  ''Initialize UART's



  if radio.start(radiorx, radiotx, radiomode, radiobaudrate)
    outa[ledpinstart + 0] := false  
    cogsused += 1 'Should be 1
  
  'radio.AT_init

  if com.start(comrx, comtx, radiomode, radiobaudrate)
    outa[ledpinstart + 1] := false 
    cogsused += 1 'Should be 1

  com.str(string("Booting..."))
  radio.str(string("Booting..."))


  if gps.start(gpsrx,GpsMode,GpsBaudRate)
    outa[ledpinstart + 2] := false
    cogsused += 1 'Should be 2           
  '
  '!outa[ledpin1]




  if readpwm.start(xbeepwm)
    outa[ledpinstart + 3] := false       



  '!outa[ledpin1]
  ''Initialize Floating Point
  'if fmath.start
  '  cogsused := 1  'Should be 3
  '!outa[ledpin1]
    
  'fmath.allowfast
  'num.init



  waitcnt(3*clkfreq + cnt) ' Wait 3 seconds for XBee to Power UP
  outa[ledpinstart..ledpinstop] := true
  com.str(string("Ready!"))
  radio.str(string("Ready!"))
  main

    
PUB test1
  repeat
    com.str(string("Hello World"))
    radio.str(string("Hello World"))
    !OUTA[ledpinstart..ledpinstop]
    waitcnt(waitdelay + cnt)
                 

PUB test2 
  ledcount := 0
  repeat
    waitcnt(100*waitdelay + cnt)
    led
    

    


    
     

PUB led
'Cylon Mode ;)
    
    

    if (ledcount == 0)
      leddir := 1
    elseif (ledcount == 9)
      leddir := -1
 
   outa[ledpinstart + ledcount] := true 
   ledcount += leddir
   outa[ledpinstart + ledcount] := false 
 
   


PUB main | temp
  outa[ledpinstart..ledpinstop] := true 
  repeat
   led
   
   'rssi := readpwm.getpwm
   'if rssi > 500
   '    outa[ledpinstart..ledpinstop] := false
   'else
   '     outa[ledpinstart..(ledpinstart+4)] := false 

   'gps.latitude
  ' gps.longitude
   'gps.time



   'if (gps.valid == "V")
      radio.str(string(dollarCON))
      radio.str(string("RSSI"))
      radio.str(string(commaCON))
      radio.str(gps.time)
      radio.str(string(commaCON))
      radio.str(gps.latitude)
      radio.str(string(commaCON))
      radio.str(gps.longitude)
      radio.str(string(commaCON))
      radio.dec(rssi)
      radio.str(string(asterickCON))
      radio.str(string(13,10))

   waitcnt(clkfreq/10 + cnt)
   outa[ledpinstart..ledpinstop] := true 
       
PUB getradiorxbuffer(rxbuffptr) | i
  i := 0                               
  repeat until (rxbyte := radio.rxtime(1) == 13)
    radio.tx(rxbyte)
    if (rxbyte > 31 AND rxbyte < 126)
      byte[rxbuffptr][i] := rxbyte
      i++
    elseif (rxbyte == 42)
      i := 0

  byte[rxbuffptr][i++] := 0

DAT
  ERRORCON byte "ERROR",0
  ACKCON   byte "ACK",0
  NCKCON   byte "NCK",0
  NETCON   byte "NET",0
  TESTCON  byte "TEST",0       
  