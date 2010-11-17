EESchema Schematic File Version 2  date 4/22/2010 9:04:54 PM
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
LIBS:RFDAQ-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title "RF DAQ "
Date "23 apr 2010"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 4850 4100
$Comp
L PROPELLER U?
U 1 1 4BD0D888
P 4000 4550
F 0 "U?" H 4050 4500 60  0000 C CNN
F 1 "PROPELLER" H 4050 4500 60  0000 C CNN
	1    4000 4550
	1    0    0    -1  
$EndComp
$Comp
L 24LC256 U3
U 1 1 4BD0D825
P 6550 3900
F 0 "U3" H 6700 3700 60  0000 C CNN
F 1 "24LC256" H 6850 3800 60  0000 C CNN
	1    6550 3900
	1    0    0    -1  
$EndComp
NoConn ~ 10500 4850
NoConn ~ 10500 5000
NoConn ~ 10500 5150
NoConn ~ 10500 5300
NoConn ~ 10500 5450
NoConn ~ 10500 5600
NoConn ~ 10500 5750
NoConn ~ 10500 5900
NoConn ~ 10500 6050
NoConn ~ 10500 6200
NoConn ~ 8400 6000
NoConn ~ 8400 5850
NoConn ~ 8400 5700
NoConn ~ 8400 5400
NoConn ~ 8400 5250
Wire Wire Line
	2500 3450 2500 3200
Wire Wire Line
	2500 3200 2300 3200
Wire Wire Line
	3200 3200 3050 3200
Wire Wire Line
	3050 3200 3050 3000
Wire Wire Line
	3050 3000 2300 3000
Wire Wire Line
	8400 4800 8400 4650
Wire Wire Line
	8400 5100 5600 5100
Wire Wire Line
	5600 5100 5600 3950
Wire Wire Line
	5600 3950 4850 3950
Wire Wire Line
	7800 2800 7800 4250
Wire Wire Line
	7800 4250 5950 4250
Connection ~ 7350 3000
Wire Wire Line
	7350 3000 7000 3000
Wire Wire Line
	7000 3000 7000 2450
Wire Wire Line
	7000 2450 5550 2450
Wire Wire Line
	5550 2450 5550 3500
Wire Wire Line
	5550 3500 4850 3500
Connection ~ 7350 2350
Wire Wire Line
	7800 2400 7800 2350
Wire Wire Line
	7800 2350 5400 2350
Wire Wire Line
	5400 2850 5400 3650
Wire Wire Line
	5400 3650 4850 3650
Wire Wire Line
	4850 4400 5050 4400
Wire Wire Line
	5050 4400 5050 4350
Connection ~ 3050 4400
Wire Wire Line
	3050 4400 3050 4550
Wire Wire Line
	3050 4550 3200 4550
Connection ~ 5950 3750
Connection ~ 6550 4250
Wire Wire Line
	5950 4250 5950 3150
Wire Wire Line
	6550 4350 6550 4200
Connection ~ 5200 1350
Connection ~ 3950 1350
Wire Wire Line
	3450 1350 4200 1350
Connection ~ 5200 1750
Connection ~ 4600 1750
Wire Wire Line
	4600 1650 4600 1900
Connection ~ 3600 1750
Wire Wire Line
	2800 1500 2800 1600
Wire Wire Line
	2800 1350 3050 1350
Wire Wire Line
	2800 1600 2900 1600
Wire Wire Line
	2900 1600 2900 1750
Connection ~ 3950 1750
Wire Wire Line
	2900 1750 5900 1750
Connection ~ 5600 1750
Connection ~ 3600 1350
Wire Wire Line
	5000 1350 6400 1350
Connection ~ 5600 1350
Wire Wire Line
	3050 1750 3050 1700
Connection ~ 3050 1750
Connection ~ 5950 3600
Connection ~ 5950 3450
Wire Wire Line
	3200 4400 2550 4400
Wire Wire Line
	2550 4400 2550 4950
Wire Wire Line
	3200 4850 2900 4850
Wire Wire Line
	2900 4850 2900 4800
Wire Wire Line
	4850 4850 5050 4850
Wire Wire Line
	5050 4850 5050 4950
Wire Wire Line
	5950 3000 5400 3000
Connection ~ 5400 3000
Wire Wire Line
	7350 2350 7350 2250
Wire Wire Line
	7150 3500 7350 3500
Wire Wire Line
	7350 3500 7350 2850
Wire Wire Line
	6550 2600 6550 2350
Connection ~ 6550 2350
Wire Wire Line
	4850 3800 5750 3800
Wire Wire Line
	5750 3800 5750 4950
Wire Wire Line
	5750 4950 8400 4950
Wire Wire Line
	8400 5550 7400 5550
Wire Wire Line
	7400 5550 7400 6400
Wire Wire Line
	7400 6400 3000 6400
Wire Wire Line
	3000 6400 3000 6050
Wire Wire Line
	3000 6050 3200 6050
Wire Wire Line
	8400 6150 8300 6150
Wire Wire Line
	8300 6150 8300 6300
Wire Wire Line
	2500 2850 2500 3100
Wire Wire Line
	2500 3100 2300 3100
$Comp
L VDD #PWR01
U 1 1 4BD0D749
P 2500 2850
F 0 "#PWR01" H 2500 2950 30  0001 C CNN
F 1 "VDD" H 2500 2960 30  0000 C CNN
	1    2500 2850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 4BD0D743
P 2500 3450
F 0 "#PWR02" H 2500 3450 30  0001 C CNN
F 1 "GND" H 2500 3380 30  0001 C CNN
	1    2500 3450
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 K1
U 1 1 4BD0D71F
P 1950 3100
F 0 "K1" V 1900 3100 50  0000 C CNN
F 1 "GPS" V 2000 3100 40  0000 C CNN
	1    1950 3100
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR03
U 1 1 4BD0D6FD
P 8300 6300
F 0 "#PWR03" H 8300 6300 30  0001 C CNN
F 1 "GND" H 8300 6230 30  0001 C CNN
	1    8300 6300
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR04
U 1 1 4BD0D6F6
P 8400 4650
F 0 "#PWR04" H 8400 4750 30  0001 C CNN
F 1 "VDD" H 8400 4760 30  0000 C CNN
	1    8400 4650
	1    0    0    -1  
$EndComp
NoConn ~ 4850 3200
$Comp
L XBEE_PRO U4
U 1 1 4BD0D5FB
P 9550 5850
F 0 "U4" H 9300 6050 60  0000 C CNN
F 1 "XBEE_PRO" H 9500 6150 60  0000 C CNN
	1    9550 5850
	1    0    0    -1  
$EndComp
NoConn ~ 4850 3350
NoConn ~ 4850 4250
NoConn ~ 4850 4550
NoConn ~ 4850 4700
NoConn ~ 4850 5000
NoConn ~ 4850 5150
NoConn ~ 4850 5300
NoConn ~ 4850 5450
NoConn ~ 4850 5600
NoConn ~ 4850 5750
NoConn ~ 4850 5900
NoConn ~ 4850 6050
NoConn ~ 3200 5900
NoConn ~ 3200 5750
NoConn ~ 3200 5600
NoConn ~ 3200 5450
NoConn ~ 3200 5300
NoConn ~ 3200 5150
NoConn ~ 3200 5000
NoConn ~ 3200 4700
NoConn ~ 3200 4250
NoConn ~ 3200 4100
NoConn ~ 3200 3950
NoConn ~ 3200 3800
NoConn ~ 3200 3650
NoConn ~ 3200 3500
NoConn ~ 3200 3350
$Comp
L VDD #PWR05
U 1 1 4BD06E0E
P 5050 4350
F 0 "#PWR05" H 5050 4450 30  0001 C CNN
F 1 "VDD" H 5050 4460 30  0000 C CNN
	1    5050 4350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 4BD06E08
P 5050 4950
F 0 "#PWR06" H 5050 4950 30  0001 C CNN
F 1 "GND" H 5050 4880 30  0001 C CNN
	1    5050 4950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 4BD06DC0
P 2550 4950
F 0 "#PWR07" H 2550 4950 30  0001 C CNN
F 1 "GND" H 2550 4880 30  0001 C CNN
	1    2550 4950
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR08
U 1 1 4BD06DB8
P 2900 4800
F 0 "#PWR08" H 2900 4900 30  0001 C CNN
F 1 "VDD" H 2900 4910 30  0000 C CNN
	1    2900 4800
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR09
U 1 1 4BD06DA8
P 7350 2250
F 0 "#PWR09" H 7350 2350 30  0001 C CNN
F 1 "VDD" H 7350 2360 30  0000 C CNN
	1    7350 2250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 4BD06D67
P 6550 4350
F 0 "#PWR010" H 6550 4350 30  0001 C CNN
F 1 "GND" H 6550 4280 30  0001 C CNN
	1    6550 4350
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 4BD06D4B
P 7800 2600
F 0 "C5" H 7850 2700 50  0000 L CNN
F 1 ".1uF" H 7850 2500 50  0000 L CNN
	1    7800 2600
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 4BD06D33
P 5400 2600
F 0 "R2" V 5480 2600 50  0000 C CNN
F 1 "4.7k" V 5400 2600 50  0000 C CNN
	1    5400 2600
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 4BD06D2B
P 7350 2600
F 0 "R3" V 7430 2600 50  0000 C CNN
F 1 "4.7k" V 7350 2600 50  0000 C CNN
	1    7350 2600
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG011
U 1 1 4BD0676D
P 3050 1700
F 0 "#FLG011" H 3050 1970 30  0001 C CNN
F 1 "PWR_FLAG" H 3050 1930 30  0000 C CNN
	1    3050 1700
	1    0    0    -1  
$EndComp
$Comp
L JACK_2P J1
U 1 1 4BD066B1
P 2350 1500
F 0 "J1" H 2000 1300 60  0000 C CNN
F 1 "JACK_2P" H 2200 1750 60  0000 C CNN
	1    2350 1500
	1    0    0    -1  
$EndComp
$Comp
L LED D2
U 1 1 4BD064F4
P 6400 1550
F 0 "D2" H 6400 1650 50  0000 C CNN
F 1 "LED" H 6400 1450 50  0000 C CNN
	1    6400 1550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR012
U 1 1 4BD06586
P 4600 1900
F 0 "#PWR012" H 4600 1900 30  0001 C CNN
F 1 "GND" H 4600 1830 30  0001 C CNN
	1    4600 1900
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR013
U 1 1 4BD0657D
P 6400 1350
F 0 "#PWR013" H 6400 1450 30  0001 C CNN
F 1 "VDD" H 6400 1460 30  0000 C CNN
	1    6400 1350
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4BD064E7
P 6150 1750
F 0 "R1" V 6230 1750 50  0000 C CNN
F 1 "180R" V 6150 1750 50  0000 C CNN
	1    6150 1750
	0    1    1    0   
$EndComp
$Comp
L LM7805 U1
U 1 1 4BD064BC
P 4600 1400
F 0 "U1" H 4750 1204 60  0000 C CNN
F 1 "LM2940-3.3" H 4600 1600 60  0000 C CNN
	1    4600 1400
	1    0    0    -1  
$EndComp
$Comp
L CP1 C4
U 1 1 4BD064A0
P 5600 1550
F 0 "C4" H 5650 1650 50  0000 L CNN
F 1 "100uF" H 5650 1450 50  0000 L CNN
	1    5600 1550
	1    0    0    -1  
$EndComp
$Comp
L CP1 C2
U 1 1 4BD0649A
P 3950 1550
F 0 "C2" H 4000 1650 50  0000 L CNN
F 1 "100uF" H 4000 1450 50  0000 L CNN
	1    3950 1550
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 4BD06493
P 5200 1550
F 0 "C3" H 5250 1650 50  0000 L CNN
F 1 ".1uF" H 5250 1450 50  0000 L CNN
	1    5200 1550
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4BD0648C
P 3600 1550
F 0 "C1" H 3650 1650 50  0000 L CNN
F 1 ".1uF" H 3650 1450 50  0000 L CNN
	1    3600 1550
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 4BD06474
P 3250 1350
F 0 "D1" H 3250 1450 40  0000 C CNN
F 1 "1N4001" H 3250 1250 40  0000 C CNN
	1    3250 1350
	1    0    0    -1  
$EndComp
$EndSCHEMATC
