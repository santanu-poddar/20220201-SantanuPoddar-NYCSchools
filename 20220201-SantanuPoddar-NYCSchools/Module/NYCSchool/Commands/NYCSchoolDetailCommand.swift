//
//  NYCSchoolDetailCommand.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolDetailCommand: ServiceCommand<NYCSchoolDetailResponseModel> {
    
    class func build(request: NYCSchoolDetailRequestModel, _ helper: (ServiceCommand<NYCSchoolDetailResponseModel>) -> Void) -> Commandable? {
        let command = super.build { command in
            helper(command)
            command.onExecute = { serviceAPI in
                serviceAPI.fetchSchoolDetail(request: request, completion: command.completion)
            }
        }
        return command
    }
}
