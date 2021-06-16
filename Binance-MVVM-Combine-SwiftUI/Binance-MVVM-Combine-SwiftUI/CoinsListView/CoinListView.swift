//
//  ContentView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 15/06/2021.
//

import SwiftUI

struct CoinListView: View {
    
    var socketService: BinanceWebSocketService!
    
    @ObservedObject var viewModel: CoinsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.coins) { coin in
                CoinDetailView(coin: coin)
            }.onAppear(perform: {
                viewModel.setPrepopulated()
                viewModel.connectSocket()
                viewModel.eventUpdate { (coin) in
                    DispatchQueue.main.async {
                        for (index, updateCoin) in viewModel.coins.enumerated() {
                            if updateCoin.id == coin.id {
                                viewModel.coins[index] = coin
                            }
                        }
                    }
                }
            })
        }
    }
    
    init(viewModel: CoinsViewModel) {
        self.viewModel = viewModel
    }
    
    func setupViewModel() {
        viewModel.setPrepopulated()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "wss://stream.binance.com:9443/ws/trxusdt@aggTrade/btcusdt@aggTrade")!
        let socket = BinanceWebSocketService(url: url)
        let vm = CoinsViewModel(socket: socket)
        CoinListView(viewModel: vm)
    }
}
