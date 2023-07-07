//
//  BinanceDataConverter.swift
//  Binance-MVVM-Combine-SwiftUI
//
//  Created by Alizain on 03/07/2023.
//

import Foundation
import Combine

protocol BinanceDataConverterProtocol {
    func convertData(_ data: String) -> Coin?
}

class BinanceDataConverter: BinanceDataConverterProtocol {
    func convertData(_ data: String) -> Coin? {
        guard let jsonData = data.data(using: .utf8) else { return nil }
        
        do {
            let coin = try JSONDecoder().decode(CoinMapper.self, from: jsonData).toDomain()
            return coin
        } catch {
            return nil
        }
    }
}

enum DataConversionError: Error {
    case invalidData
}
