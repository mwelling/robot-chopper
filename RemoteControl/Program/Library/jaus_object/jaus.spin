{{
Tasks:
}} 
{{
DATE:  11-Aug-09
DPG:   Working on Command Codes implementation.  Right now only supports transmission and any
       feedback required for this.  All Command Codes that are finished will be uncommented
       for now.
DATE:  1-Aug-09
DPG:   Created Initial File.  See file located on Google Doc's for individual function status.
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

OBJ
  num: "numbers"
  uart:  "FullDuplexSerial"                 
VAR
  long stack[16]
  byte _message_propertiestx[2]
  byte _command_codetx[2]
  byte _data_controltx[4]
  byte _headertx[16]
  byte _desttx[4]
  byte _sourcetx[4]
  byte _messagetx[255]
  
  byte _message_propertiesrx[2]
  byte _command_coderx[2]
  byte _data_controlrx[4]
  byte _headerrx[16]
  byte _destrx[4]
  byte _sourcerx[4]
  byte _messagerx[255]
  long number 

PUB start(rxpin, txpin, mode, baudrate)
  num.init
  uart.start(rxpin, txpin, mode, baudrate)
  init
pri init
  wordfill(@_message_propertiestx,0,2)   'Initialize 2 bytes to 0.
  wordfill(@_command_codetx,0,2)         'Initialzie 2 bytes to 0.
  wordfill(@_data_controltx,0,4)         'Initialize 4 bytes to 0.
  wordfill(@_desttx,0,4)                 'Initialize 4 bytes to 0.
  wordfill(@_sourcetx,0,4)               'Initialize 4 bytes to 0

  wordfill(@_headertx,0,16)              'Initialize 16 bytes to 0.                                 
  number := 0
PUB stop
PUB getseqnumber
    number++
    if (number > 65536)
      number := 0
    return number
PUB set_destination(subsystem,node,component,instance)
   wordfill(@_desttx,0,4)                 'Initialize 4 bytes to 0.
  _desttx := num.tostr(instance,num#HEX) + (num.tostr(component,num#HEX) << 4) + (num.tostr(node,num#HEX) << 8) + (num.tostr(subsystem,num#HEX) << 12) 

PUB set_source(subsystem,node,component,instance)
   wordfill(@_sourcetx,0,4)                 'Initialize 4 bytes to 0.
   _sourcetx := num.tostr(instance,num#HEX) + (num.tostr(component,num#HEX) << 4) + (num.tostr(node,num#HEX) << 8) + (num.tostr(subsystem,num#HEX) << 12) 

PUB set_properties(jausversion, ack_nck, priority)

  wordfill(@_message_propertiestx,0,2)  'Initialize 2 bytes to 0.
  _message_propertiestx := priority + (ack_nck << 4) + (jausversion << 8)

  if ((ack_nck > 1) OR (priority > $F))
    return TRUE
  else
    return FALSE
PUB set_commandcode(code)
   
  _command_codetx := code

PUB commandclass(type)| len
     case type
       Shutdown:
         len := 2 + 16
         _data_controltx := len
         _messagetx := type + (_headertx << 16)

      Standby:
         len := 2 + 16
         _data_controltx := len
         _messagetx := type + (_headertx << 16)

      Resume:
         len := 2 + 16
         _data_controltx := len
         _messagetx := type + (_headertx << 16)

      Reset:
         len := 2 + 16
         _data_controltx := len
         _messagetx := type + (_headertx << 16)

      OTHER:

PUB recievejaus(msg)
    rxtime(1)
    parseheader(msg)
PRI parseheader(msg)
  
  
PRI build_header(i)
  wordfill(@_headertx,0,16)
  _headertx := _message_propertiestx + (_command_codetx << 16) + (_desttx << 32) + (_sourcetx << 64) + (_data_controltx << 96 + (num.tostr(i,num#BIN) << 112)) 
  
DAT
'  ERRORCON byte "ERROR",0
CON  'JAUS Definitions
'Component ID's
'Command and Control Components
  Subsystem_Commander =         $20
  Sysem_Commander =             $28
'Communications
  Communicator =                $23
'Platform
  Global_Pose_Sensor =          $26
  Local_Pose_Sensor =           $29
  Velocity_State_Sensor =       $2A
  Primitive_Driver =            $21
  Reflexive_Driver =            $2B
  Global_Vector_Driver =        $22
  Local_Vector_Driver =         $2C
  Global_Waypoint_Driver =      $2D
  Local_Waypoint_Driver =       $2E
  Global_Path_Segment_Driver =  $2F
  Local_Path_Segment_Driver =   $30
'Manipulator
  Primitive_Manipulator =       $3A
  Joint_Position_Sensor =       $33
  Joint_Velocity_Sensor =       $34
  Joint_ForceTorque_Sensor =    $35
  Joint_Positions_Driver =      $36
  EndEff_Pose_Driver =          $37
  Joint_Velocities_Driver =     $38
  EndEff_Velocity_State_Driver = $39
  Joint_Move_Driver =           $3A
  EndEff_Discrete_Pose_Driver = $3B
'Environment Sensor
  Visual_Sensor =               $25
  Range_Sensor =                $32
  World_Model_Vector_Store =    $3D
'Planning
  Mission_Spooler =             $24

''Command Codes
''Command Class
  ''Core Subgroup
  'Set_Component_Authority =     $0001
  Shutdown =                    $0002
  Standby =                     $0003
  Resume =                      $0004
  Reset =                       $0005
  'Emergency =                   $0006
  'Clear_Emergency =             $0007
  'Create_Service_Conn =         $0008
  'Confirm_Service_Conn =        $0009
  'Activate_Service_Conn =       $000A
  'Suspend_Service_Conn =        $000B
  'Terminate_Service_Conn =      $000C
  'Request_Component_Control =   $000D
  'Release_Component_Control =   $000E
  'Confirm_Component_Control =   $000F
  'Reject_Component_Control =    $0010
  'Set_Time =                    $0011
  'Event Setup and Control
  'Create_Event =                $01F0
  'Update_Event =                $01F1
  'Cancel_Event =                $01F2
  'Confirm_Event_Request =       $01F3
  'Reject_Event_Request =        $01F4
  ''Communications Subgroup
  'Set_Data_Link_State =         $0200
  'Set_Data_Link_Select =        $0201
  'Set_Selected_Data_Link_State = $0202
  ''Platform Subgroup
  Set_Wrench_Effort =           $0405
  'Set_Discrete_Devices =        $0406
  'Set_Global_Vector =           $0407
  Set_Local_Vector =            $0408
  'Set_Travel_Speed =            $040A
  'Set_Global_Waypoint =         $040C
  'Set_Local_Waypoint =          $040D
  Set_Global_Path_Segment =     $040F
  'Set_Local_Path_Segment =      $0410
  ''Manipulator Subgroup
  'Set_Joint_Efforts =           $0601
  'Set_Joint_Positions =         $0602
  'Set_Joint_Velocities =        $0603
  'Set_Tool_Point =              $0604
  'Set_EndEff_Pose =             $0605
  'Set_EndEff_Velocity_State =   $0606
  'Set_Joint_Motion =            $0607
  'Set_EndEff_Path_Motion =      $0608
  ''Environment Sensor Subgroup
  'Set_Camera_Pose =             $0801
  'Select_Camera =               $0802
  'Set_Camera_Capabilities =     $0805
  'Set_Camera_Form =             $0806
  ''World Model Subgroup
  'Create_Vector_Knowledge_SO =  $0A20
  'Set_Vector_Knowledge_SFCM =   $0A21
  'Terminate_Vector_Knowledge_SDT = $0A42
  'Delte_Vector_Knowledge_SO =   $0A25
  ''Dynamic Configuration Subgroup
  ''Payload Subgroup
  'Set_Payload_Data_Element =    $0D01
  ''Planning Subgroup
  'Spool_Mission =               $0E00
  'Run_Mission =                 $0E01
  'Abort_Mission =               $0E02
  'Pause_Mission =               $0E03
  'Resume_Mission =              $0E04
  'Remove_Messages =             $0E05
  'Replace_Messages =            $0E06
''Query Class
  ''Core Subgroup
  'Query_Comp_Authority =        $2001
  'Query_Comp_Status =           $2002
  'Query_Time =                  $2011
  'Query_Comp_Control =          $200D
  ''Event Setup and Control
  'Query_Events =                $21F0
  ''Communications Subgrop
  'Query_Data_Link_Status =      $2200
  'Query_Sel_Data_Link_Status =  $2201
  'Query_Heartbeat_Pulse =       $2202
  ''Platform Subgroup
  'Query_Platform_Specs =        $2400
  'Query_Platform_Op_Data =      $2401
  'Query_Global_Pose =           $2402
  'Query_Local_Pose =            $2403
  'Query_Velocity_State =        $2404
  'Query_Wrench_Effort =         $2405
  'Query_Discrete_Devices =      $2406
  'Query_Global_Vector =         $2407
  'Query_Travel_Speed =          $240A
  'Query_WPT_Count =             $240B
  'Query_Global_WPT =            $240C
  'Query_Local_WPT =             $240D
  'Query_Path_Segment_Count =    $240E
  'Query_Global_Path_Segment =   $240F
  'Query_Local_Path_Segment =    $2410
  ''Manipulator Subgroup
  'Query_Manipulator_Specs =     $2600
  'Query_Joint_Efforts =         $2601
  'Query_Joint_Positions =       $2602
  'Query_Joint_Velocities =      $2603
  'Query_Tool_Point =            $2603
  'Query_Joint_ForceTorque =     $2605
  ''Environmental Sensor Subgroup
  'Query_Camera_Pose =           $2800
  'Query_Camera_Count =          $2801
  'Query_Relative_Object_Pos =   $2802
  'Query_Selected_Camera =       $2804
  'Query_Camera_Capabilities =   $2805
  'Query_Camera_Format_Options = $2806
  'Query_Image =                 $2807
  ''World Model Subgroup
  'Query_Vec_Know_St_Metadata =  $2A21
  'Query_Vec_Know_St_Bounds =    $2A22
  'Query_Vec_St_Objects =        $2A23
  ''Dynamic Configuration Subgroup
  'Query_Identification =        $2B00
  'Query_Configuration =         $2B01
  'Query_Subsystem_List =        $2B02
  'Query_Services =              $2B03
  ''Payload Subgroup
  'Query_Payload_Interface_Msg = $2D00
  'Query_Payload_Data_Element =  $2D01
  ''Planning Subgroup
  'Query_Spooling_Pref =         $2E00
  'Query_Mission_Status =        $2E01
''Inform Class
  ''Core Subgroup
  'Report_Component_Authority =  $4001
  'Report_Component_Status =     $4002
  'Report_Time =                 $4011
  'Report_Component_Control =    $400D
  '''Event Setup and Control
  'Report_Events =               $41F0
  'Event =                       $41F1
  ''Communications Subgroup
  'Report_Data_Link_Status =     $4200
  'Report_Sel_Data_Link_Status = $4201
  'Report_Heartbeat_Pulse =      $4202
  ''Platform Subgroup
  'Report_Platform_Specs =       $4400
  'Report_Platform_Op_Data =     $4401
  'Report_Global_Pose =          $4402
  'Report_Local_Pose =           $4403
  'Report_Velocity_State =       $4404
  'Report_Wrench_Effort =        $4405
  'Report_Discrete_Devices =     $4406
  'Report_Global_Vector =        $4407
  'Report_Local_Vector =         $4408
  'Report_Travel_Speed =         $440A
  'Report_Wpt_Count =            $440B
  'Report_Global_Wpt =           $440C
  'Report_Local_Wpt =            $440D
  'Report_Path_Seg_Count =       $440E
  'Report_Global_Path_Seg =      $440F
  'Report_Local_Path_Seg =       $4410
  ''Manipulator Subgroup
  'Report_Manipulator_Specs =    $4600
  'Report_Joint_Efforts =        $4601
  'Report_Joint_Positions =      $4602
  'Report_Joint_Velocities =     $4603
  'Report_Tool_Point =           $4604
  'Report_Joint_ForceTorques =   $4605
  ''Environmental Sensor Subgroup
  'Report_Camera_Pose =          $4800
  'Report_Camera_Count =         $4801
  'Report_Rel_Obj_Position =     $4802
  'Report_Sel_Camera =           $4804
  'Report_Camera_Capabilities =  $4805
  'Report_Camera_Format_Options = $4806
  'Report_Image =                $4807
  ''World Model Subgroup
  'Report_Vec_Know_St_Obj_Crt =  $4A20
  'Report_Vec_Know_St_Fea_Cls_M = $4A21
  'Report_Vec_Know_St_Bounds =   $4A22
  'Report_Vec_Know_St_Objects =  $4A23
  'Report_Vec_Know_St_DTT =      $4A24
  ''Dynamic Configuration Subgroup
  'Report_ID =                   $4B00
  'Report_Configuration =        $4B01
  'Report_Subsystem_List =       $4B02
  'Report_Services =             $4B03
  ''Planning Subgroup
  'Report_Spooling_Preferences = $4E00
  'Report_Mission_Status =       $4E01                        
  
                                    
  
  
  
  
  
       
  