'' *****************************
'' GPS routines
''  (c) 2007 Perry James Mole
''  pjm@ridge-communications.ca
'' *****************************

' PVH Comment - Excellent small GPS reader routines.
' $GPRMC  Recommended minimum data                 ie: $GPRMC,081836,A,3751.6565,S,14507.3654,E,000.0,360.0,130998,011.3,E*62
' $GPGGA  GPS Fix Data                             ie: $GPGGA,170834,4124.8963,N,08151.6838,W,1,05,1.5,280.2,M,-34.0,M,,,*75
' $PGRMZ  eTrex proprietary barametric altitude ft ie: $PGRMZ,453,f,2*18

CON

  CR = 13                                               ' ASCII <CR>
  LF = 10                                               ' ASCII <LF>
  asterickCON = 42                                      ' ASCII "*"                        
  serXmit   = 0                                         ' Serial Transmit on mouse
  serRecv   = 1                                         ' Serial Receive  on mouse
  
VAR  
   long stack[10] 
   byte GPRMCb[68],GPGGAb[80],PGRMZb[40]   
   long GPRMCa[20],GPGGAa[20],PGRMZa[20]
   byte MANb[20]
   long MANa[4]

   byte CONb[20] 
   long CONa[4]

   byte NETb[20]
   long NETa[4]

   byte ERRb[20]
   long ERRa[4]
   

   byte buff[80],Rx',cksum
   long cog,cptr,ptr,arg,j
   long Null[1]
   
OBJ
  uart :  "FullDuplexSerial"

PUB start(comrx,comtx,comMode,comBaudRate) : okay

'' Starts uart object (at baud specified) in a cog
'' -- returns false if no cog available

  okay := uart.start(comrx,comtx,comMode,comBaudRate)
  return cog := cognew(readsentence,@stack) + 1 
PUB dec(temp)
  uart.dec(temp)

PUB str(temp)
  uart.str(temp)
PUB tx(temp)
  uart.tx(temp)
PUB stop
  cogstop(cog~ - 1)
  uart.stop

PUB readsentence
  Null[0] := 0
  repeat
   longfill(buff,20,0)
   repeat while Rx <>= "$"      ' wait for the $ to insure we are starting with
     Rx := uart.rx              '   a complete NMEA sentence 
   cptr := 0

   repeat while Rx <>= CR       '  continue to collect data until the end of the NMEA sentence 
     Rx := uart.rx              '  get character from Rx Buffer
     if Rx == ","
       buff[cptr++] := 0    '  If "," replace the character with 0
     elseif Rx == "*"
       buff[cptr++] := 0
     else
       buff[cptr++] := Rx   '  else save the character   
   
   if buff[2] == "G"             
     if buff[3] == "G"            
       if buff[4] == "A"            
           copy_buffer(@GPGGAb, @GPGGAa)

   if buff[2] == "R"             
     if buff[3] == "M"            
       if buff[4] == "C"           
           copy_buffer(@GPRMCb, @GPRMCa)
                   
   if buff[0] == "P"
    if buff[1] == "G"  
     if buff[2] == "R"
      if buff[3] == "M"  
       if buff[4] == "Z"
           copy_buffer(@PGRMZb, @PGRMZa)

   if buff[0] == "M"
     if buff[1] == "A"
       if buff[2] == "N"
         copy_buffer(@MANb, @MANa)

   if buff[0] == "C"
     if buff[1] == "O"
       if buff[2] == "N"
         copy_buffer(@CONb, @CONa)

   if buff[0] == "N"
     if buff[1] == "E"
       if buff[2] == "T"
         copy_buffer(@NETb,@NETa)

   if buff[0] == "E"
     if buff[1] == "R"
       if buff[2] == "R"
         copy_buffer(@ERRb,@ERRa)

                
pub copy_buffer ( buffer,args)
         bytemove(buffer,@buff,cptr) '  copy received data to buffer
         ptr := buffer
         arg := 0
         repeat j from 0 to 78           ' build array of pointers
          if byte[ptr] == 0               ' to each
             if byte[ptr+1] == 0           ' record
                long[args][arg] := Null     ' in 
             else                            ' the
                long[args][arg] := ptr+1     ' data buffer
             arg++
          ptr++
        
          
' now we just need to return the pointer to the desired record

pub err_msg
  return ERRa[0]
pub err_size| packetsize

  packetsize := 6 + strsize(NETa[0])
  return packetsize
pub err_packetsize
  return ERRa[1]            
pub man_pitch
   return MANa[0]  
pub man_roll
   return MANa[1]

pub man_yaw
   return MANa[2]

pub man_throttle    
  return MANa[3]

pub man_size| packetsize

  packetsize := 9 + strsize(MANa[0]) + strsize(MANa[1]) + strsize(MANa[2]) + strsize(MANa[3])
  return packetsize
pub man_packetsize
  return MANa[4]             

pub man_altitude
   return PGRMZa[0]

pub con_mode            
  return CONa[0]  
pub con_size| packetsize

  packetsize := 6 + strsize(CONa[0])
  return packetsize
pub con_packetsize
  return CONa[1]

pub net_query
  return NETa[0]
pub net_size| packetsize

  packetsize := 6 + strsize(NETa[0])
  return packetsize
pub net_packetsize
  return NETa[1]
  
   
pub valid
   return GPRMCa[1]
      
pub speed
   return GPRMCa[6]

pub heading
   return GPRMCa[7]
   
pub date
   return GPRMCa[8]
    
pub GPSaltitude
   return GPGGAa[8]

pub time
   return GPGGAa[0]

pub latitude
   return GPGGAa[1]
    
pub N_S
   return GPGGAa[2]
     
pub longitude
   return GPGGAa[3]
    
pub E_W
   return GPGGAa[4]

pub satellites
   return GPGGAa[6]
    
pub hdop
   return GPGGAa[7]
pub magn
  return GPRMCa[9]
   
'pub vdop
'   return GPGSAa[14] 