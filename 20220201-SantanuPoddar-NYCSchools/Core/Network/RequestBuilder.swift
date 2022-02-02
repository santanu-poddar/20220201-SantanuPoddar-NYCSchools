//
//  RequestBuilder.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

struct EmptyRequest: Encodable {}
struct EmptyResponse: Codable {}
struct EmptyBody: Codable { }

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

class RequestBuilder {
    
    private struct HeaderConstants {
        static let apiKey = "API-KEY"
        static let apiToken = "API-TOKEN"
    }
    
    init() {
        
    }
    
    func build<E: Encodable>(requestMedthod: RequestMethod, endpoint: String, params: [String: String]?, body: E?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        switch requestMedthod {
        case .get:
            return get(endpoint: endpoint, params: params, headers: headers, pathParams: pathParams)
        case .post:
            return post(endpoint: endpoint, params: params, body: body, headers: headers, pathParams: pathParams)
        case .put:
            return put(endpoint: endpoint, params: params, body: body, headers: headers, pathParams: pathParams)
        case .delete:
            return delete(endpoint: endpoint, params: params, body: body, headers: headers, pathParams: pathParams)
        case .patch:
            return patch(endpoint: endpoint, params: params, body: body, headers: headers, pathParams: pathParams)
        }
    }
    
    /**
     Creates the request URL and request body for the route for GET method.
     
     - Method : PATCH
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the url request.
     */
    func patch<E: Encodable>(endpoint: String, params: [String: String]?, body: E?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, params: params, pathParams: pathParams)
        return buildRequest(url: url, method: RequestMethod.patch.rawValue, body: body, headers: headers)
    }
    
    /**
     Creates the request URL and request body for the route for GET method.
     
     - Method : GET
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the url request.
     */
    func get(endpoint: String, params: [String: String]?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, params: params, pathParams: pathParams)
        return buildRequest(url: url, method: RequestMethod.get.rawValue, body: EmptyRequest(), headers: headers)
    }
    
    /**
     Creates the request URL and request body for the route for POST method.
     
     - Method : POST
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * body       : This is used for request body.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the url request.
     */
    func post<E: Encodable>(endpoint: String, params: [String: String]?, body: E?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, params: params, pathParams: pathParams)
        return buildRequest(url: url, method: RequestMethod.post.rawValue, body: body, headers: headers)
    }
    
    /**
     Creates the request URL and request body for the route for PUT method.
     
     - Method : PUT
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * body       : This is used for request body.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the url request.
     */
    func put<E: Encodable>(endpoint: String, params: [String: String]?, body: E?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, params: params, pathParams: pathParams)
        return buildRequest(url: url, method: RequestMethod.put.rawValue, body: body, headers: headers)
    }
    
    /**
     Creates the request URL and request body for the route for DELETE method.
     
     - Method : DELETE
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * body       : This is used for request body.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the url request.
     */
    func delete<E: Encodable>(endpoint: String, params: [String: String]?, body: E?, headers: [String: String]? = nil, pathParams: [String: String]? = nil) -> URLRequest? {
        let url = buildUrl(endpoint: endpoint, params: params, pathParams: pathParams)
        return buildRequest(url: url, method: RequestMethod.delete.rawValue, body: body, headers: headers)
    }
    
    /**
     Build the request URL for the route.
     
     - Parameter :
     
     * endpoint   : This is used for request URL, accept the parameter as type String.
     * params     : This is used for appending the parameters with request URL, accept the parameter as type Dictionary.
     * pathParams : This is used for replacing the request URL PathParam, accept the parameter as type Dictionary.
     
     - Returns: it returns the URL.
     */
    private func buildUrl(endpoint: String, params: [String: String]?, pathParams: [String: String]? = nil) -> URL? {
        var endpoint = endpoint
        if let pathParams = pathParams {
            for (key, value) in pathParams {
                endpoint = endpoint.replacingOccurrences(of: key, with: value)
            }
        }
        let baseURL = APIURLEndpointPath.baseURL + endpoint
        let baseURLString = baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = baseURLString else {
            return nil
        }
        var finalURL = URL(string: urlString)
        finalURL = finalURL?.addParams(params: params)
        return finalURL
    }
    
    /**
     Build the request Header and request body for the route.
     
     - Parameter :
     
     * url        : This is used for request URL, accept the parameter as type URL.
     * method     : This is used for request Method, accept the parameter as type String.
     * body       : This is used for request body.
     * headers    : This is used for request Header, accept the parameter as type Dictionary.
     
     
     - Returns: it returns the URL request.
     */
    private func buildRequest<E: Encodable>(url: URL?, method: String, body: E?, headers: [String: String]? = nil) -> URLRequest? {        
        var request = URLRequest(url: url!)
        request.httpMethod = method
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let requestBody = body {
            if !(requestBody is EmptyRequest) {
                let encoder = JSONEncoder()
                request.httpBody = try? encoder.encode(requestBody)
            }
        }
        return request
    }
    
}
