//
//  NetworkClient.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

protocol Networkable {
    var session: URLSession { get set }
    
    func performRequest(request: URLRequest, completion: CompletionHandler<Data>)
}

class NetworkClient: Networkable {
    
    static let shared = NetworkClient()
    var session: URLSession
    
    private init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
    
    func performRequest(request: URLRequest, completion: CompletionHandler<Data>) {
        self.session.dataTask(with: request) { data, response, error in
            guard let responseData = data else {
                completion.onFailure(error)
                return
            }
            // realResponse means we had answer from the server
            // if something went wrong, check else block.
            if let realResponse = response as? HTTPURLResponse {
                switch realResponse.statusCode {
                case 200...299 :
                    // let's check if our data is fine to read
                    var responseString = responseData.toString(data: responseData)
                    responseString = "{\"schoolData\":" + responseString + "}"
                    let modifiedData = Data(responseString.utf8)
                    completion.onSuccess(modifiedData) // success
                case 404:
                    // error for showing generic message
                    completion.onFailure(CustomError.generic(errorResponse: self.getGenericErrorResponse()))
                    
                case 500...505 :
                    // try failed and we are sending a generic response
                    completion.onFailure(CustomError.generic(errorResponse: self.getGenericErrorResponse()))
                    
                default :
                    //in any other cases, we will return generic error (so far)
                    completion.onFailure(CustomError.generic(errorResponse: self.getGenericErrorResponse()))
                }
            } else {
                // no real response from backend
                completion.onFailure(CustomError.generic(errorResponse: self.getGenericErrorResponse()))
            }
        }.resume()
    }
    
    private func getGenericErrorResponse() -> GenericErrorResponseModel {
        return GenericErrorResponseModel(errorMessage: "We could not process your request at this time, please try sometime later.")
    }
}
