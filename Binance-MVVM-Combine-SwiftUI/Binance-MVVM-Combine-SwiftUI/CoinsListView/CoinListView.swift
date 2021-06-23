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
    @State private var defaultSelected: Coin?
    @ObservedObject var viewModel: CoinsViewModel
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                SearchBarView(text: $searchText)
                
                List(viewModel.getCoinData(query: searchText)) { coin in
                    NavigationLink(
                        destination: CoinDetailScreenView(coin: $defaultSelected)) {
                        CoinDetailView(coin: coin)
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear(perform: {
                    viewModel.setPrepopulated()
                    viewModel.connectSocket()
                    defaultSelected = viewModel.coins.first
                })
                .navigationBarHidden(true)
            }
            
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
        Group {
            let host = "wss://stream.binance.com:9443/ws/"
            let socket = BinanceWebSocketService(host: host)
            let vm = CoinsViewModel(socket: socket)
            CoinListView(viewModel: vm)
        }
        
    }
}
