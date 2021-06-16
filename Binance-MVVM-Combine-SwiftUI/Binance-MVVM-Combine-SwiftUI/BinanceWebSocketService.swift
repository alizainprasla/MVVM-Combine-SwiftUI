//
//  BinanceWebSocketService.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation
import Starscream


class BinanceWebSocketService {
    
    var url: URL
    var socket: WebSocket
    
    init(url: URL) {
        self.url = url
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    func connect() {
        socket.connect()
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

