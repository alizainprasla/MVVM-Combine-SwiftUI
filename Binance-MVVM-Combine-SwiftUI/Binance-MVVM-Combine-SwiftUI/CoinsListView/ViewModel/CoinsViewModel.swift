//
//  CoinsViewModel.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation


class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    var socket: BinanceWebSocketService
    
    init(socket: BinanceWebSocketService) {
        self.socket = socket
    }
    
    func setPrepopulated() {
        coins = [Coin(id: "TRXUSDT",timestamp: 0, open: "", closed: ""),
                 Coin(id: "BTCUSDT", timestamp: 0, open: "", closed: "")]
    }
    
    func connectSocket() {
        socket.connect()
    }
    
    func objectWillChange(coin: Coin, timestamp: TimeInterval){
        objectWillChange.send()
        coin.timestamp = timestamp
    }
    
    func eventUpdate(completion: @escaping (Coin) -> ()) {
        self.socket.socket.onEvent = { event in
            switch event {
            case .text(let newText):
                do {
                    let coin = try JSONDecoder().decode(CoinMapper.self, from: newText.data(using: .utf8)!)
                    completion(coin.toDomain())
                } catch {
                    print(error)
                }
                break
            default:
                break
            }
        }
    }
    
}
