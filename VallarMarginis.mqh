#include "ArrowDownCreate.mqh"
#include "ArrowUpCreate.mqh"
#include "Fibo.mqh"
#include "FiboFanCreate.mqh"
#include "FridayMonday.mqh"
#include "Impulses.mqh"
#include "LineCreate.mqh"
#include "Mashenka.mqh"
#include "RectangleCreate.mqh"
#include "SearchExtremum.mqh"
#include "VallarMarginis.mqh"
#include "Variables.mqh"
#include "Random.mqh"
#include "TextCreate.mqh"


void VallarMarginis () {
   NKZ_DOWN(max,maxTime);
   NKZ_UP(min,minTime);
}
void NKZ_UP (double NKZ_price, datetime NKZ_datetime, string name = "NKZ_UP", color clr = clrGreenYellow) {
   double i = Maintenance/monthSpreads*0.00001;
   double j,k,j12,k12,j14,k14;
   datetime l;
   //if (l2==NULL) {
   //l2 = NKZ_datetime+24*60*60*7;
   //Print (l2);
   //}
   j = NKZ_price + i;
   j12 = NKZ_price + i/2;
   j14 = NKZ_price + i/4;
   k = j + i*0.1;
   k12 = j12 + i/2*0.1;
   k14 = j14 + i/4*0.1;
   l = NKZ_datetime;
   //if (maxTime > NKZ_datetime) {
   //l2 = maxTime;
   //}
   
   RectangleCreate (l,j,l2,k,name + " 1:1 " + j + " " + l , clr);
   RectangleCreate (l,j12,l2,k12,name + " 1:2 " + j12 + " " + l, clr);
   RectangleCreate (l,j14,l2,k14,name + " 1:4 " + j14 + " " + l, clr);
   impulseUrovUp12 = k12;
}

void NKZ_DOWN (double NKZ_price, datetime NKZ_datetime,string name = "NKZ_DOWN", color clr = clrBlue) {
   double i = Maintenance/monthSpreads*0.00001;
   double j,k,j12,k12,j14,k14;
   datetime l;
   //if (l2==NULL) {
   //l2 = NKZ_datetime+24*60*60*7;
   //Print (l2);
   //}
   j = NKZ_price - i;
   j12 = NKZ_price - i/2;
   j14 = NKZ_price - i/4;
   k = j - i*0.1;
   k12 = j12 - i/2*0.1;
   k14 = j14 - i/4*0.1;
   l = NKZ_datetime;
   //if (minTime > NKZ_datetime) {
   //l2 = minTime;
   //}
   
   RectangleCreate (l,j,l2,k,name + " 1:1 " + j + " " + l,clr);
   RectangleCreate (l,j12,l2,k12,name + " 1:2 " + j12 + " " + l,clr);
   RectangleCreate (l,j14,l2,k14,name + " 1:4 " + j14 + " " + l,clr);
   impulseUrovDown12 = k12;
}