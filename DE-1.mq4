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
#include "Random.mqh"
#include "TextCreate.mqh"
#include "Variables.mqh"
#include "TrendByAngleCreate.mqh"


int OnInit()
  {
  //TrendByAngleCreate (D'2019.06.25 04:00',1.1412,270);//3 дня!!!!
  
  //LineCreate(D'25.07.2019',1.14,D'25.07.2019'+24*60*60*3,1.14,"TEST!!!",clrAqua,5);
   CopyRates(Symbol(),Period(),TimeCurrent(),TimeCurrent()-(60*60*24*60),Array2M);//копируем в массив
   //FridayPause();
   SearchExtremum();
   //VallarMarginis();
   Impulses();
   Fibo();
   Mashenka();
   //Impulses();
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason) 
  { 
//--- удалим с графика комментарии при завершении работы  
   ObjectsDeleteAll(0,"Text",0,OBJ_TEXT);   ObjectsDeleteAll(0,"IMPULSE",0,OBJ_TREND);
   ObjectsDeleteAll(0,"NKZ",0,OBJ_ARROW);   ObjectsDeleteAll(0,"IMPULSE",0,OBJ_TREND);
   ObjectsDeleteAll(0,"Trend",0,OBJ_TREND);
   ObjectsDeleteAll(0,"Trend",0,OBJ_TREND);
   ObjectsDeleteAll(0,"Line",0,OBJ_TREND);
   ObjectsDeleteAll(0,"Fibo",0,OBJ_FIBOFAN);
   ObjectsDeleteAll(0,"NKZ",0,OBJ_RECTANGLE);
   ObjectsDeleteAll(0,"Vallar",0,OBJ_RECTANGLE);
   ObjectsDeleteAll(0,"FridayMonday",0,OBJ_RECTANGLE);
   Comment(""); 
  } 

void OnTick()
  {
   Comment (TimeToStr(Array2M[ArraySize(Array2M)-1].time),"\n",
   Period(),"\n",
   "Клининговый час = ","\n",
   l2,"\n");
   //Alert ("!!!");
   SearchExtremum();
   Impulses();
   Fibo();
   Mashenka();
  }