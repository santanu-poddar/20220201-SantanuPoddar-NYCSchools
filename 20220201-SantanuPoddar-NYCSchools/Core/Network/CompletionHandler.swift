//
//  CompletionHandler.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class CompletionHandler<T> {
    var onSuccess: (T) -> Void = { _ in }
    var onFailure: (Error?) -> Void = { _ in }
}

typealias BasicCompletionHandler = (onSuccess: () -> Void, onFailure: (Error?) -> Void)
