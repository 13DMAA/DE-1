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

void Mashenka () {
      if (minI>maxI) {
      iMA(NULL,0,ArraySize(Array2M) - minI,0,MODE_SMA,PRICE_CLOSE,0);
      }
      if (maxI>minI) {
      for (int i=maxI, j=ArraySize(Array2M)-1-maxI;i<ArraySize(Array2M)-1;i++,j--) {
      LineCreate(Array2M[i].time,iMA(NULL,0,ArraySize(Array2M) - maxI,0,MODE_SMA,PRICE_CLOSE,j),Array2M[i+1].time,iMA(NULL,0,ArraySize(Array2M) - maxI,0,MODE_SMA,PRICE_CLOSE,j-1),"iMA "+ i,clrAqua,1);
      }
      Print ("Период по свечам для Машеньки: " + (ArraySize(Array2M) - maxI));
      }
}