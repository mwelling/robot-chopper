{{
***********************************
* Martin Hebel                    *
* Southern Illinois University    *
* SelmaWare Solutions             *
* 6/24/07                         *
* Version 1.0                     *
***********************************
Test of XBee Object
This requires an 2 XBee's connected to computer via
serial or USB, assigned address 1 and 2.

If you can't meet that requirement, you can still you
this for some examples, or simply have another Xbee to send
data to address 0 at times (Prop XBee)

Please see the XBee object for other information.

}}

CON 
    _clkmode = xtal1 + pll16x      '80MHz operating frequency.
    _xinfreq = 5_000_000                      

VAR   '' Global Variables and Cog Stack Space
   byte  RSSI
OBJ 
  XB   : "XBee_Object"       
  Comm : "FullDuplexSerial"  
  Num  : "Numbers"

Pub Start | check
    XB.start(7,6,0,9600)           ' XBee Comms - RX,TX, Mode, Baud
    XB.AT_Init                     ' Initialize for fast AT command use - 5 second delay to perform
    Comm.start(31,30,0,9600)       ' Initialize comms from Prop to PC
    num.init                       ' Initialize Numbers object

    XB.AT_Config(string("ATAP 0"))            ' Set for non-API mode (AT mode)

    XB.AT_Config(string("ATDL 1"))            ' Set destination address to 1
    XB.Str(string(13,"Hello number 1",13))    ' TX string
    XB.Dec(101)                               ' TX value
    XB.tx(13)                                 ' TX carraige return


    XB.AT_Config(string("ATDL 2"))            ' Change address to 2
    XB.Str(string("Hello number 2",13))       ' send string and then value
    XB.Dec(102)
    XB.Tx(13)
    


    XB.AT_Config(string("ATAP 1"))                ' change to API mode
    XB.API_Str(1,string("Back to number 1!",13))  ' send string to address 1
    XB.API_Str(1,num.ToStr(103,num#dec))          ' send a string for value to address 1
    XB.API_Tx(1,13)                               ' send CR to address 1
    XB.API_Str(2,string("And number 2!",13))      ' repeat for address 2
    XB.API_Str(2,num.ToStr(104,num#dec))
    XB.Delay(250)                                 ' delay to allow responses from actions

    comm.rxflush                                  ' clean buffer
    XB.API_Tx(2,"A")                              ' Send data to address 2
    XB.API_Rx                                     ' accept TX response
    DisplayData                                   ' Display response
    if XB.Status == 0                             ' show results of transmission
       comm.str(string(13,"Unit 2 acknowledged",13))
    else
       comm.str(string(13,"Unit 2 NOT acknowledged",13))


    XB.SetframeID(0)                             ' set tx frame ID to 0 to disable responses
    XB.API_Config(string("PL"),$1)               ' Set power level output to 1

    XB.SetFrameID(1)                             ' enable responses with non-zero frameID
    comm.str(string("Reading Power level:"))
    XB.API_Query(string("PL"))                   ' Query power level
    XB.API_Rx                                    ' accept response
    comm.dec(byte[XB.RxData])                    ' display results (returned as byte-string)
    CR

    comm.str(string("Reading PAN ID:"))          ' Query PAN ID
    XB.API_Query(string("ID"))
    XB.API_Rx                                    ' Accept response
    comm.hex(byte[XB.RxData]<<8 + byte[XB.RxData+1],4)  ' Display data (byte-string)
    CR

   
    repeat
       XB.API_Rx                                 ' wait for any incoming data to display
       DisplayData                               ' display RSSI level, source Addr, etc

      
Pub DisplayData | ptr, x
    ' Based on RxIdent (type of packet), displays information
     Case XB.rxIdent           
        $81:         ' RX data
          Comm.str(string(13,"RX data",13,"Ident:     "))
          Comm.hex(XB.RxIdent,2)
          CR
          Comm.str(string("Addr:      "))
          Comm.hex(XB.srcAddr,4)
          CR
          Comm.str(string("RSSI:      "))
          RSSI := XB.RxRSSI
          Comm.dec(RSSI)
          CR
          Comm.str(string("Data Len:  "))
          Comm.dec(XB.RxLen)
          CR
          Comm.str(string("Data:      "))
          comm.str(XB.RxData)

        $83:              ' DIO/ADC string
          comm.str(string(13,"ADC/DIO Data",13,"Ident:     "))
          comm.hex(XB.RxIdent,2)
          CR
          comm.str(string("Addr:      "))
          comm.Hex(XB.srcAddr,4)
          CR
          comm.str(string("RSSI:      "))
          RSSI := XB.RxRSSI
          comm.dec(RSSI)
          CR
          comm.str(string("Data Len:  "))
          comm.dec(XB.RxLen)
          CR
          comm.str(string("Data:      "))
          ptr := XB.RxData
          repeat x from 1 to XB.RxLen
            comm.HEX(byte[ptr++],2)
            comm.tx(32)
          CR

        $88:                 ' AT/configuration response
          comm.str(string(13,"AT Response",13,"Ident:     "))
          comm.hex(XB.RxIdent,2)
          CR
          comm.str(string("AT Cmd:    "))
          comm.tx(byte[XB.RxCmd])
          comm.tx(byte[XB.RxCmd+1])
          CR
          comm.str(string("Status:     "))
          comm.dec(XB.Status)
          CR
          comm.str(string("Data:      "))
          ptr := XB.RxData
          repeat x from 0 to XB.RxLen -1
            comm.HEX(byte[ptr++],2)
          CR
           
        $89:           ' tx Status
          comm.str(string(13,"TX Status",13,"Ident:     "))
          comm.hex(XB.RxIdent,2)
          CR 
          comm.str(string("Status:     "))   ' 0 = success, 1 = failure
          comm.dec(XB.Status)
          CR
          comm.str(string("FrameID:     "))
          comm.dec(XB.FrameID)
          CR

PUB CR
  comm.tx(13)

         