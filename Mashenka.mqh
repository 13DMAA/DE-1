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
      iMA(NULL,0,ArraySize(Array2M) - maxI,0,MODE_SMA,PRICE_CLOSE,100);
      }
}