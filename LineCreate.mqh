//+------------------------------------------------------------------+
//| Создает линию тренда по заданным координатам                     |
//+------------------------------------------------------------------+
bool LineCreate(datetime              time1=0,           // время первой точки
                 double                price1=0,          // цена первой точки
                 datetime              time2=0,           // время второй точки
                 double                price2=0,          // цена второй точки
                 string                name="TrendLine",  // имя линии
                 const color           clr=clrRed,        // цвет линии
                 const int             width=3,           // толщина линии
                 bool                  hidden=false,       // скрыт в списке объектов
                 long                  chart_ID=0,        // ID графика
                 const int             sub_window=0,      // номер подокна
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // стиль линии
                 const bool            back=false,        // на заднем плане
                 const bool            selection=false,    // выделить для перемещений
                 const bool            ray_right=false,   // продолжение линии вправо
                 const long            z_order=0)         // приоритет на нажатие мышью
  {
//--- установим координаты точек привязки, если они не заданы
   ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- сбросим значение ошибки
   ResetLastError();
//--- создадим трендовую линию по заданным координатам
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
     {
      //Print(__FUNCTION__,
      //      ": не удалось создать линию тренда! Код ошибки = ",GetLastError());
      return(false);
     }
//--- установим цвет линии
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- установим стиль отображения линии
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- установим толщину линии
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- включим (true) или отключим (false) режим перемещения линии мышью
//--- при создании графического объекта функцией ObjectCreate, по умолчанию объект
//--- нельзя выделить и перемещать. Внутри же этого метода параметр selection
//--- по умолчанию равен true, что позволяет выделять и перемещать этот объект
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- включим (true) или отключим (false) режим продолжения отображения линии вправо
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- скроем (true) или отобразим (false) имя графического объекта в списке объектов
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- установим приоритет на получение события нажатия мыши на графике
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Перемещает точку привязки линии тренда                           |
//+------------------------------------------------------------------+
bool TrendPointChange(const long   chart_ID=0,       // ID графика
                      const string name="TrendLine", // имя линии
                      const int    point_index=0,    // номер точки привязки
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
//--- переместим точку привязки линии тренда
   if(!ObjectMove(chart_ID,name,point_index,time,price))
     {
      Print(__FUNCTION__,
            ": не удалось переместить точку привязки! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Функция удаляет линию тренда с графика.                          |
//+------------------------------------------------------------------+
bool LineDelete(const long   chart_ID=0,       // ID графика
                 const string name="TrendLine") // имя линии
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- удалим линию тренда
   if(!ObjectDelete(chart_ID,name))
     {
      Print(__FUNCTION__,
            ": не удалось удалить линию тренда! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Проверяет значения точек привязки линии тренда и для пустых      |
//| значений устанавливает значения по умолчанию                     |
//+------------------------------------------------------------------+
void ChangeTrendEmptyPoints(datetime &time1,double &price1,
                            datetime &time2,double &price2)
  {
//--- если время первой точки не задано, то она будет на текущем баре
   if(!time1)
      time1=TimeCurrent();
//--- если цена первой точки не задана, то она будет иметь значение Bid
   if(!price1)
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- если время второй точки не задано, то она лежит на 9 баров левее второй
   if(!time2)
     {
      //--- массив для приема времени открытия 10 последних баров
      datetime temp[10];
      CopyTime(Symbol(),Period(),time1,10,temp);
      //--- установим вторую точку на 9 баров левее первой
      time2=temp[0];
     }
//--- если цена второй точки не задана, то она совпадает с ценой первой точки
   if(!price2)
      price2=price1;
  }
  
////////////////////////////////////////////  