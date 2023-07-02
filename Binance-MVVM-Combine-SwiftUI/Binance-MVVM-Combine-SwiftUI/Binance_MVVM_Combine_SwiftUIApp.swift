//
//  Binance_MVVM_Combine_SwiftUIApp.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 15/06/2021.
//

import SwiftUI

@main
struct Binance_MVVM_Combine_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            
            //wss://stream.binance.com:9443/ws/TRXUSDT@aggTrade/BTCUSDT@aggTrade/DGBUSDT@aggTrade/XLMUSDT@aggTrade/DOTUSDT@aggTrade/LINKUSDT@aggTrade/ADAUSDT@aggTrade/LINKUSDT@aggTrade/CAKEUSDT@aggTrade/XRPUSDT@aggTrade/COTIUSDT@aggTrade/XRPUSDT@aggTrade/
            
            let host = "wss://stream.binance.com:9443/ws/trxusdt@aggTrade/btcusdt@aggTrade"
            let socket = BinanceWebSocketService(host: host)
            let vm = CoinsViewModel(socket: socket)
            CryptoMarketView(viewModel: vm)
        }
    }
}
