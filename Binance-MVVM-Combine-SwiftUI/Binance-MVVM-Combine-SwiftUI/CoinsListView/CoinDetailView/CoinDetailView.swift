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
        HStack {
            VStack(alignment: .leading) {
                Text(coin.id).bold()
                Text("Vol \(coin.quantity)M")
                    .lineLimit(1)
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(coin.price).bold().lineLimit(1)
                Text("$\(coin.price)").lineLimit(1).font(.footnote)
            }
            
            Spacer()
            
       
            Text("+0.02%")
                .font(.subheadline)
                .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                .background(Color(.systemRed))
                .cornerRadius(5)
          
            
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let coinMapper = CoinMapper(todoMapperE: "aggTrade",
                                    e: 123456789, s: "BNBBTC",
                                    a: 12345, p: "0.56999999",
                                    q: "100",
                                    f: 100,
                                    l: 105,
                                    t: 123456785,
                                    todoMapperM: true,
                                    m: true)
        let coin1 = Coin(coinMapper: coinMapper)
        Group {
            CoinDetailView(coin: coin1)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
