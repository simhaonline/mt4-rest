#property version   "1.00"
#property strict

#include <RestApi.mqh>

input string   host = "http://192.168.88.241";
input int      port = 80;
input int      commandWaitTimeout = 10;
input int      commandPingMilliseconds = 10;

enum RiskCalc {
  RiskEquity = 1, // Equity
  RiskBalance = 2, // Balance
  RiskFreeMargin = 2, // Free Margin
};
input RiskCalc RiskPercentCalculation = RiskEquity; // Risk % Calculation
input bool HedgingRestricted = true; // Hedging Restricted
input bool FIFORestricted = true; // FIFO Restricted

input string AllowedIPs = "127.0.0.1;192.168.119.6;192.168.88.241;52.89.214.238;34.212.75.30;54.218.53.128;52.32.178.7";

CRestApi api;

int OnInit() {

  api.Init(host, port, commandWaitTimeout);
  api.SetIPsAllowed(AllowedIPs);
  
  EventSetMillisecondTimer(commandPingMilliseconds );
  
  return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
  EventKillTimer();
}

void OnTick() {

}

void OnTimer() {
   api.Processing();
}