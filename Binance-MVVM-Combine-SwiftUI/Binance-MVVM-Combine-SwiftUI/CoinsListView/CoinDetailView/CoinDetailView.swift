//
//  CoinDetailView.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import SwiftUI

struct CoinDetailView: View {
    
    @ObservedObject var coin: Coin
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(coin.id).font(.footnote)
            Text("$\(coin.open)").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let coin = Coin(id: "trxusdt",timestamp: 0, open: "", closed: "")
        CoinDetailView(coin: coin)
    }
}
