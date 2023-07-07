//
//  BinanceTickerUseCase.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Alizain on 03/07/2023.
//

import Foundation
import Combine

protocol TickerUseCase {
    var coinPublisher: AnyPublisher<Coin, Never> { get }
    func start()
    func stop()
}

class BinanceTickerUseCase: TickerUseCase {
    private let client: SocketClient
    private let dataConverter: BinanceDataConverterProtocol
    private var cancellables = Set<AnyCancellable>()
    private let coinSubject = PassthroughSubject<Coin, Never>()
    var coinPublisher: AnyPublisher<Coin, Never> {
        coinSubject.eraseToAnyPublisher()
    }
    
    init(service: SocketClient, dataConverter: BinanceDataConverterProtocol) {
        self.client = service
        self.dataConverter = dataConverter
    }
    
    func start() {
        client.connect()
        setupTickerUpdatePublisher()
    }
    
    func setupTickerUpdatePublisher() {
        client.textEventPublisher
            .compactMap(dataConverter.convertData(_:))
            .throttle(for: 1, scheduler: RunLoop.current, latest: false)
            .sink { value in
                self.coinSubject.send(value)
            }
            .store(in: &cancellables)
    }
    
    func stop() {
        client.disconnect()
    }
}
