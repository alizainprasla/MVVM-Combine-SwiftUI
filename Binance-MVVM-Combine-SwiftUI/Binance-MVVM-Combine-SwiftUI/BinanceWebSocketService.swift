//
//  BinanceWebSocketService.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation
import Starscream
import Combine

protocol SocketClient {
    var textEventPublisher: AnyPublisher<String, Never> { get }
    func connect()
    func disconnect()
}

class StarscreamSocketClient: SocketClient {
    private(set) var socket: WebSocket?
    
    private var host: String
    
    private var eventSubject = PassthroughSubject<WebSocketEvent, Never>()
    
    var textEventPublisher: AnyPublisher<String, Never> {
        eventSubject
            .compactMap { event -> String? in
                if case let .text(value) = event {
                    return value
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    init(host: String) {
        self.host = host
        buildWebSocket()
    }
    
    private func buildWebSocket() {
        let url = URL(string: host)!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.callbackQueue = DispatchQueue(label: "queue.socket.update", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }
    
    func connect() {
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
}

extension StarscreamSocketClient: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        eventSubject.send(event)
    }
}
