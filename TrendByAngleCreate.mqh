//+------------------------------------------------------------------+
//| Создает линию тренда по углу                                     |
//+------------------------------------------------------------------+
bool TrendByAngleCreate(
                        datetime              time=0,            // время точки
                        double                price=0,           // цена точки
                        double                angle=45.0,        // угол наклона
                        color                 clr=clrRed,        // цвет линии
                        string                name="TrendLine",  // имя линии
                        const long            chart_ID=0,        // ID графика
                        const int             sub_window=0,      // номер подокна
                        const ENUM_LINE_STYLE style=STYLE_SOLID, // стиль линии
                        const int             width=2,           // толщина линии
                        const bool            back=false,        // на заднем плане
                        const bool            selection=true,    // выделить для перемещений
                        const bool            ray_right=true,    // продолжение линии вправо
                        const bool            hidden=true,       // скрыт в списке объектов
                        const long            z_order=0)         // приоритет на нажатие мышью
  {
//--- для того, чтобы было удобно перемещать трендовую линию мышью, создадим вторую точку
   datetime time2=0;
   double   price2=0;
//--- установим координаты точек привязки, если они не заданы
   //ChangeTrendEmptyPoints(time,price,time2,price2);
//--- сбросим значение ошибки
   ResetLastError();
//--- строим трендовую линию по 2-ум точкам
   if(!ObjectCreate(chart_ID,name,OBJ_TRENDBYANGLE,sub_window,time,price,time2,price2))
     {
      Print(__FUNCTION__,
            ": не удалось создать линию тренда! Код ошибки = ",GetLastError());
      return(false);
     }
//--- изменяем угол наклона трендовой линии; в процессе изменения угла, координата второй
//--- точки линии переопределится автоматически в соответствии с новым значением угла
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- установим цвет линии
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- установим стиль линии
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
//| Изменяет координаты точки привязки линии тренда                  |
//+------------------------------------------------------------------+
bool TrendPointChange(const long   chart_ID=0,       // ID графика
                      const string name="TrendLine", // имя линии
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
//| Изменяет угол наклона линии тренда                               |
//+------------------------------------------------------------------+
bool TrendAngleChange(const long   chart_ID=0,       // ID графика
                      const string name="TrendLine", // имя линии тренда
                      const double angle=45)         // угол наклона линии тренда
  {
//--- сбросим значение ошибки
   ResetLastError();
//--- изменим угол наклона линии тренда
   if(!ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle))
     {
      Print(__FUNCTION__,
            ": не удалось изменить угол наклона линии! Код ошибки = ",GetLastError());
      return(false);
     }
//--- успешное выполнение
   return(true);
  }
//+------------------------------------------------------------------+
//| Удаляет линию тренда                                             |
//+------------------------------------------------------------------+
bool TrendDelete(const long   chart_ID=0,       // ID графика
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
//void ChangeTrendEmptyPoints(datetime &time1,double &price1,
//                            datetime &time2,double &price2)
//  {
////--- если время первой точки не задано, то она будет на текущем баре
//   if(!time1)
//      time1=TimeCurrent();
////--- если цена первой точки не задана, то она будет иметь значение Bid
//   if(!price1)
//      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
////--- установим координаты второй, вспомогательной точки
////--- вторая точка будет лежать левее на 9 баров и иметь ту же цену
//   datetime second_point_time[10];
//   CopyTime(Symbol(),Period(),time1,10,second_point_time);
//   time2=second_point_time[0];
//   price2=price1;
//  }