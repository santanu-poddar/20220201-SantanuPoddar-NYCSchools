//
//  NYCSchoolListProtocols.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/2/22.
//

import Foundation

protocol NYCViewControllerProtocol {
    func fetchSchoolList(viewModel: NYCSchoolListViewModel)
}
protocol NYCSchoolListInteractorProtocol {
    func fetchSchoolList(limit: String, offset: String)
}
protocol NYCSchoolListPresenterProtocol {
    func buildViewModel(_ response: NYCSchoolListResponseModel)
}

protocol NYCSchoolListService {
    func fetchSchoolList(request: NYCSchoolListRequestModel, completion: CompletionHandler<NYCSchoolListResponseModel>)
}
