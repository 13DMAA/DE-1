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

void Fibo () {
   //if (minI>maxI) {
      FiboFanCreate(minTime,min,minTime+86400*3,min+0.0045977,"Fibo "+ min);
      FiboFanLevelsSet(4,FiboArray,"Fibo "+ min);
      //}
      //if (maxI>minI) {
      FiboFanCreate(maxTime,max,maxTime+86400*3,max-0.0045977,"Fibo "+ max);
      FiboFanLevelsSet(4,FiboArray,"Fibo "+ max);
      //}
}