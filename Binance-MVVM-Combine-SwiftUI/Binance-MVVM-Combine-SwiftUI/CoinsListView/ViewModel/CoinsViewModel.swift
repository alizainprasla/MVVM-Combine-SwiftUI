//
//  CoinsViewModel.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation
import Combine

class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    var socket: BinanceWebSocketService
    
    init(socket: BinanceWebSocketService) {
        self.socket = socket
    }
    
    func setPrepopulated() {
        let trxMapper = CoinMapper(todoMapperE: "aggTrade", e: 123456789, s: "TRXUSDT", a: 12345, p: "0.001", q: "100", f: 100, l: 105, t: 123456785, todoMapperM: true, m: true)
        let btcMapper = CoinMapper(todoMapperE: "aggTrade", e: 123456789, s: "BTCUSDT", a: 12345, p: "0.001", q: "100", f: 100, l: 105, t: 123456785, todoMapperM: true, m: true)
        
        coins = [Coin(coinMapper: trxMapper),
                 Coin(coinMapper: btcMapper)]
    }
    
    func connectSocket() {
        socket.connect()
        eventUpdate()
    }
    
    func disconnectSocket() {
        socket.disconnect()
    }
    
    func getCoinData(query: String) -> [Coin] {
        if query.isEmpty { return coins }
        return filter(query: query)
    }
    
    private func filter(query: String) -> [Coin] {
        coins.filter{ $0.id.contains(query)  }
    }
    
    private func eventUpdate() {
        self.socket.socket.onEvent = { event in
            switch event {
            case .text(let newText):
                    do {
                        let coin = try JSONDecoder().decode(CoinMapper.self, from: newText.data(using: .utf8)!).toDomain()
                        for (index, updateCoin) in self.coins.enumerated() {
                            if updateCoin.id.lowercased() == coin.id.lowercased() {
                                DispatchQueue.main.async {
                                    self.objectWillChange.send()
                                    self.coins[index] = coin
                                }
                                break
                            }
                        }
                    } catch {
                        print(error)
                    }
                break
            case .disconnected(let response, let status):
                print("Response: \(response)")
                print("Status: \(status)")
                break
            default:
                break
            }
        }
    }
    
}
