%ADVANCED METHODS FOR INFORMATION REPRESENTATION
%Lab_2

%NOTES: useful tools
%sptool
%spectrogram
%fft,stft,cwt
%sound(x,1000)
%scale2freq
%wavemenu

clear all;
close all;
clc;

%Load data
load('cardio100.mat');
w=hamming(2048)';

if 1==0
%Compute the fft of the signals
k1=fftshift(fft(heart100,1000));
k2=fftshift(fft(heart100.*w,1000));
k3=fftshift(fft(heart100));
k4=fftshift(fft(heart100.*w));

figure;
subplot(1,4,1); stem(abs(k1)); ylabel('|k1|'); xlabel('k'); title('fft 1000');
subplot(1,4,2); stem(abs(k2)); ylabel('|k2|'); xlabel('k'); title('fft 1000 + win');
subplot(1,4,3); stem(abs(k3)); ylabel('|k3|'); xlabel('k'); title('fft 2048');
subplot(1,4,4); stem(abs(k4)); ylabel('|k4|'); xlabel('k'); title('fft 2048 + win');

%Square the signals and compute the fft
k1sq=fftshift(fft(heart100.^2,1000));
k2sq=fftshift(fft((heart100.*w).^2,1000));
k3sq=fftshift(fft(heart100.^2));
k4sq=fftshift(fft((heart100.*w).^2));

figure;
subplot(1,4,1); stem(abs(k1sq)); ylabel('|k1sq|'); xlabel('k'); title('fft 1000');
subplot(1,4,2); stem(abs(k2sq)); ylabel('|k2sq|'); xlabel('k'); title('fft 1000 + win');
subplot(1,4,3); stem(abs(k3sq)); ylabel('|k3sq|'); xlabel('k'); title('fft 2048');
subplot(1,4,4); stem(abs(k4sq)); ylabel('|k4sq|'); xlabel('k'); title('fft 2048 + win');

%Recover the frequencies of the main harmonics
N1=1000;
N2=2048;
fc=1000;

m1=find(k1==max(k1));
m2=find(k2==max(k2));
m3=find(k3==max(k3));
m4=find(k4==max(k4));

f1=m1*fc/N1;
f2=m2*fc/N1;
f3=m3*fc/N2;
f4=m4*fc/N2;

m1sq=find(k1sq==max(k1sq));
m2sq=find(k2sq==max(k2sq));
m3sq=find(k3sq==max(k3sq));
m4sq=find(k4sq==max(k4sq));

f1sq=m1sq*fc/N1;
f2sq=m2sq*fc/N1;
f3sq=m3sq*fc/N2;
f4sq=m4sq*fc/N2;

%NOTES: The frequency of the heartbeat estimated roughly from the graph is
%around 7.5 Hz (15 peaks in 2.048 s), here instead the frequency of the
%main harmonic is around 500 Hz. In this case the fft is not useful to extract
%information from our peaks: the main harmonic corresponds to the smaller
%variations inside our signal (that have more energy).
%In fact the Fourier transform of a peak is a constant and
%the transform of a comb of delta is still a comb of delta, but here the
%delta are not uniformally spaced in time and moreover they have not the
%same amplitude, so the expected transform it's nor a constant nor a pure
%comb of delta. The frequencial information of the peaks is spread over
%the spectrum and so we are not able to detect their frequency.
end

%Some tests:
% cfreq=centfrq('mexh',10,'plot');
% a=scal2frq(1,'mexh',1);
% b=scal2frq(1,'mexh',.001);
% c=scal2frq(5,'mexh',.001);
%t=0:0.01:1;
%x=sin(2*pi*10*t);
% save('x.mat','x');

%load('x.mat');
%c=cwt(x,1:32,'mexh','glb'); %contourf(c,8);
%h=cwt(heart100,1:32,'mexh','glb');
x=[1 1 1 1];

d=dwt(x,'dmey');
e=cwt(x,1:4,'dmey');
figure; stem(d);
figure; imagesc(e);
