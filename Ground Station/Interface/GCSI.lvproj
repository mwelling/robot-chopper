<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="8608001">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Data" Type="Folder" URL="../Data">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Supporting Functions" Type="Folder" URL="../Supporting Functions">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Mapping" Type="Folder" URL="../Mapping">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Protocol" Type="Folder" URL="../Protocol">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="GCS Main.vi" Type="VI" URL="../GCS Main.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Get File Extension.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Get File Extension.vi"/>
				<Item Name="Merge Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Merge Errors.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="General Error Handler CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler CORE.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="Acquire Input Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Acquire Input Data.vi"/>
				<Item Name="joystickAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/joystickAcquire.vi"/>
				<Item Name="errorList.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/errorList.vi"/>
				<Item Name="keyboardAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/keyboardAcquire.vi"/>
				<Item Name="mouseAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/mouseAcquire.vi"/>
				<Item Name="Close Input Device.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Close Input Device.vi"/>
				<Item Name="closeJoystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeJoystick.vi"/>
				<Item Name="closeKeyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeKeyboard.vi"/>
				<Item Name="closeMouse.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeMouse.vi"/>
				<Item Name="Intialize Keyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Intialize Keyboard.vi"/>
				<Item Name="Draw Flattened Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Flattened Pixmap.vi"/>
				<Item Name="FixBadRect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/FixBadRect.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Read PNG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/png.llb/Read PNG File.vi"/>
				<Item Name="Check Path.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Path.vi"/>
				<Item Name="Directory of Top Level VI.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Directory of Top Level VI.vi"/>
				<Item Name="Create Mask By Alpha.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Create Mask By Alpha.vi"/>
				<Item Name="Bit-array To Byte-array.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/Bit-array To Byte-array.vi"/>
				<Item Name="Draw Circle by Radius.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/Draw Circle by Radius.vi"/>
				<Item Name="Draw Arc.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Arc.vi"/>
				<Item Name="Set Pen State.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Set Pen State.vi"/>
				<Item Name="Draw Text at Point.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Text at Point.vi"/>
				<Item Name="Draw Text in Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Text in Rect.vi"/>
				<Item Name="PCT Pad String.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/PCT Pad String.vi"/>
				<Item Name="Draw Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Rect.vi"/>
				<Item Name="Initialize Mouse.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Initialize Mouse.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="VISA Configure Serial Port" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port"/>
				<Item Name="VISA Configure Serial Port (Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Instr).vi"/>
				<Item Name="Initialize Joystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Initialize Joystick.vi"/>
				<Item Name="subElapsedTime.vi" Type="VI" URL="/&lt;vilib&gt;/express/express execution control/ElapsedTimeBlock.llb/subElapsedTime.vi"/>
				<Item Name="FormatTime String.vi" Type="VI" URL="/&lt;vilib&gt;/express/express execution control/ElapsedTimeBlock.llb/FormatTime String.vi"/>
			</Item>
			<Item Name="StringCheck.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/StringCheck.vi"/>
			<Item Name="VISA Configure Serial Port (Serial Instr).vi" Type="VI" URL="../../../Interface/ardupilotgcs/VISA Configure Serial Port (Serial Instr).vi"/>
			<Item Name="EnumLog.ctl" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/LogEngine/EnumLog.ctl"/>
			<Item Name="user32.dll" Type="Document" URL="user32.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="Google Earth - initialise.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/Google Earth VIs/Google Earth - initialise.vi"/>
			<Item Name="IsEXE.vi" Type="VI" URL="../../../Interface/ardupilotgcs/IsEXE.vi"/>
			<Item Name="KML-Log2.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-Log2.vi"/>
			<Item Name="KML-Compose2.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-Compose2.vi"/>
			<Item Name="KML-dataParse.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-dataParse.vi"/>
			<Item Name="lookfordata_i32.vi" Type="VI" URL="../../../Interface/ardupilotgcs/lookfordata_i32.vi"/>
			<Item Name="KML-RenameSave.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-RenameSave.vi"/>
			<Item Name="SpeakEngine.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/SpeakEngine.vi"/>
			<Item Name="Speech-OpenVoiceObjects.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-OpenVoiceObjects.vi"/>
			<Item Name="Get_Voices.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Get_Voices.vi"/>
			<Item Name="Get_Audio_Devices.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Get_Audio_Devices.vi"/>
			<Item Name="Speech-SetVoiceAudioDev.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-SetVoiceAudioDev.vi"/>
			<Item Name="Set_Audio_Device.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Set_Audio_Device.vi"/>
			<Item Name="Set_Voice.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Set_Voice.vi"/>
			<Item Name="Set_Volume_and_Rate.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Set_Volume_and_Rate.vi"/>
			<Item Name="Speech-SpeakText.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-SpeakText.vi"/>
			<Item Name="Speech-CloseVoiceObjects.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-CloseVoiceObjects.vi"/>
			<Item Name="EnumSpeak.ctl" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/EnumSpeak.ctl"/>
			<Item Name="Speech-Status.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-Status.vi"/>
			<Item Name="Speech-WpnAltSpd-Talk.vi" Type="VI" URL="../../../Interface/ardupilotgcs/Engines/SpeachEngine/Speech-WpnAltSpd-Talk.vi"/>
			<Item Name="Google Earth - KH_initialise.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/Google Earth VIs/Google Earth - KH_initialise.vi"/>
			<Item Name="lvinput.dll" Type="Document" URL="../../../../../../Program Files (x86)/National Instruments/LabVIEW 8.6/resource/lvinput.dll"/>
			<Item Name="KML-AddWPdata.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-AddWPdata.vi"/>
			<Item Name="KML-wpDataParseOut.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-wpDataParseOut.vi"/>
			<Item Name="KML-AddWPdata2.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-AddWPdata2.vi"/>
			<Item Name="KML-WriteWPT.vi" Type="VI" URL="../../../Interface/ardupilotgcs/SubVIs/KML/KML-WriteWPT.vi"/>
			<Item Name="Retrieve Token String.vi" Type="VI" URL="../../../../Archive/Robo-Chopper Interface/Package .1/Supporting Functions/Retrieve Token String.vi"/>
			<Item Name="Retrieve Token String.vi" Type="VI" URL="../Protocol/Retrieve Token String.vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
