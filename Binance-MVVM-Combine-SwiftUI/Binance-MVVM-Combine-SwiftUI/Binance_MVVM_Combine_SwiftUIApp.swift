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
            let url = URL(string: "wss://stream.binance.com:9443/ws/trxusdt@aggTrade/btcusdt@aggTrade")!
            let socket = BinanceWebSocketService(url: url)
            let vm = CoinsViewModel(socket: socket)
            CoinListView(viewModel: vm)
            
//            TestView()
        }
    }
}
