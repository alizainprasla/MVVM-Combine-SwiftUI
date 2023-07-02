//
//  BinanceWebSocketService.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation
import Starscream


class BinanceWebSocketService {
    private var host = "wss://stream.binance.com:9443/ws/"
    
    private var url: URL
    
    var socket: WebSocket
    
    static var coinNames: [String] = [
            "TRXUSDT",
            "BTCUSDT",
            "DGBUSDT",
            "XLMUSDT",
            "DOTUSDT",
            "LINKUSDT",
            "ADAUSDT",
            "LINKUSDT",
            "CAKEUSDT",
            "XRPUSDT",
            "COTIUSDT",
            "XRPUSDT"]
    
    init(host: String) {
        
        self.host = host
        let coinsName = BinanceWebSocketService.coinNames
        for (index, name) in coinsName.enumerated() {
            if index == coinsName.count - 1 {
                self.host.append("\(name.lowercased())@aggTrade")
            } else {
                self.host.append("\(name.lowercased())@aggTrade/")
            }
        }
        
        self.url = URL(string: self.host)!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.callbackQueue = DispatchQueue(label: "queue.socket.update", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
}

extension BinanceWebSocketService: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print("connected \(event)")
        switch event {
        case .connected(_):
            break
        case .disconnected(_, _):
            break
        case .text(_):
            break
        case .binary(_):
            break
        case .pong(_):
            break
        case .ping(_):
            break
        case .error(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        }
    }

}

