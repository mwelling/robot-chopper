close all
clear all
clc
m = 5;
b = .1;
inputforce = 1;
num = 1/m;
den = [1 b/m];
plant = tf(num*1,den);
step(plant)