{{
  *************************************************
  *  XBee Transciever AT-API Object               *
  *  Version 1.1                                  *
  *  Copyright (c) 2007, Martin Hebel             *               
  *  See end of file for terms of use.            *    
  *************************************************
  *       Electronic Systems Technologies         *
  *   Southern Illinois University Carbondale     *
  *           www.siu.edu/~isat/mhebel            *
  *                                               *
  * Questions? Please post on the Propeller forum *
  *       http://forums.parallax.com/forums/      *
  *************************************************



Example code for starting:
' **************************
OBJ 
  XB   : "XBee_Object"       
  Comm : "FullDuplexSerial"  
  Num  : "Numbers"          ' useful for API mode as all data is passed as strings

Pub Start | check
    XB.start(7,6,0,9600)           ' XBee Comms - RX,TX, Mode, Baud
    XB.AT_Init                     ' Initialize for fast AT command use - 5 second delay to perform
    Comm.start(31,30,0,9600)       ' Initialize comms from Prop to PC
    Num.init                       ' Initialize Numbers object

' ****************************

This object supports both AT and API modes.

API mode allow reception via an incoming packet which can contain senders address,
RSSI level for reception, transmission status reports, etc.

API mode also allows data to a unit be performed by defining where to send:
XB.API_TX_str(5,string("Hello 5!"))  ' send string to Addy 5.

To shift XBee into API mode for a default configured unit:
   XB.AT_Config(string("ATAP 1"))

Notes:

This object does not currently use escape-sequences for special characters (11,13,7D,7E),
though I've not seen any issues.

Also, does not yet perform checksum error checking on received API packets nor 64-bit addressing.

This object does support reception of auto DIO/ADC packets (firmware versions 10A2/3)
If using the auto-sending features for DIO/ADC data for the XBee  data is not parsed out -
you'll need to do manually from accepted data.

As data may come in fast and furious, without running in seperate cogs and creating more buffer
passing between them, chances of missing packets is possible if there are heavy transactions, of course,
dependent of what else is going on.  Reception of packets > 100 bytes (multiple payloads) not currently
supported.

Line passing is NOT currently supported.

Please see the XBee manual!

Revisions:
Added XB.API_Array(addr,strptr,number of bytes) to be able to send 0 values in a byte array
(0's were causing grief with the string use)
}}

VAR
  Byte dataSet[120],_RxData[105]
  Long _SrcAddr16, _RxLen
  Byte _RxFlag,_RxIdent, _RxOpt, _RxFrameID, _RxCmd[3], _Status, _FrameID, _API_Ready, _RSSI
  

OBJ
  FDSerial : "FullDuplexSerial"


Pub Start (RXpin, TXPin, Mode, Baud) |Started
{{
   Start serial driver - starts a cog
   returns false if no cog available
  
   mode bit 0 = invert rx
   mode bit 1 = invert tx
   mode bit 2 = open-drain/source tx
   mode bit 3 = ignore tx echo on rx

   Sets XBee for low gaurd time for fast AT Command use
}}

    Started := FDSerial.Start(RXpin, TXpin, Mode, Baud)
    if Started == -1
      return Started
      
    _FrameID := 1

Pub AT_Init
{{                              
    Configure for low guard time for AT mode.
    Requires 5 seconds.  Required if AT mode used.
}}

 delay(3000)               
    str(string("+++"))
    delay(2000)
    rxflush
    str(string("ATGT 3,CN"))
    tx(13)
    delay(500)
    rxFlush
    return 0

PUB Stop
    '' See FullDuplex Serial Documentation
    FDSerial.Stop

PUB RxCheck
    '' See FullDuplex Serial Documentation  
    return (FDSerial.RxCheck)

PUB RxFlush
    '' See FullDuplex Serial Documentation  
    FDSerial.RxFlush
    
PUB Tx (data)
    '' See FullDuplex Serial Documentation
    '' Serial.tx(13)   ' Send byte of data
    '' FOR Transparent (Non-API) MODE USE
    FDSerial.tx(data)

Pub Rx
    '' See FullDuplex Serial Documentation
    '' x := Serial.RX   ' receives a byte of data
    '' FOR Transparent (Non-API) MODE USE
    return (FDSerial.rx)

PUB RxTime(ms)
    '' See FullDuplex Serial Documentation
    '' x:= Serial.RxTime(100)  ' receive byte with 100mS timeout
    '' FOR Transparent (Non-API) MODE USE
    return (FDSerial.RxTime(ms))
    
PUB str(stringptr)
    '' See FullDuplex Serial Documentation
    '' XB.str(String("Hello World"))      ' transmit a string
    '' FOR Transparent (Non-API) MODE USE
    FDSerial.str(stringptr) 

PUB dec(value)
    '' See FullDuplex Serial Documentation
    '' XB.dec(1234)       ' send decimal value as chracters
    '' FOR Transparent (Non-API) MODE USE
    FDSerial.dec(value)

PUB hex(value, digits)
    '' See FullDuplex Serial Documentation
    '' XB.hex(1234,4)      ' send value as hex string for 4 digits
    '' FOR Transparent (Non-API) MODE USE
    FDSerial.hex(value, digits)

PUB bin(value, digits)
    '' See FullDuplex Serial Documentation  
    '' XB.bin(32,4)      ' send value as binary string for 8 digits
    '' FOR Transparent (Non-API) MODE USE
    FDSerial.bin(value, digits)   


PUB RxStr (stringptr) : Value | ptr
{{
  Accepts a string of characters - up to 15 - to be passed by reference
  String acceptance terminates with a carriage return.
  Will accept up to 15 characters before passing back.
  XB.Rxstr(@MyStr)
  XB.str(@MyStr)
  FOR Transparent (Non-API) MODE USE
 }} 
    ptr:=0
    bytefill(@dataSet,0,15)                               
   dataSet[ptr] :=  Rx        
   ptr++                                                  
   repeat while (dataSet[ptr-1] <> 13) and (ptr < 15)       
       dataSet[ptr] :=  RX    
       ptr++
   dataSet[ptr-1]:=0                                         
   byteMove(stringptr,@dataSet,16)  

PUB RxStrTime (ms,stringptr) : Value | ptr, temp
{{
  Accepts a string of characters - up to 15 - to be passed by reference
  Allow timeout value.
  String acceptance terminates with a carriage return.
  Will accept up to 15 characters before passing back.
  XB.RxStrTime(200,@MyStr)
  XB.str(@MyStr)
  FOR Transparent (Non-API) MODE USE
 }}

    ptr:=0
    bytefill(@dataSet,0,100)
    bytefill(stringptr,0,100)                             
   temp :=  RxTime(ms)        
   if temp <> -1
      dataSet[ptr] := temp
      ptr++                                                   
      repeat 100                        
          temp :=  RxTime(ms)    
          if temp == -1
             ptr++
             quit    
          dataSet[ptr] := temp
          ptr++
      dataSet[ptr-1]:=0                                        
      byteMove(stringptr,@dataSet,100)

PUB AT_Config(stringptr)
{{
  Send a configuration string for AT Mode
  XB.AT_Config(string("ATMY 2"))
  May also be used to query
  XB.AT_Config(string("ATMY"))
  FOR Transparent (Non-API) MODE USE
}}
    delay(100)
    str(string("+++"))
    delay(100)
    rxflush
    str(stringptr)
    tx(13)
    str(string("ATCN"))
    tx(13)
    delay(10)

Pub Delay(mS)
'' Delay routing
'' XB.Delay(1000)  ' pause 1 second
  waitcnt(clkfreq/1000 * mS + cnt)

Pub API_Queue (stringptr, val)| Length, chars, csum
{{
 Uses API mode to queue an AT command.
 Commands will not be processed until a non-queud command is sent or
 AC (apply changes) is issued.
 XB.API_Queue(string("DL"),$5) ' Note, value and command are 2 parameters
}}
  
  dataSet[0]   := $7E
  Length := 11                  ' API Ident + FrameID + AT cmd + 4 bytes of data
  dataSet[1] := 0               ' MSB
  dataSet[2] := 08              ' LSB
  dataSet[3] := $09             ' API Ident for AT Command (queue)
  dataSet[4] := _FrameID        ' Frame ID
  dataSet[5] := byte[stringptr]
  dataSet[6] := byte[stringptr + 1]
  dataSet[7] := val >> 24       ' 4 bytes for value
  dataSet[8] := val >> 16
  dataSet[9] := val >> 8
  dataSet[10] := val
  csum := $FF                   ' Calculate checksum
  Repeat chars from 3 to 10
    csum := csum - dataSet[chars]
  dataSet[11] := csum
  Repeat chars from 0 to 11
    tx(dataSet[chars])


Pub API_Config (stringptr, val)| Length, chars, csum, ptr
{{
  Sends AT commands in API mode to be immediately processed.
  If FrameID is not 0, status will be returned as to success.
  XB.API_Config(string("DL"),$2)  ' Note, value and command are 2 parameters
}}
  
  dataSet[0]   := $7E
  Length := 11                  ' API Ident + FrameID + AT cmd + 4 bytes of data
  dataSet[1] := 0               ' MSB
  dataSet[2] := 08              ' LSB
  dataSet[3] := $08             ' API Ident for AT Command (non queue)
  dataSet[4] := _FrameID        ' Frame ID
  dataSet[5] := byte[stringptr]
  dataSet[6] := byte[stringptr + 1]
  dataSet[7] := val >> 24
  dataSet[8] := val >> 16
  dataSet[9] := val >> 8
  dataSet[10] := val
  csum := $FF                   ' Calculate checksum
  Repeat chars from 3 to 10
    csum := csum - dataSet[chars]
  dataSet[11] := csum
  Repeat chars from 0 to 11
    tx(dataSet[chars])

Pub API_Query (stringptr)| Length, chars, csum
{{
  Sends AT command in API mode to query a parameter value.
  Should also be used to set network identifier.
  Data is returned as an AT response as a string.
  XB.API_Query("DL")                                 ' Query
  XB.API_Rx                                          ' accept response
  MyDest := byte[XB.RxData]                          ' 8 bit value
  XB.API_Query("DL")
  XB.API_RX
  MyPanID := byte[XB.RxData]<<8 + byte[XB.RxData+1]  ' 16 bit value
}}
  dataSet[0] := $7E
  Length := strsize(stringptr) + 2    ' API Ident + FrameID + AT cmd
  dataSet[1] := Length >> 8           ' MSB
  dataSet[2] := Length                ' LSB
  dataSet[3] := $08                   ' API Ident for AT Command (non queue)
  dataSet[4] := _FrameID                   ' Frame ID
  Repeat chars from 0 to length-2     ' Add string to packet
     dataSet[chars + 5] := byte[stringptr++]
  csum := $FF                         ' Calculate checksum
  Repeat chars from 0 to Length
    csum := csum - dataSet[chars + 3]
  dataSet[length+3] := csum
  Repeat chars from 0 to length + 3
    tx(dataSet[chars])

Pub API_Str (addy16,stringptr)| Length, chars, csum,ptr
{{
  Transmit a string to a unit using API mode - 16 bit addressing
  XB.API_Str(2,string("Hello number 2"))     ' Send data to address 16
  TX response of acknowledgement will be returned if FrameID not 0
  XB.API_RX
  If XB.Status == 0 '0 = Acc, 1 = No Ack

 }}
  ptr := 0
  dataSet[ptr++] := $7E
  Length := strsize(stringptr) + 5    ' API Ident + FrameID + API TX cmd + AddrHigh + AddrLow +Options        
  dataSet[ptr++] := Length >> 8           ' MSB
  dataSet[ptr++] := Length                ' LSB
  dataSet[ptr++] := $01                   ' API Ident for AT Command (non queue)
  dataSet[ptr++] := _FrameID              ' Frame ID
  dataSet[ptr++] := addy16 >>8            ' Dest Address MSB
  dataSet[ptr++] := addy16                ' Dest Address LSB
  dataSet[ptr++] := $00                   ' Options '$01 = disable ack, $04 = Broadcast PAN ID
  Repeat strsize(stringptr)               ' Add string to packet
     dataSet[ptr++] := byte[stringptr++]
  csum := $FF                         ' Calculate checksum
  Repeat chars from 3 to ptr-1
    csum := csum - dataSet[chars]
  dataSet[ptr] := csum
 
  Repeat chars from 0 to ptr
    tx(dataSet[chars])

Pub API_Array (addy16,stringptr,size)| Length, chars, csum,ptr
{{
  Transmit a byte to a unit using API mode - 16 bit addressing
  If data contains a 0, this method would be required.
    myStr[0] := $7d
    myStr[1] := 00
    myStr[2] := 13
    XB.API_array(2,@myStr,3)   ' send 3 bytes to address 2
  TX response of acknowledgement will be returned if FrameID not 0
  XB.API_RX
  If XB.Status == 0 '0 = Acc, 1 = No Ack

 }}
  ptr := 0
  dataSet[ptr++] := $7E
  Length := size + 5    ' API Ident + FrameID + API TX cmd + AddrHigh + AddrLow +Options        
  dataSet[ptr++] := Length >> 8           ' MSB
  dataSet[ptr++] := Length                ' LSB
  dataSet[ptr++] := $01                   ' API Ident for AT Command (non queue)
  dataSet[ptr++] := _FrameID              ' Frame ID
  dataSet[ptr++] := addy16 >>8            ' Dest Address MSB
  dataSet[ptr++] := addy16                ' Dest Address LSB
  dataSet[ptr++] := $00                   ' Options '$01 = disable ack, $04 = Broadcast PAN ID
  Repeat size                             ' Add string to packet
     dataSet[ptr++] := byte[stringptr++]
  csum := $FF                         ' Calculate checksum
  Repeat chars from 3 to ptr-1
    csum := csum - dataSet[chars]
  dataSet[ptr] := csum
 
  Repeat chars from 0 to ptr
    tx(dataSet[chars])  

Pub api_tx(addy16,char)| Length, chars, csum,ptr
{{
 Transmit a byte to a unit using API mode - 16 bit addressing
  XB.API_Str(2,ADC_Val)                      ' Send byte data to address 16
  TX response of acknowledgement will be returned if FrameID not 0
  XB.API_RX
  If XB.Status == 0 '0 = Acc, 1 = No Ack
  To send more than 1 byte of data in a packet, use the API_Str method and assemble a string
  myStr[0] := adc_val >> 8  ' high byte
  myStr[1] := adc_val
  myStr[2] := 0
  API_Str(2,@myStr)
   OR, use Number object to create string of values:
  API_Str(2,num.ToStr(ADC_Val,num#DEC)) 
}}

  ptr := 0
  dataSet[ptr++] := $7E
  Length := 6                             ' API Ident + FrameID + API TX cmd + AddrHigh + AddrLow +Options        
  dataSet[ptr++] := Length >> 8           ' MSB
  dataSet[ptr++] := Length                ' LSB
  dataSet[ptr++] := $01                   ' API Ident for AT Command (non queue)
  dataSet[ptr++] := _FrameID                   ' Frame ID
  dataSet[ptr++] := addy16 >>8            ' Dest Address MSB
  dataSet[ptr++] := addy16                ' Dest Address LSB
  dataSet[ptr++] := $00                   ' Options '$01 = disable ack, $04 = Broadcast PAN               
  dataSet[ptr++] := char  ' Add char to packet
  csum := $FF                         ' Calculate checksum
  Repeat chars from 3 to ptr-1
    csum := csum - dataSet[chars]
  dataSet[ptr] := csum
 
  Repeat chars from 0 to ptr
    tx(dataSet[chars])

Pub API_Rx| char, ptr
{{
  Wait for incoming packet until packet identifer found ($7E)
  Then process packet.
  XB.API-RX
}}
    _RxIdent := $FF
    dataSet[0] := 0
    repeat
      char := FDSerial.rx 
    while (char <> $7E)
    RxPacketNow  


Pub API_RxTime(ms)| char, ptr, count
{{
  Wait for incoming data with timeout.
  This method actually loops number of times specified looking
  for packet identifier ($7E).
  If no data received, can be checked with RxIdent:
  If XB.Rx_Ident == $ff ' no data
}}
    dataSet[0] := 0
    _RxIdent := $ff
    repeat ms
      char := FDSerial.rxTime(1)
      If char == $7E
         RxPacketNow
         quit               

    
Pri RxPacketNow | char, ptr
{{
  Process incoming packet based on Identifier
  See individual cases for data returned.
}}

    ptr := 0
    Repeat
      Char := rxTime(10)                    ' accept remained of data
      dataSet[ptr++] := Char 
    while Char <> -1

    ptr := 0
    _RxFlag := 1
    _RxLen := dataSet[ptr++] << 8 + dataSet[ptr++]
    _RxIdent := dataSet[ptr++]
         case _RxIdent
            $81:                '' ********* Rx data from another unit packet
                                '' Returns:
                                '' XB.scrAddr            16bit addr of sender
                                '' XB.RxRSSI             RSSI level of reception
                                '' XB.RXopt              See XB manual
                                '' XB.RxData             Pointer to data string
                                '' XB.RXLen              Length of actual data
                _srcAddr16 := dataSet[ptr++] * 256 + dataSet[ptr++] 
                _RSSI := dataSet[ptr++]
                _RXopt := dataSet[ptr++]
                bytefill(@_RxData,0,105)
                bytemove(@_RxData,@dataSet+ptr,_RxLen-5)
                _RxLen := _RxLen - 5

            $83:                '' ************ DIO/ADC data from another unit (auto sending)
                                '' Returns:
                                '' XB.scrAddr            16bit addr of sender
                                '' XB.RxRSSI             RSSI level of reception
                                '' XB.RXopt              See XB manual
                                '' XB.RxData             Pointer to data array of DIO/ADC data
                                '' XB.RXLen              Length of actual data
                _srcAddr16 := dataSet[ptr++] * 256 + dataSet[ptr++] 
                _RSSI := dataSet[ptr++]
                _RXopt := dataSet[ptr++]
                bytefill(@_RxData,0,105)
                bytemove(@_RxData,@dataSet+ptr,_RxLen-5)
                _RxLen := _RxLen - 5

            $88:                '' *************  AT Response for configuration change
                                '' Returns:
                                '' XB.FrameID            FrameID to match with send if desired
                                '' XB.Status             Status of change - 0 OK, 1 error
                                '' XB.RxCmd              String of AT command issued
                                '' XB.RXLen              Length of actual data
                _RxFrameID := dataSet[ptr++]
                _RxCmd[0] :=  dataSet[ptr++]
                _RxCmd[1] :=  dataSet[ptr++]  
                _Status :=  dataSet[ptr++]
                bytefill(@_RxData,0,105)
                bytemove(@_RxData,@dataSet+ptr,_RxLen-5)
                _RxLen := _RxLen - 5
        
            $89:                '' *************** TX Status of packet
                                '' Returns:
                                '' XB.FrameID            FrameID to match with send if desired
                                '' XB.Status             Status of change-0 ACK, 1-NACK, 2-CCA fail, 3-purged
              _RxFrameID := dataSet[ptr++] 
              _Status:= dataSet[ptr]
        _API_Ready := 1
  

Pub SetFrameID (val)
'' Sets frame ID. If set to 0, XMIT status will not be reported.
'' XB.SetFrameID(5)
    _FrameID := val

Pub FrameID
'' Returns last FrameID recieved.
    Return _RxFrameID


Pub RxData
'' Returns pointer to accepted data string/array
    Return @_RxData

Pub RxLen
'' returns length of accepted data
    Return _RxLen

Pub RxOpt
'' Returns recieved options field
    Return _RxOpt

Pub RxRSSI
'' Returns recieved RSSI value
    Return _RSSI

Pub srcAddr
'' Returns source address of sender
    Return _srcAddr16

Pub RxIdent
'' Returns Packet ID of last packet
    Return _RxIdent

Pub RxCmd
'' Returns AT command as string pointer for AT response
    Return @_RxCmd

Pub Status
'' Returns last status of transmissions or configuration changes
    Return _Status

{{

┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}
       