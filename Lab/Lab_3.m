%ADVANCED METHODS FOR INFORMATION REPRESENTATION
%Lab_3

clear all;
close all;
clc;

%Load data
load('cardio100.mat');

g0=1/(4*sqrt(2))*[(1+sqrt(3)), (3+sqrt(3)), (3-sqrt(3)), (1-sqrt(3))];
h0=1/(4*sqrt(2))*[(1-sqrt(3)), (3-sqrt(3)), (3+sqrt(3)), (1+sqrt(3))];
g1=1/(4*sqrt(2))*[0, -(1-sqrt(3)), (3-sqrt(3)), -(3+sqrt(3)), (1+sqrt(3))];
h1=1/(4*sqrt(2))*[(1+sqrt(3)), -(3+sqrt(3)), (3-sqrt(3)), -(1-sqrt(3)), 0];

figure;
subplot(2,2,1); stem(g0); title('g_0(n)');
subplot(2,2,2); stem(h0); title('h_0(n)');
subplot(2,2,3); stem(g1); title('g_1(n)');
subplot(2,2,4); stem(h1); title('h_1(n)');