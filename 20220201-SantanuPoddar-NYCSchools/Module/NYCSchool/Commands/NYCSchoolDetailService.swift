//
//  NYCSchoolDetailService.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

extension ServiceAPI: NYCSchoolDetailService {
  
    func fetchSchoolDetail(request: NYCSchoolDetailRequestModel, completion: CompletionHandler<NYCSchoolDetailResponseModel>) {

        let serviceTask = ServiceTask<NYCSchoolDetailRequestModel, NYCSchoolDetailResponseModel>(
            url: APIURLEndpointPath.schoolDetail,
            method: .get,
            completion: completion,
            body: request,
            headers: nil,
            params: ["dbn": request.dbn],
            pathParams: nil)
        
        execute(serviceTask: serviceTask)
    }
    
}
