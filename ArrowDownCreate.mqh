//+------------------------------------------------------------------+
//| Создает знак "Стрелка вниз"                                      |
//+------------------------------------------------------------------+
bool ArrowDownCreate(datetime                time=0,               // время точки привязки
                     double                  price=0,              // цена точки привязки
                     string                  name="ArrowDown",     // имя знака
                     const long              chart_ID=0,           // ID графика
                     const int               sub_window=0,         // номер подокна
                     const ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // способ привязки
                     const color             clr=clrRed,           // цвет знака
                     const ENUM_LINE_STYLE   style=STYLE_SOLID,    // стиль окаймляющей линии
                     const int               width=5,              // размер знака
                     const bool              back=false,           // на заднем плане
                     const bool              selection=true,       // выделить для перемещений
                     const bool              hidden=true,          // скрыт в списке объектов
                     const long              z_order=0)            // приоритет на нажатие мышью
  {
//--- установим координаты точки привязки, если они не заданы
   ChangeArrowEmptyPoint(time,price);
//--- сбросим значение ошибки
   ResetLastError();
//--- создадим знак
   if(!ObjectCreate(chart_ID,name,OBJ_ARROW_DOWN,sub_window,time,price))
     {
      //Print(__FUNCTION__,
      //      ": не удалось создать знак \"Стрелка вниз\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- способ привязки
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- установим цвет знака
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- установим стиль окаймляющей линии
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- установим размер знака
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- включим (true) или отключим (false) режим перемещения знака мышью
//--- при создании графического объекта функцией ObjectCreate, по умолчанию объект
//--- нельзя выделить и перемещать. Внутри же этого метода параметр selection
//--- по умолчанию равен true, что позволяет выделять и перемещать этот объект
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- скроем (true) или отобразим (false) имя графического объекта в списке объектов
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- установим приоритет на получение события нажатия мыши на графике
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- успешное выполнение
   Print ("Стрелка вниз построена!");
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещает точку привязки                                        |
//+------------------------------------------------------------------+
bool ArrowDownMove(const long   chart_ID=0,       // ID графика
                   const string name="ArrowDown", // имя объекта
                   datetime     time=0,           // координата времени точки привязки
                   double       price=0)          // координата цены точки привязки
  {
//--- если координаты точки не заданы, то перемещаем ее на текущий бар с ценой Bid
   if(!time)
      time=TimeCurrent();
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- сбросим значение ошибки
   ResetLastError();
//--- переместим точку привязки
   if(!ObjectMove(chart_ID,name,0,time,price))
     {
      Print(__FUNCTION__,
            ": не удалось переместить точку привязки! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Меняет способ привязки знака "Стрелка вниз"                      |
//+------------------------------------------------------------------+
bool ArrowDownAnchorChange(const long              chart_ID=0,        // ID графика
                           const string            name="ArrowDown",  // имя объекта
                           const ENUM_ARROW_ANCHOR anchor=ANCHOR_TOP) // способ привязки
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- изменим положение точки привязки
   if(!ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor))
     {
      Print(__FUNCTION__,
            ": не удалось изменить способ привязки! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Удаляет знак "Стрелка вниз"                                      |
//+------------------------------------------------------------------+
bool ArrowDownDelete(const long   chart_ID=0,       // ID графика
                     const string name="ArrowDown") // имя знака
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- удалим знак
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": не удалось удалить знак \"Стрелка вниз\"! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
  
  //+------------------------------------------------------------------+
//| Проверяет значения точки привязки и для пустых значений          |
//| устанавливает значения по умолчанию                              |
//+------------------------------------------------------------------+
void ChangeArrowEmptyPoint(datetime &time,double &price)
  {
//--- если время точки не задано, то она будет на текущем баре
   if(!time)
      time=TimeCurrent();
//--- если цена точки не задана, то она будет иметь значение Bid
   if(!price)
      price=SymbolInfoDouble(Symbol(),SYMBOL_BID);
  }
////////////////////////////////////////////////  
////////////////////////////////////////////  