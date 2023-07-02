//
//  ContentView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 15/06/2021.
//

import SwiftUI

struct CryptoMarketView: View {
    private var socketService: BinanceWebSocketService!
    
    @State private var searchText = ""
    
    @State private var defaultSelected: Coin?
    
    @ObservedObject var viewModel: CoinsViewModel
    
    init(viewModel: CoinsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(viewModel.getCoinData(query: searchText)) { coin in
                    NavigationLink(
                        destination: CoinDetailScreenView(coin: $defaultSelected)) {
                            CoinDetailView(coin: coin)
                        }
                }
                .listStyle(PlainListStyle())
                .navigationBarHidden(true)
            }
        }
    }
}



struct CryptoMarketView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let host = "wss://stream.binance.com:9443/ws/"
            let socket = BinanceWebSocketService(host: host)
            let vm = CoinsViewModel(socket: socket)
            CryptoMarketView(viewModel: vm)
        }
    }
}
