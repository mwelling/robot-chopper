EESchema Schematic File Version 2  date 4/23/2010 9:23:41 AM
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:DavidGitzKiCadLibrary
LIBS:PropRPM-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 2 2
Title "noname.sch"
Date "23 apr 2010"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	6250 2900 6250 2800
Connection ~ 6250 2400
Connection ~ 5000 2400
Wire Wire Line
	5250 2400 4500 2400
Connection ~ 6250 2800
Connection ~ 5650 2800
Wire Wire Line
	5650 2950 5650 2700
Connection ~ 4650 2800
Wire Wire Line
	3850 2550 3850 2650
Wire Wire Line
	3850 2400 4100 2400
Wire Wire Line
	3850 2650 3950 2650
Wire Wire Line
	3950 2650 3950 2800
Connection ~ 5000 2800
Wire Wire Line
	3950 2800 6950 2800
Connection ~ 6650 2800
Connection ~ 4650 2400
Connection ~ 6650 2400
Wire Wire Line
	4100 2750 4100 2800
Connection ~ 4100 2800
Wire Wire Line
	7850 2400 6050 2400
Connection ~ 7450 2400
Text GLabel 6250 2900 3    60   UnSpc ~ 0
GND
Text GLabel 7850 2400 2    60   Output ~ 0
Vdd
$Comp
L PWR_FLAG #FLG07
U 1 1 4BD0676D
P 4100 2750
F 0 "#FLG07" H 4100 3020 30  0001 C CNN
F 1 "PWR_FLAG" H 4100 2980 30  0000 C CNN
	1    4100 2750
	1    0    0    -1  
$EndComp
$Comp
L JACK_2P J1
U 1 1 4BD066B1
P 3400 2550
F 0 "J1" H 3050 2350 60  0000 C CNN
F 1 "JACK_2P" H 3250 2800 60  0000 C CNN
	1    3400 2550
	1    0    0    -1  
$EndComp
$Comp
L LED D2
U 1 1 4BD064F4
P 7450 2600
F 0 "D2" H 7450 2700 50  0000 C CNN
F 1 "LED" H 7450 2500 50  0000 C CNN
	1    7450 2600
	0    1    1    0   
$EndComp
$Comp
L GND #PWR08
U 1 1 4BD06586
P 5650 2950
F 0 "#PWR08" H 5650 2950 30  0001 C CNN
F 1 "GND" H 5650 2880 30  0001 C CNN
	1    5650 2950
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR09
U 1 1 4BD0657D
P 7450 2400
F 0 "#PWR09" H 7450 2500 30  0001 C CNN
F 1 "VDD" H 7450 2510 30  0000 C CNN
	1    7450 2400
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4BD064E7
P 7200 2800
F 0 "R1" V 7280 2800 50  0000 C CNN
F 1 "180R" V 7200 2800 50  0000 C CNN
	1    7200 2800
	0    1    1    0   
$EndComp
$Comp
L LM7805 U1
U 1 1 4BD064BC
P 5650 2450
F 0 "U1" H 5800 2254 60  0000 C CNN
F 1 "LM2940-3.3" H 5650 2650 60  0000 C CNN
	1    5650 2450
	1    0    0    -1  
$EndComp
$Comp
L CP1 C4
U 1 1 4BD064A0
P 6650 2600
F 0 "C4" H 6700 2700 50  0000 L CNN
F 1 "100uF" H 6700 2500 50  0000 L CNN
	1    6650 2600
	1    0    0    -1  
$EndComp
$Comp
L CP1 C2
U 1 1 4BD0649A
P 5000 2600
F 0 "C2" H 5050 2700 50  0000 L CNN
F 1 "100uF" H 5050 2500 50  0000 L CNN
	1    5000 2600
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 4BD06493
P 6250 2600
F 0 "C3" H 6300 2700 50  0000 L CNN
F 1 ".1uF" H 6300 2500 50  0000 L CNN
	1    6250 2600
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4BD0648C
P 4650 2600
F 0 "C1" H 4700 2700 50  0000 L CNN
F 1 ".1uF" H 4700 2500 50  0000 L CNN
	1    4650 2600
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 4BD06474
P 4300 2400
F 0 "D1" H 4300 2500 40  0000 C CNN
F 1 "1N4001" H 4300 2300 40  0000 C CNN
	1    4300 2400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
