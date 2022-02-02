//
//  URL+Extensions.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import UIKit

extension URL {
    
    // Function to add request paramter with requet URL
    func addParams(params: [String: String]?) -> URL? {
        guard let params = params else {
            return self
        }
        var urlComp = URLComponents(url: self, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        
        let sortedParams = params.sorted { $0.1 < $1.1 } // this needs to be sorted for generated keys
        for (key, value) in sortedParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComp?.queryItems = queryItems
        return urlComp?.url
    }
}
