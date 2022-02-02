//
//  Data+Extensions.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

extension Data {
    
    init?(from value: String) {
        guard let data = value.data(using: String.Encoding.utf8, allowLossyConversion: false) else {
            return nil
        }
        self = data
    }
    
    func toString(data: Data) -> String {
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
    }
    
    func mapToCodable<T: Codable>() -> T? {
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(T.self, from: self) else {
            return nil
        }
        return model
    }
    
}
