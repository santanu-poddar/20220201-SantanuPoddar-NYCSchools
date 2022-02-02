//
//  NYCSchoolListService.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

extension ServiceAPI: NYCSchoolListService {
  
    func fetchSchoolList(request: NYCSchoolListRequestModel, completion: CompletionHandler<NYCSchoolListResponseModel>) {

        let serviceTask = ServiceTask<NYCSchoolListRequestModel, NYCSchoolListResponseModel>(
            url: APIURLEndpointPath.schoolList,
            method: .get,
            completion: completion,
            body: request,
            headers: nil,
            params: ["$select": "dbn,school_name", "$limit": request.limit, "$offset": request.offset],
            pathParams: nil)
        
        execute(serviceTask: serviceTask)
    }
    
}
