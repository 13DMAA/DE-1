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
   ObjectsDeleteAll(0,"iMA",0,OBJ_TREND);
   int mashenka_i,mashenka_j, mashenka_period_i;
   if (minI>maxI) {
      mashenka_i = minI;
      mashenka_period_i = minI;
      }
   if (maxI>minI) {
      mashenka_i = maxI;
      mashenka_period_i = maxI;
      }
   for (mashenka_j=ArraySize(Array2M)-1-mashenka_i;mashenka_i<ArraySize(Array2M)-1;mashenka_i++,mashenka_j--) {
      LineCreate(Array2M[mashenka_i].time,iMA(NULL,0,ArraySize(Array2M) - mashenka_period_i,0,MODE_SMA,PRICE_CLOSE,mashenka_j),Array2M[mashenka_i+1].time,iMA(NULL,0,ArraySize(Array2M) - mashenka_period_i,0,MODE_SMA,PRICE_CLOSE,mashenka_j-1),"iMA "+ mashenka_i,clrAqua,1);
      }
//Print ("Период по свечам для Машеньки: " + (ArraySize(Array2M) - mashenka_period_i));
}