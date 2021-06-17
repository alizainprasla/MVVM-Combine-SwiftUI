//
//  Coin.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Ali Zain on 16/06/2021.
//

import Foundation

class Coin: Identifiable, ObservableObject {
    
    var coinMapper: CoinMapper
    
    @Published var id: String
    @Published var timestamp: TimeInterval
    @Published var firstTrade: Int
    @Published var lastTrade: Int
    @Published var price: String
    @Published var quantity: String

    init(coinMapper: CoinMapper) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        
        nf.maximumFractionDigits = 5
        nf.minimumFractionDigits = 2
        
        let price = nf.number(from: coinMapper.p)?.stringValue ?? ""
        let volume = nf.number(from: coinMapper.q)?.stringValue ?? ""
        
        self.coinMapper = coinMapper
        self.id = coinMapper.s
        self.timestamp = coinMapper.t
        self.firstTrade = coinMapper.f
        self.lastTrade = coinMapper.l
        self.price = price //coinMapper.p
        self.quantity = volume //coinMapper.q
    }
}


struct CoinMapper: Codable {
    
    let todoMapperE: String
    let e: Int
    let s: String
    let a: Int
    let p, q: String
    let f, l: Int
    let t: TimeInterval
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
        //return Coin(id: s, timestamp: f, open: p, closed: q)
        return Coin(coinMapper: self)
    }
    
}
