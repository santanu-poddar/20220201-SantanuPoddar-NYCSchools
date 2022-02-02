//
//  ErrorType.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

enum NetworkErrors: Error {
    case noDataResponse
}

enum ServiceErrors: Error {
    case invalidURL
    case invalidToken
    case jsonMappingFailed
}

enum CommandErrors: Error {
    case nilParameter
}

enum CustomError: Error {
    case generic(errorResponse: GenericErrorResponseModel)
}

struct GenericErrorResponseModel: Codable {
    let errorMessage: String?
}
