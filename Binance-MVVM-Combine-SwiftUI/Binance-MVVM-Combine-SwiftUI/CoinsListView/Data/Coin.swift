//
//  Coin.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation

class Coin: Identifiable, ObservableObject {
    @Published var id: String
    @Published var timestamp: TimeInterval
    @Published var open: String
    @Published var closed: String
    
    init(id: String, timestamp: TimeInterval, open: String, closed: String) {
        self.id = id
        self.timestamp = timestamp
        self.open = open
        self.closed = closed
    }
}


struct CoinMapper: Codable {
    
    let todoMapperE: String
    let e: Int
    let s: String
    let a: Int
    let p, q: String
    let f, l, t: TimeInterval
    let todoMapperM, m: Bool

    enum CodingKeys: String, CodingKey {
        case todoMapperE = "e"
        case e = "E"
        case s, a, p, q, f, l
        case t = "T"
        case todoMapperM = "m"
        case m = "M"
    }
    
    
    func toDomain() -> Coin {
        return Coin(id: s, timestamp: f, open: p, closed: q)
    }
    
}
