//
//  NYCSchoolDetailInteractor.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolDetailInteractor: NYCSchoolDetailInteractorProtocol {
    
    var presenter: NYCSchoolDetailPresenterProtocol?

    /// retrieve NYC School list from API
    func fetchSchoolDetail(dbn: String) {
       
        // get school list from server
        
        let request = NYCSchoolDetailRequestModel(dbn: dbn)
        let schoolDetailCommand = NYCSchoolDetailCommand.build(request: request) { command in
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
        schoolDetailCommand?.execute()
    }
}
