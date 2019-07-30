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

void FridayPause () {
   for (int i = 0; i<ArraySize(Array2M); i++) {
      if (i==0) {
         int j = 0, k = 0;
         bool P = false;
      }
      if (TimeDayOfWeek(Array2M[i].time) == 1 || TimeDayOfWeek(Array2M[i].time) == 5) {
         if (j == 0) {
            k = i;
            j++;
            P = true;
         }
      }
      else if (P){
         RectangleCreate (Array2M[k].time,0.5,Array2M[i++].time,3,"FridayMonday "+i,clrDarkGray);
         j=0;
         P = false;
      }
   }
}