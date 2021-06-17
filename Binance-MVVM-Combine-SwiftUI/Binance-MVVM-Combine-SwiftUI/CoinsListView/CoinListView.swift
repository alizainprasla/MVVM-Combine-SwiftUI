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
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color(.systemGray6)) 
                    .cornerRadius(8)
            }.onAppear(perform: {
                viewModel.setPrepopulated()
                viewModel.connectSocket()
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



struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "wss://stream.binance.com:9443/ws/trxusdt@aggTrade/btcusdt@aggTrade")!
        let socket = BinanceWebSocketService(url: url)
        let vm = CoinsViewModel(socket: socket)
        CoinListView(viewModel: vm)
    }
}
