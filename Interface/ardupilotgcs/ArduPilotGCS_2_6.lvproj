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
		<Item Name="Voice" Type="Folder">
			<Item Name="EnumSpeak.ctl" Type="VI" URL="../Engines/SpeachEngine/EnumSpeak.ctl"/>
			<Item Name="Get_Audio_Devices.vi" Type="VI" URL="../Engines/SpeachEngine/Get_Audio_Devices.vi"/>
			<Item Name="Get_Voices.vi" Type="VI" URL="../Engines/SpeachEngine/Get_Voices.vi"/>
			<Item Name="Set_Audio_Device.vi" Type="VI" URL="../Engines/SpeachEngine/Set_Audio_Device.vi"/>
			<Item Name="Set_Voice.vi" Type="VI" URL="../Engines/SpeachEngine/Set_Voice.vi"/>
			<Item Name="Set_Volume_and_Rate.vi" Type="VI" URL="../Engines/SpeachEngine/Set_Volume_and_Rate.vi"/>
			<Item Name="SpeakEngine.vi" Type="VI" URL="../Engines/SpeachEngine/SpeakEngine.vi"/>
			<Item Name="Speech-WpnAltSpd-Talk.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-WpnAltSpd-Talk.vi"/>
			<Item Name="Speech-CloseVoiceObjects.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-CloseVoiceObjects.vi"/>
			<Item Name="Speech-Status.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-Status.vi"/>
			<Item Name="Speech-SpeakText.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-SpeakText.vi"/>
			<Item Name="Speech-OpenVoiceObjects.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-OpenVoiceObjects.vi"/>
			<Item Name="Speech-SetVoiceAudioDev.vi" Type="VI" URL="../Engines/SpeachEngine/Speech-SetVoiceAudioDev.vi"/>
		</Item>
		<Item Name="KML logging" Type="Folder"/>
		<Item Name="GoogleEarth" Type="Folder">
			<Item Name="Google Earth - initialise.vi" Type="VI" URL="../../../../../../Users/dgitz/Documents/Downloads/Google_Earth-LV (1).llb/Google Earth - initialise.vi"/>
		</Item>
		<Item Name="Logging" Type="Folder">
			<Item Name="EnumLog.ctl" Type="VI" URL="../Engines/LogEngine/EnumLog.ctl"/>
			<Item Name="LogEngine.vi" Type="VI" URL="../Engines/LogEngine/LogEngine.vi"/>
		</Item>
		<Item Name="LogComSettings" Type="Folder">
			<Item Name="SettingsEngine.vi" Type="VI" URL="../Engines/SettingsEngine/SettingsEngine.vi"/>
			<Item Name="SettingsEngineEnum.ctl" Type="VI" URL="../Engines/SettingsEngine/SettingsEngineEnum.ctl"/>
		</Item>
		<Item Name="ComPort" Type="Folder">
			<Item Name="VISA Configure Serial Port (Serial Instr).vi" Type="VI" URL="../VISA Configure Serial Port (Serial Instr).vi"/>
		</Item>
		<Item Name="GeneralAndMisc" Type="Folder">
			<Item Name="IsEXE.vi" Type="VI" URL="../IsEXE.vi"/>
			<Item Name="lookfordata_i32.vi" Type="VI" URL="../lookfordata_i32.vi"/>
			<Item Name="lookfordata_dbl.vi" Type="VI" URL="../lookfordata_dbl.vi"/>
			<Item Name="roll_indicator_calc.vi" Type="VI" URL="../roll_indicator_calc.vi"/>
			<Item Name="EnumComm.ctl" Type="VI" URL="../EnumComm.ctl"/>
			<Item Name="EventHandlerEnum.ctl" Type="VI" URL="../EventHandlerEnum.ctl"/>
			<Item Name="NetworkLink.kml" Type="Document" URL="../NetworkLink.kml"/>
			<Item Name="airports.png" Type="Document" URL="../airports.png"/>
			<Item Name="Backup-APflight.kml" Type="Document" URL="../Backup-APflight.kml"/>
			<Item Name="Backup-NetworkLink.kml" Type="Document" URL="../Backup-NetworkLink.kml"/>
			<Item Name="blu-blank.png" Type="Document" URL="../blu-blank.png"/>
			<Item Name="GCS-diydrones.png" Type="Document" URL="../GCS-diydrones.png"/>
			<Item Name="H.png" Type="Document" URL="../H.png"/>
			<Item Name="L.png" Type="Document" URL="../L.png"/>
			<Item Name="ArduPilotGCSv2_icon.ico" Type="Document" URL="../ArduPilotGCSv2_icon.ico"/>
		</Item>
		<Item Name="SubVIs" Type="Folder" URL="../SubVIs">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="FlightData" Type="Folder" URL="../FlightData">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="ArduPilot GCS.vi" Type="VI" URL="../ArduPilot GCS.vi"/>
		<Item Name="test.vi" Type="VI" URL="../../../../../../Users/dgitz/Desktop/test.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="Get File Extension.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Get File Extension.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Merge Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Merge Errors.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="General Error Handler CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler CORE.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="errorList.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/errorList.vi"/>
				<Item Name="joystickAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/joystickAcquire.vi"/>
				<Item Name="closeJoystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeJoystick.vi"/>
				<Item Name="keyboardAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/keyboardAcquire.vi"/>
				<Item Name="Intialize Keyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Intialize Keyboard.vi"/>
				<Item Name="closeMouse.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeMouse.vi"/>
				<Item Name="closeKeyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeKeyboard.vi"/>
				<Item Name="Close Input Device.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Close Input Device.vi"/>
				<Item Name="mouseAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/mouseAcquire.vi"/>
				<Item Name="Acquire Input Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Acquire Input Data.vi"/>
				<Item Name="Draw Flattened Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Flattened Pixmap.vi"/>
				<Item Name="FixBadRect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/FixBadRect.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Check Path.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Path.vi"/>
				<Item Name="Directory of Top Level VI.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Directory of Top Level VI.vi"/>
				<Item Name="Read PNG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/png.llb/Read PNG File.vi"/>
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
				<Item Name="subElapsedTime.vi" Type="VI" URL="/&lt;vilib&gt;/express/express execution control/ElapsedTimeBlock.llb/subElapsedTime.vi"/>
				<Item Name="FormatTime String.vi" Type="VI" URL="/&lt;vilib&gt;/express/express execution control/ElapsedTimeBlock.llb/FormatTime String.vi"/>
			</Item>
			<Item Name="user32.dll" Type="Document" URL="user32.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="lvinput.dll" Type="Document" URL="../../../../../../Program Files (x86)/National Instruments/LabVIEW 8.6/resource/lvinput.dll"/>
			<Item Name="Retrieve Token String.vi" Type="VI" URL="../SubVIs/Retrieve Token String.vi"/>
			<Item Name="Retrieve Token String.vi" Type="VI" URL="../../../../Archive/Robo-Chopper Interface/Package .1/Supporting Functions/Retrieve Token String.vi"/>
			<Item Name="Sensor Data.vi" Type="VI" URL="../Data/Sensor Data.vi"/>
			<Item Name="Vehicle Data.vi" Type="VI" URL="../Data/Vehicle Data.vi"/>
			<Item Name="Error Data.vi" Type="VI" URL="../Data/Error Data.vi"/>
			<Item Name="LogEngine.vi" Type="VI" URL="../../../Ground Station/Interface/Mapping/LogEngine.vi"/>
			<Item Name="KML-Create.vi" Type="VI" URL="../../../Ground Station/Interface/Mapping/KML-Create.vi"/>
			<Item Name="Mapping Data.vi" Type="VI" URL="../../../Ground Station/Interface/Data/Mapping Data.vi"/>
			<Item Name="Data Separator.vi" Type="VI" URL="../../../Ground Station/Interface/Supporting Functions/Data Separator.vi"/>
			<Item Name="Write-out Google Maps.vi" Type="VI" URL="../../../Ground Station/Interface/Mapping/Write-out Google Maps.vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="ArduPilotGCS" Type="EXE">
				<Property Name="App_applicationGUID" Type="Str">{C915BA1A-8BBC-41AC-AE40-3783579FC2B1}</Property>
				<Property Name="App_applicationName" Type="Str">ArduPilot GCS.exe</Property>
				<Property Name="App_companyName" Type="Str">DIYDrones</Property>
				<Property Name="App_fileDescription" Type="Str">ArduPilotGCS</Property>
				<Property Name="App_fileVersion.build" Type="Int">6</Property>
				<Property Name="App_fileVersion.major" Type="Int">2</Property>
				<Property Name="App_fileVersion.minor" Type="Int">6</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{4C3A0630-E35B-4923-9113-DE232397545D}</Property>
				<Property Name="App_INI_GUID" Type="Str">{64764894-366A-4342-9CB7-1A3A15AB6CAF}</Property>
				<Property Name="App_internalName" Type="Str">ArduPilotGCS</Property>
				<Property Name="App_legalCopyright" Type="Str">DIYDrones Copyright © 2010 </Property>
				<Property Name="App_productName" Type="Str">ArduPilotGCS</Property>
				<Property Name="Bld_buildSpecName" Type="Str">ArduPilotGCS</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Destination[0].destName" Type="Str">ArduPilot GCS.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/ArduPilotGCS/internal.llb</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/ArduPilotGCS/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Exe_iconItemID" Type="Ref">/My Computer/GeneralAndMisc/ArduPilotGCSv2_icon.ico</Property>
				<Property Name="Source[0].itemID" Type="Str">{D6A80910-192E-4EC9-91DE-0FC88722246E}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/ArduPilot GCS.vi</Property>
				<Property Name="Source[1].properties[0].type" Type="Str">Allow debugging</Property>
				<Property Name="Source[1].properties[0].value" Type="Bool">false</Property>
				<Property Name="Source[1].properties[1].type" Type="Str">Run when opened</Property>
				<Property Name="Source[1].properties[1].value" Type="Bool">true</Property>
				<Property Name="Source[1].propertiesCount" Type="Int">2</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[10].Container.applyProperties" Type="Bool">true</Property>
				<Property Name="Source[10].itemID" Type="Ref">/My Computer/Voice</Property>
				<Property Name="Source[10].type" Type="Str">Container</Property>
				<Property Name="Source[11].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[11].itemID" Type="Ref">/My Computer/GeneralAndMisc/ArduPilotGCSv2_icon.ico</Property>
				<Property Name="Source[11].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[12].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[12].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[12].itemID" Type="Ref">/My Computer/SubVIs</Property>
				<Property Name="Source[12].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[12].type" Type="Str">Container</Property>
				<Property Name="Source[13].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[13].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[13].itemID" Type="Ref">/My Computer/FlightData</Property>
				<Property Name="Source[13].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[13].type" Type="Str">Container</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/GeneralAndMisc/NetworkLink.kml</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/GeneralAndMisc/airports.png</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/GeneralAndMisc/Backup-APflight.kml</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/GeneralAndMisc/Backup-NetworkLink.kml</Property>
				<Property Name="Source[5].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[6].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[6].itemID" Type="Ref">/My Computer/GeneralAndMisc/blu-blank.png</Property>
				<Property Name="Source[7].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[7].itemID" Type="Ref">/My Computer/GeneralAndMisc/GCS-diydrones.png</Property>
				<Property Name="Source[7].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[8].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[8].itemID" Type="Ref">/My Computer/GeneralAndMisc/H.png</Property>
				<Property Name="Source[9].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[9].itemID" Type="Ref">/My Computer/GeneralAndMisc/L.png</Property>
				<Property Name="SourceCount" Type="Int">14</Property>
			</Item>
		</Item>
	</Item>
</Project>
