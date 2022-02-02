//
//  ServiceTask.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class ServiceTask<E: Encodable, T: Codable> {
    
    var url: String
    var method: RequestMethod
    var completion: CompletionHandler<T>
    var body: E?
    var headers: [String: String]?
    var params: [String: String]?
    var pathParams: [String: String]?
    
    init(
        url: String, 
        method: RequestMethod, 
        completion: CompletionHandler<T>, 
        body: E? = nil, 
        headers: [String: String]? = nil, 
        params: [String: String]? = nil, 
        pathParams: [String: String]? = nil
        ) {
        self.url = url
        self.method = method
        self.completion = completion
        self.body = body
        self.headers = headers
        self.params = params
        self.pathParams = pathParams
    }
    
}
