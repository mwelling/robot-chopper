{{
Tasks:  -Write Code for Building JAUS Messages.
        -Write Code for Parsing JAUS Messages.
        -Annotate Limitations of Current implementation.
 }} 
{{
DATE:  1-Aug-09
DPG:   Created Initial File.  See file located on Google Doc's for individual function status.  Note:  Message lengths limited to
       255 characters for now.
}}
{{
COG Usage:
COG 1:  Main Program 
COG 2:  jaus
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

' JAUS

  jausver = 02
  ack_nck = 0
  highpriority = $B
  defpriority = $6
  lowpriority = $0
  ALL = $FF
  
  rxpin = 0
  txpin = 1
  mode = 0
  baudrate = 9600
                  
var
  long stack[16]
  long cogsused
  long seqnumber
  
obj
  jaus:  "jaus"
PUB init
''DPG 1-Aug-09
  jaus.start(rxpin, txpin, mode, baudrate) 
  testjaus
PUB testjaus | str
''DPG 1-Aug-09
  seqnumber := jaus.getseqnumber
  jaus.set_properties(jausver, ack_nck, defpriority)
  jaus.set_commandcode(jaus#Set_Wrench_Effort)
  jaus.set_destination(ALL,ALL,jaus#Subsystem_Commander,ALL)
  jaus.set_source(ALL,ALL,ALL,ALL)

  jaus.set_commandcode(jaus#Shutdown)

  




DAT
'  ERRORCON byte "ERROR",0    