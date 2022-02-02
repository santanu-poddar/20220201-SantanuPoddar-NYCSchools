//
//  NYCSchoolListCommand.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolListCommand: ServiceCommand<NYCSchoolListResponseModel> {
    
    class func build(request: NYCSchoolListRequestModel, _ helper: (ServiceCommand<NYCSchoolListResponseModel>) -> Void) -> Commandable? {
        let command = super.build { command in
            helper(command)
            command.onExecute = { serviceAPI in
                serviceAPI.fetchSchoolList(request: request, completion: command.completion)
            }
        }
        return command
    }
}
