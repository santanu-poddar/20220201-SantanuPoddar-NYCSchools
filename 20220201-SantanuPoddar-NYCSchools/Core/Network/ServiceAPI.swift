//
//  ServiceAPI.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

protocol NetworkServiceable {
    var networkClient: Networkable { get set }
}

class ServiceAPI: NetworkServiceable {
    static let shared = ServiceAPI()
    var networkClient: Networkable
    
    private init(networkClient: Networkable = NetworkClient.shared) {
        self.networkClient = networkClient
    }

    /**
     Executes the ServiceTask

     - Parameter :

     * serviceTask : A ServiceTask with configuration

     - Returns: it returns the url request.
     */

    func execute<E: Encodable, T: Codable>(serviceTask: ServiceTask<E, T>) {
        // lets build the network request
        guard let request = RequestBuilder().build(
            requestMedthod: serviceTask.method,
            endpoint: serviceTask.url,
            params: serviceTask.params,
            body: serviceTask.body,
            headers: serviceTask.headers,
            pathParams: serviceTask.pathParams
        ) else {
            return
        }

        // we need to build a custom completion handler for network request
        let completionHandler = buildCompletionHandler(completion: serviceTask.completion, urlRequestForCachedResponse: request)

        // if we have a valid cached response let go ahead and return
        networkClient.performRequest(request: request, completion: completionHandler)
        
    }

    /**
     Creates a completions handler for NetoworkClient

     - Parameter :

     * completion                   : completion from the command
     * urlRequestForCachedResponse  : Request will need to be cached
     * cachePolicy                  : the rules for caching this requests response locally

     - Returns: it returns the url request.
     */

    func buildCompletionHandler<T: Codable>(completion: CompletionHandler<T>, urlRequestForCachedResponse: URLRequest? = nil) -> CompletionHandler<Data> {
        let completionHandler = CompletionHandler<Data>()

        // if the network request is succesful
        completionHandler.onSuccess = { responseData in
            // If expecting no data back, and data isEmpty, then return without attempting to decode to prevent mapping failure.
            if responseData.isEmpty, T.self == EmptyResponse.self {
                if let response: T = EmptyResponse() as? T {
                    completion.onSuccess(response)
                    return
                }
            }
            // lets map the json response to the codable model
            guard let response: T = responseData.mapToCodable() else {
                completion.onFailure(ServiceErrors.jsonMappingFailed)
                return
            }

            // first priority is to call on success with the response
            completion.onSuccess(response)
        }

        // if the network request fails in some way
        completionHandler.onFailure = { error in
            completion.onFailure(error)
        }

        return completionHandler
    }
}
