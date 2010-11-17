
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

  DEC      =  %000_000_000_0_0_000000_01010
  CHAR4    =  %000_000_000_0_0_000100_00000
  CHAR3    =  %000_000_000_0_0_000011_00000
  DEC3     =  DEC+CHAR3

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
  str:          "STRINGS"
    
PUB init | i,j,sum, tempstr1,temp1,tempstr2              
''DPG 28-June-09

 
  cogsused := 0

  dira[ledpinstart..ledpinstop]~~  'Make all LED Pins outputs                    
  outa[ledpinstart..ledpinstop] := TRUE


  ''Initialize UART's



  if radio.start(radiorx, radiotx, radiomode, radiobaudrate)
    outa[ledpinstart + 0] := false  
    cogsused += 1 'Should be 1
  


  if com.start(comrx, comtx, radiomode, radiobaudrate)
    outa[ledpinstart + 1] := false 
    cogsused += 1 'Should be 1
   
  num.Init



  waitcnt(3*clkfreq + cnt) ' Wait 3 seconds for XBee to Power UP
  outa[ledpinstart..ledpinstop] := true

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

PUB main | temp,temp2,tempstr1,tempstr2,tempstr
{
$SEN,ACC,0,1,2*
$SEN,CMP,0*
$SEN,ULT,0,1,2,3,4*
$SEN,GYR,0,1*
$SEN,ENC,0,1,2,3*
$SEN,ALT,123*
$SEN,INU,0,1,2,3,4,5*
$SEN,GPS,0.0,1.1,2.2*
}
  temp := 0
  {repeat
    led
    temp++
    tempstr := num.ToStr(temp,DEC)
    tempstr := str.Combine(tempstr, tempstr)
    com.str(tempstr)
    com.tx(13)
    waitcnt(clkfreq/100 + cnt)
 }
  repeat
    led
    temp := temp + 1
    if temp > 255
      temp := 0
    
   'Simulate Sensor Data

   ''$SEN,CMP,0*
   tempstr1 := string("$SEN,CMP,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr :=  str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13) 

   ''$SEN,ENC,0,1,2,3*
   tempstr1 := string("$SEN,ENC,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr :=  str.Combine(tempstr1, tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)   

   ''$STA,POWMV,255*
   tempstr1 := string("$STA,POWMV,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$STA,POW5V,255*
   tempstr1 := string("$STA,POW5V,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$STA,POWMC,255*
   tempstr1 := string("$STA,POWMC,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$SEN,ULT,0,1,2,3,4*
   tempstr1 := string("$SEN,ULT,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr :=  str.Combine(tempstr1, tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string(","))
   tempstr :=  str.Combine(tempstr,tempstr2)
   tempstr :=  str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$STA,DIST,255*
   tempstr1 := string("$STA,DIST,")
   tempstr2 := num.ToStr(temp,DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)                     
      
   ''$STA,BEAR,255*
   tempstr1 := string("$STA,BEAR,")
   tempstr2 := num.ToStr((255-temp),DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$STA,ALT,255*
   tempstr1 := string("$STA,ALT,")
   tempstr2 := num.ToStr((255-temp),DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)

   ''$ERROR,12345*
   tempstr1 := string("$ERR,")
   tempstr2 := num.ToStr((temp*temp),DEC)
   tempstr := str.Combine(tempstr1,tempstr2)
   tempstr := str.Combine(tempstr,string("*"))
   radio.str(tempstr)
   temp2 := strsize(tempstr)
   radio.dec(temp2)
   radio.tx(13)   
     
   if temp < 10
    ''$STA,GPSNOFIX*
     tempstr := string("$STA,GPSNOFIX*")
     radio.str(tempstr)
     temp2 := strsize(tempstr)
     radio.dec(temp2)
     radio.tx(13)
    ''$STA,INUNOFIX* 
     tempstr := string("$STA,INUNOFIX*")
     radio.str(tempstr)
     temp2 := strsize(tempstr)
     radio.dec(temp2)
     radio.tx(13)
   else

    ''$SEN,GPS,0.0,1.1,2.2* 
    tempstr1 := string("$SEN,GPS,")
    temp2 := temp * 100.00
    temp2 := 35.0 + temp
    tempstr2 := strconv.FloatToString(temp2)
    tempstr := str.Combine(tempstr1,tempstr2)
    tempstr := str.Combine(tempstr,string(","))
    temp2 := -88.0 + temp
    tempstr2 := strconv.FloatToString(temp2)
    tempstr := str.Combine(tempstr,tempstr2)
    tempstr := str.Combine(tempstr,string(","))
    tempstr2 := num.ToStr(temp,DEC)
    tempstr := str.Combine(tempstr,tempstr2)
    tempstr := str.Combine(tempstr,string("*"))
    radio.str(tempstr)
    temp2 := strsize(tempstr)
    radio.dec(temp2)
    radio.tx(13)

    
    ''$SEN,INU,0,1,2,3,4,5* 
    tempstr1 := string("$SEN,INU,")
    tempstr2 := num.ToStr(temp,DEC)
    tempstr :=  str.Combine(tempstr1, tempstr2)
    tempstr :=  str.Combine(tempstr,string(","))
    tempstr :=  str.Combine(tempstr,tempstr2)
    tempstr :=  str.Combine(tempstr,string(","))
    tempstr :=  str.Combine(tempstr,tempstr2)
    tempstr :=  str.Combine(tempstr,string(","))
    tempstr :=  str.Combine(tempstr,tempstr2)
    tempstr :=  str.Combine(tempstr,string(","))
    tempstr :=  str.Combine(tempstr,tempstr2)
    tempstr :=  str.Combine(tempstr,string(","))
    tempstr :=  str.Combine(tempstr,tempstr2)
    tempstr :=  str.Combine(tempstr,string("*"))
    radio.str(tempstr)
    temp2 := strsize(tempstr)
    radio.dec(temp2)
    radio.tx(13)   
      

   


   waitcnt(clkfreq/100 + cnt)
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
  