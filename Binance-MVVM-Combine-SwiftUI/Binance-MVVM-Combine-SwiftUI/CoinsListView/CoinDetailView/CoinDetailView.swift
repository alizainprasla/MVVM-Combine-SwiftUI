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
            .padding()
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(coin.price).bold()
                    .lineLimit(1)

                Text("$\(coin.price)")
                    .lineLimit(1)
                    .font(.footnote)
            }
            
            Spacer()

            Text("+0.02%")
                .background(Color(.systemRed))
                .cornerRadius(3)
                .padding()
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
//        {
//          "e": "aggTrade",  // Event type
//          "E": 123456789,   // Event time
//          "s": "BNBBTC",    // Symbol
//          "a": 12345,       // Aggregate trade ID
//          "p": "0.001",     // Price
//          "q": "100",       // Quantity
//          "f": 100,         // First trade ID
//          "l": 105,         // Last trade ID
//          "T": 123456785,   // Trade time
//          "m": true,        // Is the buyer the market maker?
//          "M": true         // Ignore
//        }
        
        let coinMapper = CoinMapper(todoMapperE: "aggTrade", e: 123456789, s: "BNBBTC", a: 12345, p: "0.001", q: "100", f: 100, l: 105, t: 123456785, todoMapperM: true, m: true)
        let coin1 = Coin(coinMapper: coinMapper) //Coin(id: "TRXUSDT",timestamp: 0, open: "13443.00032", closed: "3")

        Group {
            CoinDetailView(coin: coin1)
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
