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
    
    var useCase: TickerUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    var coinNames: [String] = [
        "TRXUSDT",
        "BTCUSDT",
        "DGBUSDT",
        "XLMUSDT"]
    
    init(useCase: TickerUseCase) {
        self.useCase = useCase
        setPrepopulated()
        connectSocket()
    }
    
    func setPrepopulated() {
        for coinName in coinNames {
            let mapper = CoinMapper(todoMapperE: "aggTrade",
                                    e: 123456789,
                                    s: coinName,
                                    a: 12345,
                                    p: "0.001",
                                    q: "100",
                                    f: 100,
                                    l: 105,
                                    t: 123456785,
                                    todoMapperM: true,
                                    m: true)
            coins.append(Coin(coinMapper: mapper))
        }
    }
    
    func connectSocket() {
        useCase.start()
        eventUpdate()
    }
    
    func disconnectSocket() {
        useCase.stop()
    }
    
    func getCoinData(query: String) -> [Coin] {
        if query.isEmpty { return coins }
        return filter(query: query)
    }
    
    private func filter(query: String) -> [Coin] {
        coins.filter{ $0.id.contains(query)  }
    }
    
    private func eventUpdate() {
        useCase
            .coinPublisher
            .sink(receiveValue: updateCoins(updatedCoin:))
            .store(in: &cancellables)
        
    }
    
    private func updateCoins(updatedCoin: Coin) {
        guard let index = coins.firstIndex(where: { $0.id.lowercased() == updatedCoin.id.lowercased() }) else { return }
        
        self.objectWillChange.send()
        self.coins[index] = updatedCoin
    }
}
