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

void Impulses () {
int i, j;
double impulsesMin, impulsesMax;
bool impulse = false;
   if (maxTime > minTime) {
         trend = true;
         trendPrice = Array2M[minI].low;
         trendTime = Array2M[minI].time;
         impulsesMin = trendPrice;
         j=minI;
      }
      else {
         trend = false;
         trendPrice = Array2M[maxI].high;
         trendTime = Array2M[maxI].time;
         impulsesMax = trendPrice;
         j=maxI;
      }
      
      for (i = j, trendPriceNew = trendPrice; i < ArraySize(Array2M); i++) {
         //if (i == j) {
         //TextCreate ("START",Array2M[i].time,Array2M[i].high+0.00100,"Text"+i);
         //}
         if (TimeHour(Array2M[i].time)>=0 && TimeHour(Array2M[i].time)<=1) {
         LineCreate(Array2M[i].time,0.1,Array2M[i].time,2,"HOUR "+Array2M[i].time,clrGray,3,true);
         }
         if (trend && Array2M[i].high >= trendPriceNew) {
         trendPriceNew = Array2M[i].high;
         //impulsesEnd = trendPriceNew;
         trendPriceNewTime = Array2M[i].time;
         l2 = TimeCurrent();
         NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendPrice);
            if (!impulse && trendPriceNew > impulsesMax) {
            impulse = true;
            }
            if (!impulse && impulseUrovUp12!=NULL && impulseUrovUp12>0 && Array2M[i].close>impulseUrovUp12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
            impulse = true;
            ArrowDownCreate(Array2M[i].time,Array2M[i].close,"NKZ_Probitie1/2"+ TimeToStr(Array2M[i].time));
            TextCreate(DoubleToStr(impulseUrovUp12),Array2M[i].time,Array2M[i].high + 0.01000,"Text" + i,90);
            }
         }
         if (trend && (trendPriceNew-Array2M[i].high)>raznica) {
            if (ObjectsDeleteAll(0,"NKZ_UP "+ trendPrice,0,OBJ_RECTANGLE)) {
            //Print ("NKZ_UP "+ trendPrice + " DELETE!");
            }
            else
            {
            Print(__FUNCTION__,
            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
            }
            if (!impulse){
            LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime),clrGreenYellow);
            }
            if (impulse && l2!= NULL) {
            l2 = trendPriceNewTime;
            LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime),clrViolet,5);
            impulsesMax = trendPriceNew;
            impulse = false;
            NKZ_UP(trendPrice,trendTime,"NKZ_UP "+ trendPrice);
            }
         trendPrice = trendPriceNew;
         trendTime = trendPriceNewTime;
         trend = false;
         }
         
         if (!trend && Array2M[i].low <= trendPriceNew) {
         trendPriceNew = Array2M[i].low;
         //impulsesEnd = trendPriceNew;
         trendPriceNewTime = Array2M[i].time;
         l2 = TimeCurrent();
         NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendPrice);
            if (!impulse && trendPriceNew < impulsesMin) {
            impulse = true;
            }
            if (!impulse && impulseUrovDown12!=NULL && Array2M[i].close < impulseUrovDown12 && TimeHour(trendPriceNewTime)>=0 && TimeHour (trendPriceNewTime)<1) {
            impulse = true;
            ArrowUpCreate(Array2M[i].time,Array2M[i].close,"NKZ_Probitie1/2"+ TimeToStr(Array2M[i].time));
            TextCreate(DoubleToStr(impulseUrovDown12),Array2M[i].time,Array2M[i].low - 0.01000,"Text" + i,90);
            }
         }
         
         if (!trend && (Array2M[i].low-trendPriceNew)>raznica) {
            if (ObjectsDeleteAll(0,"NKZ_DOWN "+ trendPrice,0,OBJ_RECTANGLE)) {
            //Print ("NKZ_DOWN "+ trendPrice + " DELETE!");
            }
            else
            {
            Print(__FUNCTION__,
            ": не удалось удалить \"НКЗ\"! Код ошибки = ",GetLastError());
            }
            if (!impulse) {
            LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"Trend "+trend+" "+TimeToStr(trendTime),clrRed);
            }
            if (impulse && l2!=NULL) {
            l2 = trendPriceNewTime;
            LineCreate(trendTime,trendPrice,trendPriceNewTime,trendPriceNew,"IMPULSE "+trend+" "+TimeToStr(trendTime),clrViolet,5);
            impulsesMin = trendPriceNew;
            impulse = false;
            NKZ_DOWN(trendPrice,trendTime,"NKZ_DOWN "+ trendPrice);
            }
         trendPrice = trendPriceNew;
         trendTime = trendPriceNewTime;
         trend = true;
         }
      }
}