//
//  NYCSchoolDetailsProtocol.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/2/22.
//

import Foundation

protocol NYCSchoolDetailViewControllerProtocol {
    func fetchSchoolDetail(viewModel: NYCSchoolDetailViewModel)
}
protocol NYCSchoolDetailInteractorProtocol {
    func fetchSchoolDetail(dbn: String)
}
protocol NYCSchoolDetailPresenterProtocol {
    func buildViewModel(_ response: NYCSchoolDetailResponseModel)
}

protocol NYCSchoolDetailService {
    func fetchSchoolDetail(request: NYCSchoolDetailRequestModel, completion: CompletionHandler<NYCSchoolDetailResponseModel>)
}
