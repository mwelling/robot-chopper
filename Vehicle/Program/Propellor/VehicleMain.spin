{{
Tasks:
-Check for Compatibility with Remote Control Package .1
-Write Code for RGB Indicators
Done:
-Write Code for Error Code generation 
-Write Code for Multi-UART
-Write Code for Non-JAUS Functionality
-Write Code for motor outputs
-Write Code for Encoders
-Write Code for Ping Sensors
{
Operation of Vehicle:
LED's:
LED 1 Solid On during Initialization then Off
LED 1 Solid On during Error Condition after Initialization
LED 2 Blink during Maual Operation
}
{{
DATE:  25-June-2010
DPG:   Started working on Kalman Filter implementation
DATE:  20-June-2010
DPG:   Started work on Phase 2 Program
DATE:  14-June-10
DPG:   Wrote code in for Network Initialization.     
DATE:  12-June-10
DPG:   Had to Re-write a lot of code to work with Phase 1 requirements.
DATE:  29-March-10
DPG:   Corrected some code for errors in Project Phase schedule interpretation.

DATE:  1-Jan-10
DPG:   Worked on Phase 2 Mode.
DATE:  9-July-09
DPG:   Started working on RGB Indicators.  Added function to PWM Object to be able to set duty cycle percentage
as required for RGB Indicators.
DATE:  8-July-09
DPG:   Implemented Multi-UART.  Added in Error Code Generation.  Started to add in RGB Indicators, using PWM's.
Note:  Important to coerce motor PWM values to proper ranges outside of PWM object, due to RGB LED's
requiring full pulse width modulation. 
DATE:  5-July-09
DPG:   Added in Ping support.
DATE:  3-July-09
DPG:   Added in Encoder support.
DATE:  1-July-09
DPG:   Added in motor output calculations, Non-JAUS Functionality, mode selection and termination control.
DATE:  28-June-09
DPG:   Started working on file.


 
}}
{{
Propellor Cog Usage:
Cog 1:  Main Program/Ping
Cog 2:  Radio/SOM Board Communication
Cog 3:  PWM
Cog 4:  Encoder
Cog 5:  Floating Point Processor          

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

'Proto-Board Constants
  ledpinstart = 16
  ledpinstop = 25
  
' Pin Names
  PINNOTUSED = -1
              
  somrx = 31
  somtx = 30

  somPort = 1
  somBaudRate = 9600
  somMode = %0000
  comselect = 26
  
  radiorx = 1
  radiotx = 0
  radioPort = 0
  radioBaudRate = 9600
  radioMode = %0000

  motor1 = 2
  motor2 = 3
  motor3 = 4
  motor4 = 5

  enc1a = 6
  enc1b = 7
  enc2a = 8
  enc2b = 9
  enc3a = 10
  enc3b = 11
  enc4a = 12
  enc4b = 13


  adccs = 14
  adcdio = 15
  adcclk = 16
  
  {ping1 = 14
  ping2 = 15
  ping3 = 16
  ping4 = 17
  ping5 = 18
  

  rgbred = 21
  rgbgreen = 22
  rgbblue = 23 }

  gpsrx = 27 
  GpsBaudRate = 57600
  GpsMode = %0000
  gpsPort = 2
   
  {ledpin1 = 30
  ledpin2 = 31  }

'MCP3208 Definitions
  adcmode = %0000000011111111
  xAxis = 0
  YAxis = 1
  zAxis = 2
  Vref = 3
  yRate = 4
  xRate = 5
  supply = 6

'Kalman Filter Definitions  
  PitchKF = 0
  RollKF = 1

'Mode Definitions  
  manualmode = 0
  hovermode = 1
  takeoffmode = 2
  landmode = 3

'Motor PWM Constants
  neutral1 = 1500
  neutral2 = 1500
  neutral3 = 1500
  neutral4 = 1500

'Motor Encoder Constants
  enc1 = 1
  enc2 = 2
  enc3 = 3
  enc4 = 4

'ASCII Definitions
  CR = 13
  LF = 10
  period = 46
  periodCON = 46
  commaCON =  44
  asterickCON = 42
  minuscon = 45
' Timing
  waitdelay = 10_000

'LED Definitions
  LEDON = false
  LEDOFF = true
'CON Mode Definitions
  PRIMARY = 0
  SECONDARY = 1
  TAKEOFF = 2
  HOVER = 3
  LAND = 4   
  OFF = 5
  MANUAL = 6
  AUTO = 7
  RESET = 8

'NET Mode Definitions
  NETACK = 1
  NETNCK = 2
  NETTEST = 3

VAR

'Kalman Filter Variables
  long stack0[120]

  ' Array of ADC readings ... Possable of 8 channels from MCP3208
  long tiltReadings[8]
  long a2tan_angle[2]
  long totalRev

  ' 0'ing values
  long yRate0
  long xRate0  
  long Axis0

  byte cog

'Program Variables
  long stack[9]
  long dist                                 
  byte rxinit,somrxbyte

  byte somrxbuffer[100]
  byte radiorxbuffer[100]
  byte radiorxbyte

  long dist1
  long dist2
  long dist3
  long dist4
  long dist5

  'Motor Control Variables
  byte pitch
  byte roll
  byte yaw
  byte throttle

  byte motor_1
  byte motor_2
  byte motor_3
  byte motor_4

  byte motorout[4]
  long motorspeed[4]
  long OMEGA_cur[4]
  long OMEGA_set[4]
  long OMEGA_sum[4]
  long OMEGA_err[4]
  byte Kp[4]
  byte Ki[4]
  byte Kd[4]
  byte Hb[4]
  

  byte con_mode
  byte net_mode
  byte networkvalid
  
  long lat1
  long lat2
  long lon1
  long lon2

  'Color Variables

  byte red[3]
  byte green[3]
  byte blue[3]
  byte orange[3]
  byte yellow[3]
  byte purple[3]
  byte white[3]
  
  long cogsused
  long rcerrorcode
  long vherrorcode

  byte ledcount
  byte leddir
  
OBJ
  'com:          "pcFullDuplexSerial4FC"   '4-Port uart
  'fmath:        "DynamicMathLib"   'floating point
  'util:         "Util.spin"                            
  strconv:      "FloatString"
  pwm:          "Servo32v3"
  encoder:      "Quadrature_Encoder"
  adc:          "MCP3208"
  str:          "STRINGS"
  num:          "Numbers"
  cp:           "CommProtocolDriver"
  fMath         :               "Float32Full"
  KF[2]         :               "KalmanFilter"  
PUB init | i,j,sum, temp,net_sizeerror,tempstr
    
  cogsused := 0
  rcerrorcode := 0
  vherrorcode := 0
  

  definecolors  'Setup Color Parameters for RGB Indicator(s)                  
  '!outa[ledpin1]
  waitcnt(3*clkfreq + cnt) ' Wait 3 seconds for XBee to Power UP
  'dira[ledpin1]~~
  'dira[ledpin2]~~
  dira[ledpinstart..ledpinstop]~~  'Make all LED Pins outputs                    
  outa[ledpinstart..ledpinstop] := LEDOFF
  dira[comselect]~~
  outa[comselect] := con_mode := SECONDARY

  if con_mode == PRIMARY
    if  cp.start(radiorx,radiotx,somMode,somBaudRate)
      cogsused++ 'Should be 1
      outa[ledpinstart + cogsused-1] := LEDON 
      cogsused++ 'Should be 2 
      outa[ledpinstart + cogsused-1] := LEDON 
      
    else         '
      vherrorcode := 2001
  elseif con_mode == SECONDARY
    if cp.start(somrx,somtx,somMode,somBaudRate)
      cogsused++ 'Should be 1
      outa[ledpinstart + cogsused-1] := LEDON 
      cogsused++ 'Should be 2 
      outa[ledpinstart + cogsused-1] := LEDON 
    else
      vherrorcode := 2001 

  if encoder.Start(enc1a, 4, 0, @motorspeed)
    cogsused++ 'Should be 3
    outa[ledpinstart + cogsused-1] := LEDON
          
  if pwm.start
    cogsused++ 'Should be 4
    outa[ledpinstart + cogsused-1] := LEDON
    'Send Neutral to ESC's for 1 second
    pwm.Set(motor1, neutral1)
    pwm.Set(motor2, neutral2)
    pwm.Set(motor3, neutral3)
    pwm.Set(motor4, neutral4)
  else
    vherrorcode := 2002

  if KFstart(adccs,adcdio,adcclk)
    cogsused++  'Should be 5
    outa[ledpinstart + cogsused-1] := LEDON 
    cogsused++  'Should be 6
    outa[ledpinstart + cogsused-1] := LEDON
  else
    vherrorcode := 2005    
  

  waitcnt(clkfreq * 3 + cnt)  
  if cogsused <> 6
    vherrorcode := 2008

  outa[ledpinstart..ledpinstop] := LEDOFF
  'com.str(radioPort,string("Ready!"))

  'Ensure Valid Network is created.
  networkvalid := 1
  repeat until networkvalid == 1
    net_sizeerror := cp.net_size - num.fromstr(cp.net_packetsize,num#DEC)
    'if (net_sizeerror == 0)'Check if there is a Packet Sentence Error
      !outa[ledpinstart]
        if strcomp(cp.net_query,@TESTNET)
          outa[ledpinstart] := LEDON
          net_mode := NETTEST
          tempstr := string("$NET,ACK*")
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)
          net_mode := NETACK
          repeat until networkvalid == 1
            !outa[ledpinstart + 1]
            if strcomp(cp.net_query,@ACKNET)
              networkvalid := 1
            else
              tempstr := string("$NET,ACK*")
              temp := strsize(tempstr)
              tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
              cp.str(tempstr)
              networkvalid := 0
            waitcnt(clkfreq/10 + cnt)
        else
          tempstr := string("$NET,NCK*")
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)
          networkvalid := 0
        waitcnt(clkfreq/10 + cnt)
  i:= 0
  
  if networkvalid
    outa[ledpinstart..ledpinstop] := LEDOFF
    repeat until i == (ledpinstop-ledpinstart+1)
      outa[ledpinstart + i] := LEDON
      i++
      waitcnt(clkfreq/10 + cnt)   
    
  Phase1Mode
  'Phase2Mode


PUB Phase1Mode | dt,j,i,mode_changed,lastmode, man_sizeerror, con_sizeerror,net_sizeerror,tempstr,temp,last_netmode,curtime,lasttime
'Direct Control over Motors, Propeller is primary Controller
  pitch := yaw := roll := throttle := 127

  motor_1 := 127
  motor_2 := 127
  motor_3 := 127
  motor_4 := 127
  mode_changed := 0
  j := 0
  repeat until j == 3
     motorout[j] := 127
     j++
  
  curtime := lasttime := cnt
  lastmode := 0
  repeat
   curtime := cnt  
   led
       dt := fMath.FDiv(fMath.FFloat(curtime-lastTime), fMath.FFloat(clkfreq))
       {cp.str(strconv.FloatToString(dt))
       cp.tx(13)}
    if networkvalid 
      ''Check for Error Codes and Transmit to SOM Board
         if vherrorcode == 0  'No Error
            'pwm.setperc(rgbred,green[0])
           ' pwm.setperc(rgbgreen,green[1])
           'pwm.setperc(rgbblue,green[2])
         else
           tempstr := str.combine(string("$ERROR,"),num.ToStr(vherrorcode,num#DEC)) 
           tempstr := str.combine(tempstr,string("*"))
           temp := strsize(tempstr)
           tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
           cp.str(tempstr) 
      ''Acquire Motor Command values
       
        man_sizeerror := cp.man_size - num.fromstr(cp.man_packetsize,num#DEC)
        con_sizeerror := cp.con_size - num.fromstr(cp.con_packetsize,num#DEC)
        net_sizeerror := cp.net_size - num.fromstr(cp.net_packetsize,num#DEC)

        'cp.str(gps.valid)
         
         if (man_sizeerror == 0)'Check if there is a Packet Sentence Error
           
           pitch := num.fromstr(cp.man_pitch,num#DEC)
           roll := num.fromstr(cp.man_roll,num#DEC) 
           yaw := num.fromstr(cp.man_yaw,num#DEC)
           throttle :=  num.fromstr(cp.man_throttle,num#DEC)
           motorout[0] := 0 #> ((pitch - 127)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255 
           motorout[1] := 0 #>((roll - 127)/2  + (127 - yaw)/2  + (throttle + 127)/2) <# 255
           motorout[2] := 0 #>((127 - pitch)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255
           motorout[3] := 0 #>((127 - roll)/2  + (127 - yaw)/2  + (throttle + 127)/2) <# 255
       
         if (con_sizeerror == 0) 'Check if there is a Packet Sentence Error   
           if strcomp(cp.con_mode,@TAKEOFFCON)
             con_mode := TAKEOFF       
           elseif strcomp(cp.con_mode,@HOVERCON)
             con_mode := HOVER    
           elseif strcomp(cp.con_mode,@LANDCON)
             con_mode := LAND 
           elseif strcomp(cp.con_mode,@OFFCON)
             con_mode := OFF
           elseif strcomp(cp.con_mode,@PRIMARYCON)
             con_mode := PRIMARY
           elseif strcomp(cp.con_mode,@SECONDARYCON)
             con_mode := SECONDARY
           elseif strcomp(cp.con_mode,@AUTOCON)
             con_mode := AUTO
           elseif strcomp(cp.con_mode,@MANUALCON)
             con_mode := MANUAL
           elseif strcomp(cp.con_mode,@RESETCON)
             con_mode := RESET
             
           if con_mode <> lastmode 
             mode_changed := 1
           else
             mode_changed := 0

        tempstr := string("$MOTOR,") 
        tempstr := str.combine(tempstr,num.ToStr(motorout[0],num#DEC))
        tempstr := str.combine(tempstr,string(","))
        tempstr := str.combine(tempstr,num.ToStr(motorout[1],num#DEC))
        tempstr := str.combine(tempstr,string(","))
        tempstr := str.combine(tempstr,num.ToStr(motorout[2],num#DEC))
        tempstr := str.combine(tempstr,string(","))
        tempstr := str.combine(tempstr,num.ToStr(motorout[3],num#DEC))
        tempstr := str.combine(tempstr,string("*"))
        temp := strsize(tempstr)
        tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
        cp.str(tempstr)
        cp.tx(13)
       
         if mode_changed == 1
           ''Mode Has Changed.  Write Mode Code Here
           cp.str(cp.con_mode)
           case con_mode
             TAKEOFF:
               takeoff_mode
             HOVER:
             LAND:
             OFF:
               off_mode         
             PRIMARY:
               outa[comselect] := PRIMARY
             SECONDARY:
               outa[comselect] := SECONDARY                   
             OTHER:                        
        lastmode := con_mode                      
       
             {
           pwm.set(motor1,neutral1 + (2 * motor_1))
           pwm.set(motor2,neutral2 + (2 * motor_2))
           pwm.set(motor3,neutral3 + (2 * motor_3))
           pwm.set(motor4,neutral4 + (2 * motor_4))    }

  
        i := 0
        if strcomp(cp.net_query,@IDNET)
          tempstr := string("$NET,ID,")
          tempstr := str.combine(tempstr,@NETWORKID)
          tempstr := str.combine(tempstr,string("*"))
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)
        'If a Network Check is asked for, respond with a 3-way handshake
        if strcomp(cp.net_query,@TESTNET)
          outa[ledpinstart..ledpinstop] := true
          networkvalid := 0
          outa[ledpinstart] := false
          net_mode := NETTEST
          tempstr := string("$NET,ACK*")
          temp := strsize(tempstr)
          tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
          cp.str(tempstr)
          net_mode := NETACK
          repeat until networkvalid == 1
            !outa[ledpinstart + 1]
            if strcomp(cp.net_query,@ACKNET)
              networkvalid := 1
            else
              tempstr := string("$NET,ACK*")
              temp := strsize(tempstr)
              tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
              cp.str(tempstr)
              networkvalid := 0
            waitcnt(clkfreq/10 + cnt)
          if networkvalid
         outa[ledpinstart..ledpinstop] := TRUE
         repeat until i == (ledpinstop-ledpinstart+1)
           outa[ledpinstart + i] := FALSE
           i++
           waitcnt(clkfreq/10 + cnt)          

    lasttime := curtime 
    waitcnt(clkfreq/1000 + cnt)


PUB led
'Cylon Mode ;) 
    if (ledcount == 0)
      leddir := 1
    elseif (ledcount == 9)
      leddir := -1
 
   outa[ledpinstart + ledcount] := LEDOFF 
   ledcount += leddir
   outa[ledpinstart + ledcount] := LEDON                 

PUB Phase2Mode | dt,i,j,mode_changed,lastmode, man_sizeerror, con_sizeerror,net_sizeerror,inu_sizeerror,tempstr,temp,last_netmode,curtime,lasttime
 
'Control over motors using PID Control, SOM is Primary controller

    j := 0 
    repeat until j == 4
      OMEGA_cur[j] := 0
      OMEGA_set[j] := 0
      OMEGA_sum[j] := 0
      OMEGA_sum[j] := 0
      Kp[j] := 1
      Ki[j] := 1
      Kd[j] := 1
      Hb[j] := 1
      motorout[j] := 127
      j++



      
  pitch := yaw := roll := throttle := 127
  mode_changed := 0

  
  lastmode := 0
  lasttime := cnt
  repeat
       
       dt := fMath.FDiv(fMath.FFloat(curtime-lastTime), fMath.FFloat(clkfreq))
       cp.str(strconv.FloatToString(dt))
       cp.tx(13)
       led

    ''Check for Error Codes and Transmit to SOM Board
       if vherrorcode == 0  'No Error
          'pwm.setperc(rgbred,green[0])
         ' pwm.setperc(rgbgreen,green[1])
         'pwm.setperc(rgbblue,green[2])
       else
         tempstr := str.combine(string("$ERROR,"),num.ToStr(vherrorcode,num#DEC)) 
         tempstr := str.combine(tempstr,string("*"))
         temp := strsize(tempstr)
         tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
         cp.str(tempstr) 
    ''Acquire Motor Command values
     
      man_sizeerror := cp.man_size - num.fromstr(cp.man_packetsize,num#DEC)
      con_sizeerror := cp.con_size - num.fromstr(cp.con_packetsize,num#DEC)
      net_sizeerror := cp.net_size - num.fromstr(cp.net_packetsize,num#DEC)
      'inu_sizeerror := cp.inu_size - num.fromstr(cp.inu_packetsize,num#DEC)
     
      'cp.str(gps.valid)
   ''INU values sent from Primary Controller       
       if ((man_sizeerror == 0) & (inu_sizeerror == 0))'Check if there is a Packet Sentence Error

         throttle :=  num.fromstr(cp.man_throttle,num#DEC)
         pitch := num.fromstr(cp.inu_pitch,num#DEC)
         roll := num.fromstr(cp.inu_roll,num#DEC)
         yaw := num.fromstr(cp.inu_yaw,num#DEC)  

   ''INU values from Double Kalman Filter       
     'pitch := KF[PitchKF].get_angle
     'roll  := KF[RollKF].get_angle
   ''PID Control
       j := 0
       repeat until j == 4
         encoder.readdelta(motorspeed[j])
         OMEGA_cur[j] := motorspeed[j]
         j++

       OMEGA_set[0] := Hb[0] * (0 #> ((pitch - 127)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255)
       OMEGA_set[1] := Hb[1] * (0 #>((roll - 127)/2  + (127 - yaw)/2  + (throttle + 127)/2) <# 255)
       OMEGA_set[2] := Hb[2] * (0 #>((127 - pitch)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255)
       OMEGA_set[3] := Hb[3] * (0 #>((127 - roll)/2  + (127 - yaw)/2  + (throttle + 127)/2) <# 255)               

       repeat until j == 4
         OMEGA_err[j] := OMEGA_cur[j] - OMEGA_set[j]
         OMEGA_sum[j] += OMEGA_err[j]
         motorout[j] :=  0 #> (Kp[j]*OMEGA_err[j] + Ki[j] * OMEGA_sum[j] * dt + Kd[j] * OMEGA_err[j] / dt) <# 255
         j++
       
        
       
        
       if (con_sizeerror == 0) 'Check if there is a Packet Sentence Error   
         if strcomp(cp.con_mode,@TAKEOFFCON)
           con_mode := TAKEOFF       
         elseif strcomp(cp.con_mode,@HOVERCON)
           con_mode := HOVER    
         elseif strcomp(cp.con_mode,@LANDCON)
           con_mode := LAND 
         elseif strcomp(cp.con_mode,@OFFCON)
           con_mode := OFF
         elseif strcomp(cp.con_mode,@PRIMARYCON)
           con_mode := PRIMARY
         elseif strcomp(cp.con_mode,@SECONDARYCON)
           con_mode := SECONDARY
         elseif strcomp(cp.con_mode,@AUTOCON)
           con_mode := AUTO
         elseif strcomp(cp.con_mode,@MANUALCON)
           con_mode := MANUAL
         elseif strcomp(cp.con_mode,@RESETCON)
           con_mode := RESET
           
         if con_mode <> lastmode 
           mode_changed := 1
         else
           mode_changed := 0
     
      tempstr := string("$MOTOR")
      j := 0
      repeat until j == 4
         tempstr := str.combine(tempstr,string(","))
         tempstr := str.combine(tempstr,num.ToStr(motorout[j],num#DEC))          
         j++ 
      tempstr := str.combine(tempstr,string("*"))
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
      cp.str(tempstr)
      cp.tx(13)
     
       if mode_changed == 1
         ''Mode Has Changed.  Write Mode Code Here
         cp.str(cp.con_mode)
         case con_mode
           TAKEOFF:
             takeoff_mode
           HOVER:
           LAND:
           OFF:
             off_mode         
           PRIMARY:
             outa[comselect] := PRIMARY
           SECONDARY:
             outa[comselect] := SECONDARY                   
           OTHER:                        
      lastmode := con_mode                      
     
           
         'pwm.set(motor1,neutral1 + (2 * motorout[0]))
         'pwm.set(motor2,neutral2 + (2 * motorout[1]))
         'pwm.set(motor3,neutral3 + (2 * motorout[2]))
         'pwm.set(motor4,neutral4 + (2 * motorout[3]))
     
                    
      i := 0
      if strcomp(cp.net_query,@IDNET)
        tempstr := string("$NET,ID,")
        tempstr := str.combine(tempstr,@NETWORKID)
        tempstr := str.combine(tempstr,string("*"))
        temp := strsize(tempstr)
        tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
        cp.str(tempstr)
      'If a Network Check is asked for, respond with a 3-way handshake
      if strcomp(cp.net_query,@TESTNET)
        outa[ledpinstart..ledpinstop] := true
        networkvalid := 0
        outa[ledpinstart] := false
        net_mode := NETTEST
        tempstr := string("$NET,ACK*")
        temp := strsize(tempstr)
        tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
        cp.str(tempstr)
        net_mode := NETACK
        repeat until networkvalid == 1
          !outa[ledpinstart + 1]
          if strcomp(cp.net_query,@ACKNET)
            networkvalid := 1
          else
            tempstr := string("$NET,ACK*")
            temp := strsize(tempstr)
            tempstr := str.combine(tempstr,num.tostr(temp,num#DEC))
            cp.str(tempstr)
            networkvalid := 0
          waitcnt(clkfreq/10 + cnt)
        if networkvalid
       outa[ledpinstart..ledpinstop] := TRUE
       repeat until i == (ledpinstop-ledpinstart+1)
         outa[ledpinstart + i] := FALSE
         i++
         waitcnt(clkfreq/10 + cnt)          

    lasttime := curtime      
    waitcnt(clkfreq/1000 + cnt)
PUB takeoff_mode | i,j,tempstr,temp
  i := 0
  pitch := roll := yaw := 127
  throttle := 255
  repeat until i == 255 'Max Height
      led
      j := 0
      repeat until j == 3
        motorout[j] := 127
        j++
        
      motorout[0] := 0 #> ((pitch - 127)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255 
      motorout[1] := 0 #>((roll - 127)/2 + (127 - yaw)/2  + (throttle + 127)/2) <# 255
      motorout[2] := 0 #>((127 - pitch)/2 + (yaw - 127)/2 + (throttle + 127)/2) <# 255
      motorout[3] := 0 #>((127 - roll)/2  + (127 - yaw)/2  + (throttle + 127)/2) <# 255        

      pwm.set(motor1,neutral1 + (2 * motorout[0]))
      pwm.set(motor2,neutral2 + (2 * motorout[1]))
      pwm.set(motor3,neutral3 + (2 * motorout[2]))
      pwm.set(motor4,neutral4 + (2 * motorout[3]))

      tempstr := string("$CON,TAKEOFF*") 
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
      cp.str(tempstr)
      throttle := 127 #> --throttle <# 255
      i++
      tempstr := string("$MOTOR,") 
      tempstr := str.combine(tempstr,num.ToStr(motorout[0],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[1],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[2],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[3],num#DEC))
      tempstr := str.combine(tempstr,string("*"))
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
      cp.str(tempstr)
      cp.tx(13)        
      waitcnt(clkfreq/1000 + cnt)
PUB off_mode | i,j,tempstr,temp

  repeat until i == 500
      i++
      led
      j := 0
      repeat until j == 3
        motorout[j] := 127
        j++
  
      pwm.set(motor1,neutral1 + (2 * motorout[0]))
      pwm.set(motor2,neutral2 + (2 * motorout[1]))
      pwm.set(motor3,neutral3 + (2 * motorout[2]))
      pwm.set(motor4,neutral4 + (2 * motorout[3]))
      
      tempstr := string("$CON,OFF*") 
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
      cp.str(tempstr)
      tempstr := string("$MOTOR,") 
      tempstr := str.combine(tempstr,num.ToStr(motorout[0],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[1],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[2],num#DEC))
      tempstr := str.combine(tempstr,string(","))
      tempstr := str.combine(tempstr,num.ToStr(motorout[3],num#DEC))
      tempstr := str.combine(tempstr,string("*"))
      temp := strsize(tempstr)
      tempstr := str.combine(tempstr,num.ToStr(temp,num#DEC))
      cp.str(tempstr)
      cp.tx(13)
      waitcnt(clkfreq/1000 + cnt)
{PUB getsomrxbuffer(rxbuffptr) | i,j

  i := 0                               
  repeat until (somrxbyte := com.rxtime(somport,10)) == 13 
    
    if (somrxbyte > 31 AND somrxbyte < 126)
      byte[rxbuffptr][i] := somrxbyte
      i++
      
    elseif (somrxbyte == 42)
      i := 0

  byte[rxbuffptr][i++] := 0   

PUB getradiorxbuffer(radiorxbuffptr) | i
  i := 0                               
  repeat until (radiorxbyte := com.rxtime(radioPort,10)) == 13  
    if (radiorxbyte > 31 AND radiorxbyte < 126)   
      byte[radiorxbuffptr][i] := radiorxbyte
      i++
    elseif (radiorxbyte == 42)
      i := 0

  byte[radiorxbuffptr][i++] := 0
}
PUB KFstart(CS,DIO,CLK)
  longmove(@CS, @CS, 3)
  return cog := cognew(KFgo, @stack0) + 1
pub KFstop
{{
  Stop the kalman filter, MCP3208 driver and Float driver
}}
  adc.stop
  fMath.stop
  cogstop(cog)
 
    
pri KFgo | lastTime, pidCalcTime, kalmanCalcTime, tilt_jmax, tilt_filter[5], tilt_idx, f1, tfCount, tmpCO, last_time, holdXPos, holdYPos, holdZPos, Normolize, LastA2Tan, holdA2Tan[2]


{{


Main Thread:
─────────────
PRI  go   
    get ADC readings and format them into normat date
    then pass them through a kalman filter:

  
}}
 
  ' Start the ADC chip using 7 of the 8 channels

  adc.Start(adcdio, adcclk, adccs, adcmode)                       
  ' Start the floating point engin.
  fMath.start
  ' Start the Pitch Kalman Filter
  KF[Pitch].start
  ' Start the Roll Kalman Filter
  KF[Roll].start
    
  ' wait a second for some equilibrium
  waitcnt((80_000_000*1) + cnt)

  ' get a few ADC readings for 0'ing later 
  tiltReadings[VRef] := adc.in(VRef)
  tiltReadings[supply] := adc.in(supply)
  yRate0 := adc.in(yRate)
  xRate0 := adc.in(xRate) 
  Axis0 := tiltReadings[supply] / 2 

  ' setup some defaults
  LastA2Tan := 0.0
  totalRev := 0
  
  repeat


    ' X,Y,Z axis readings
    holdXPos := fMath.FFloat(adc.in(xAxis) - 2048)
    holdYPos := fMath.FFloat(adc.in(yAxis) - 2048)
    holdZPos := fMath.FFloat(adc.in(zAxis) - 2048)
     
    'Normolize := fMath.FSqr(fMath.FAdd(fMath.FAdd(fMath.FMul(holdZPos, holdZPos), fMath.FMul(holdXPos, holdXPos)), fMath.FMul(holdYPos, holdYPos)))
     
    tiltReadings[xAxis] := holdXPos 'fMath.FSub(holdXPos, Normolize)
    tiltReadings[yAxis] := holdYPos
    tiltReadings[zAxis] := holdZPos

    a2tan_angle[Pitch] := fMath.Degrees(fMath.ATan2(tiltReadings[yAxis], tiltReadings[zAxis]))   
    a2tan_angle[Roll] := fMath.Degrees(fMath.ATan2(tiltReadings[xAxis], tiltReadings[zAxis]))   

{{

    ┌───────────────────────────────────────────┐ 
    │ Convert gyro rate to deg/sec              │
    │                                           │
    │ My Setup                                  │
    │ 2mV/deg/sec                               │
    │ 500deg/sec                                │
    │                                           │
    │ 0deg/sec=2048                             │
    │ 500deg/sec=4096adu=2048 + 2048            │
    │ each 1deg/sec = 2048/500 = 4.096          │
    │ each 1=1/4.096deg/sec=0.244140625deg/sec  │
    └───────────────────────────────────────────┘


      
}}
    tiltReadings[xRate] := fMath.FMul(fMath.FFloat(adc.in(xRate) - xRate0), 0.24414)
    tiltReadings[yRate] := fMath.FMul(fMath.FFloat(adc.in(yRate) - yRate0), 0.24414)
                                                
    ' Update the Pitch KF
    KF[Pitch].state_update( tiltReadings[xRate] )
    KF[Pitch].kalman_update( a2tan_angle[Pitch] )

    ' Update the Roll KF    
    KF[Roll].state_update( tiltReadings[yRate] )
    KF[Roll].kalman_update( a2tan_angle[Roll] )  
PRI definecolors
  red[0] := 100
  red[1] := 0
  red[2] := 0
  green[0] := 0
  green[1] := 100
  green[2] := 0
  blue[0] := 0
  blue[1] := 0
  blue[2] := 100
DAT
  PITCHCON byte "PITCH",0
  YAWCON   byte "YAW",0
  ROLLCON  byte "ROLL",0
  THROTTLECON byte "THROTTLE",0
  MANCON byte "MAN",0
  TAKEOFFCON byte "TAKEOFF",0
  LANDCON byte "LAND",0
  OFFCON byte "OFF",0
  HOVERCON byte "HOVER",0
  MANUALCON byte "MANUAL",0
  AUTOCON byte "AUTO",0
  RESETCON byte "RESET",0
  BOOTCON byte "BOOT",0
  ACKNET byte "ACK",0
  NCKNET byte "NCK",0
  TESTNET byte "TEST",0
  IDNET byte "ID",0
  PRIMARYCON byte "PRIMARY",0
  SECONDARYCON byte "SECONDARY",0
  NETWORKID byte "VEHICLE-SECONDARY",0
 