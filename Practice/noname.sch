EESchema Schematic File Version 2  date 4/21/2010 10:17:25 PM
LIBS:DavidGitzKiCadLibrary
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
LIBS:noname-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title ""
Date "22 apr 2010"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 6150 2900
Wire Wire Line
	6150 2900 7700 2900
Wire Wire Line
	7700 2900 7700 2600
Wire Wire Line
	7700 2600 8950 2600
Connection ~ 6550 4100
Wire Wire Line
	6550 4450 6550 3900
Wire Wire Line
	6550 3900 7500 3900
Wire Wire Line
	7200 4300 7200 4800
Wire Wire Line
	7200 4300 7500 4300
Wire Wire Line
	5850 4600 6750 4600
Wire Wire Line
	6750 4600 6750 4500
Wire Wire Line
	6750 4500 7500 4500
Wire Wire Line
	7500 4700 7000 4700
Wire Wire Line
	7000 4700 7000 2450
Wire Wire Line
	6550 4100 5850 4100
Wire Wire Line
	6550 4400 6450 4400
Connection ~ 6150 2450
Wire Wire Line
	6150 2350 6150 3500
Wire Wire Line
	5850 3500 5850 2300
Wire Wire Line
	4250 4000 3850 4000
Wire Wire Line
	4250 3500 3850 3500
Wire Wire Line
	4250 4600 3300 4600
Wire Wire Line
	3300 4600 3300 5550
Wire Wire Line
	4250 4900 2300 4900
Wire Wire Line
	2300 4900 2300 4500
Wire Wire Line
	2400 4500 2400 5000
Wire Wire Line
	4900 2350 4200 2350
Wire Wire Line
	4900 2350 4900 2050
Wire Wire Line
	4200 2350 4200 2700
Wire Wire Line
	4200 2700 4250 2700
Wire Wire Line
	2400 4500 2650 4500
Wire Wire Line
	2650 4500 2650 2450
Wire Wire Line
	2650 2450 5000 2450
Wire Wire Line
	4250 4700 2200 4700
Wire Wire Line
	2200 4700 2200 4500
Wire Wire Line
	3100 5550 3100 5000
Wire Wire Line
	3100 5000 2400 5000
Wire Wire Line
	3200 5550 3200 4800
Wire Wire Line
	3200 4800 4250 4800
Wire Wire Line
	3850 3900 4250 3900
Wire Wire Line
	4250 4400 3850 4400
Wire Wire Line
	5850 3900 6150 3900
Wire Wire Line
	5200 2050 5500 2050
Wire Wire Line
	5500 2050 5500 2450
Connection ~ 5500 2450
Wire Wire Line
	5850 4400 6050 4400
Connection ~ 6550 4400
Wire Wire Line
	7500 4600 6850 4600
Wire Wire Line
	6850 4600 6850 4700
Wire Wire Line
	6850 4700 5850 4700
Wire Wire Line
	7500 4400 7100 4400
Wire Wire Line
	7100 4400 7100 4900
Wire Wire Line
	7100 4900 5850 4900
Wire Wire Line
	7200 4800 5850 4800
Wire Wire Line
	6500 2800 6150 2800
Connection ~ 6150 2800
Wire Wire Line
	5400 2450 8250 2450
Wire Wire Line
	8250 2450 8250 3050
Wire Wire Line
	8250 3050 8950 3050
Connection ~ 7000 2450
$Comp
L PROPELLER U?
U 1 1 4BCFBF96
P 9750 2750
F 0 "U?" H 9800 2700 60  0000 C CNN
F 1 "PROPELLER" H 9800 2700 60  0000 C CNN
	1    9750 2750
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG01
U 1 1 4BCF82AB
P 6500 2800
F 0 "#FLG01" H 6500 3070 30  0001 C CNN
F 1 "PWR_FLAG" H 6500 3030 30  0000 C CNN
	1    6500 2800
	1    0    0    -1  
$EndComp
NoConn ~ 7500 4200
NoConn ~ 7500 4100
NoConn ~ 7500 4000
NoConn ~ 5100 2050
NoConn ~ 5000 2050
$Comp
L PWR_FLAG #FLG02
U 1 1 4BCF6475
P 4200 2350
F 0 "#FLG02" H 4200 2620 30  0001 C CNN
F 1 "PWR_FLAG" H 4200 2580 30  0000 C CNN
	1    4200 2350
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG03
U 1 1 4BCF6472
P 5850 2300
F 0 "#FLG03" H 5850 2570 30  0001 C CNN
F 1 "PWR_FLAG" H 5850 2530 30  0000 C CNN
	1    5850 2300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 4BCF6467
P 4200 2700
F 0 "#PWR04" H 4200 2700 30  0001 C CNN
F 1 "GND" H 4200 2630 30  0001 C CNN
	1    4200 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 4BCF6463
P 6550 4450
F 0 "#PWR05" H 6550 4450 30  0001 C CNN
F 1 "GND" H 6550 4380 30  0001 C CNN
	1    6550 4450
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR06
U 1 1 4BCF6453
P 6150 2350
F 0 "#PWR06" H 6150 2440 20  0001 C CNN
F 1 "+5V" H 6150 2440 30  0000 C CNN
	1    6150 2350
	1    0    0    -1  
$EndComp
$Comp
L MAX232 U1
U 1 1 4BCF642F
P 5050 4200
F 0 "U1" H 5050 5050 70  0000 C CNN
F 1 "MAX232" H 5050 3350 70  0000 C CNN
	1    5050 4200
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 P1
U 1 1 4BCF641C
P 5050 1700
F 0 "P1" V 5000 1700 50  0000 C CNN
F 1 "CONN_4" V 5100 1700 50  0000 C CNN
	1    5050 1700
	0    -1   -1   0   
$EndComp
$Comp
L CONN_3 K2
U 1 1 4BCF640A
P 3200 5900
F 0 "K2" H 3150 5900 50  0000 C CNN
F 1 "CONN_3" V 3250 5900 40  0000 C CNN
	1    3200 5900
	0    1    1    0   
$EndComp
$Comp
L CONN_3 K1
U 1 1 4BCF6407
P 2300 4150
F 0 "K1" V 2250 4150 50  0000 C CNN
F 1 "CONN_3" V 2350 4150 40  0000 C CNN
	1    2300 4150
	0    -1   -1   0   
$EndComp
$Comp
L CP C1
U 1 1 4BCF63E9
P 3850 3700
F 0 "C1" H 3900 3800 50  0000 L CNN
F 1 ".1uF" H 3900 3600 50  0000 L CNN
	1    3850 3700
	1    0    0    -1  
$EndComp
$Comp
L CP C2
U 1 1 4BCF63E5
P 3850 4200
F 0 "C2" H 3900 4300 50  0000 L CNN
F 1 ".1uF" H 3900 4100 50  0000 L CNN
	1    3850 4200
	1    0    0    -1  
$EndComp
$Comp
L CP C4
U 1 1 4BCF63CB
P 6150 3700
F 0 "C4" H 6200 3800 50  0000 L CNN
F 1 ".1uF" H 6200 3600 50  0000 L CNN
	1    6150 3700
	1    0    0    -1  
$EndComp
$Comp
L CP C5
U 1 1 4BCF63C8
P 6250 4400
F 0 "C5" H 6300 4500 50  0000 L CNN
F 1 ".1uF" H 6300 4300 50  0000 L CNN
	1    6250 4400
	0    1    1    0   
$EndComp
$Comp
L CP C3
U 1 1 4BCF63C3
P 5200 2450
F 0 "C3" H 5250 2550 50  0000 L CNN
F 1 ".1uF" H 5250 2350 50  0000 L CNN
	1    5200 2450
	0    1    1    0   
$EndComp
$Comp
L DB9 J1
U 1 1 4BCF6387
P 7950 4300
F 0 "J1" H 7950 4850 70  0000 C CNN
F 1 "DB9" H 7950 3750 70  0000 C CNN
	1    7950 4300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
