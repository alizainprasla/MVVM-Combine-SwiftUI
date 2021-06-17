//
//  ContentView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 15/06/2021.
//

import SwiftUI

struct CoinListView: View {
    
    var socketService: BinanceWebSocketService!
    @State private var searchText = ""
    @ObservedObject var viewModel: CoinsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText)
                    .navigationTitle("Coin List")
                List(viewModel.coins.filter({searchText.isEmpty ? true : $0.id.contains(searchText)})) { coin in
                    CoinDetailView(coin: coin)
                }.onAppear(perform: {
                    viewModel.setPrepopulated()
                    viewModel.connectSocket()
                })
            }
        }
        .navigationBarTitleDisplayMode(.large)
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
