//
//  ServiceCommand.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

protocol Commandable {
    func execute()
    func cancel()
}

class ServiceCommand<T>: Commandable {
    var isCancelled = false
    var onExecute: ((ServiceAPI) -> Void)?
    var onSuccess: ((T) -> Void)?
    var onFailure: (Error?) -> Void
    var serviceAPI: ServiceAPI
    var completion: CompletionHandler<T> {
        let completion = CompletionHandler<T>()
        completion.onSuccess = { serviceResponse in
            guard !self.isCancelled, let onSuccess = self.onSuccess else {
                self.cleanup()
                return
            }
            DispatchQueue.main.async {
                onSuccess(serviceResponse)
                self.cleanup()
            }
        }
        completion.onFailure = { error in
            guard !self.isCancelled else {
                self.cleanup()
                return
            }
            DispatchQueue.main.async {
                self.onFailure(error)
                self.cleanup()
            }
        }
        return completion
    }

    private let defaultOnFailure: (Error?) -> Void = { _ in }

    init(serviceAPI: ServiceAPI = ServiceAPI.shared) {
        self.serviceAPI = serviceAPI
        onFailure = defaultOnFailure
    }

    class func build(_ helper: (ServiceCommand) -> Void) -> Commandable? {
        let command = ServiceCommand<T>()
        helper(command)
        guard command.onExecute != nil, command.onSuccess != nil else {
            return nil
        }
        return command
    }

    func execute() {
        guard let onExecute = onExecute else {
            return
        }
        onExecute(serviceAPI)
    }

    func cancel() {
        isCancelled = true
    }

    func cleanup() {
        onExecute = nil
        onSuccess = nil
        onFailure = { _ in }
    }
}
