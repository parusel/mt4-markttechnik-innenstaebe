//+------------------------------------------------------------------+
//|                                                   Innenstäbe.mq4 |
//|                                                     Adam Parusel |
//|                                          https://adamparusel.com |
//+------------------------------------------------------------------+
#property copyright "Adam Parusel"
#property link      "https://adamparusel.com"
#property version   "1.00"
#property strict

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Black
#property indicator_color2 Black

double ExtTop[];
double ExtBottom[];

void OnInit()
{
   SetIndexBuffer(0, ExtTop);
   SetIndexBuffer(1, ExtBottom);   

   SetIndexStyle(0, DRAW_LINE);
   SetIndexStyle(1, DRAW_LINE);

   SetIndexEmptyValue(0, 0.0);
   SetIndexEmptyValue(1, 0.0);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   int i = rates_total-1;
   while(i>0)
   {
//      Print("calculation periode " + i);
      int p = innenstab_periode(i);
      if (p > 0)
      {
         for (int j=0;j<=p;j++)
         {
            ExtTop[i-j] = High[i];
            ExtBottom[i-j] = Low[i];
         }
         i = i - p;
      }
      i--;
   }

   return(rates_total);
}

int innenstab_periode(int s)
{
   double high = High[s];
   double low  = Low[s];
   
   int c = 1;
   
   while (     (Close[s - c] <= high) 
          &&   (Close[s - c] >= low)
          &&   (Open[s - c] <= high)
          &&   (Open[s - c] >= low)
          && (s - c >0))
          c++;
          
   return (c-1);
}
