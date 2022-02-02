//
//  NYCSchoolListInteractor.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolListInteractor: NYCSchoolListInteractorProtocol {
    
    var presenter: NYCSchoolListPresenterProtocol?

    /// retrieve NYC School list from API
    func fetchSchoolList(limit: String, offset: String) {
       
        // get school list from server
        
        let request = NYCSchoolListRequestModel(limit: limit, offset: offset)
        let schoolListCommand = NYCSchoolListCommand.build(request: request) { command in
            command.onSuccess = { [weak self] response in
                self?.presenter?.buildViewModel(response)
            }
            command.onFailure = { [weak self] error in
                // Handle silently for now
                if let customError = error as? CustomError {
                    switch customError {
                    case .generic(let errorResponse):
                        print(errorResponse)
                    default:
                        print("default")
                    }
                }
            }
        }
        schoolListCommand?.execute()
    }
}
