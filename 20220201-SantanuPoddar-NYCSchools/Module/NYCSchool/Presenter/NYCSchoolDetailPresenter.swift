//
//  NYCSchoolDetailPresenter.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolDetailPresenter: NYCSchoolDetailPresenterProtocol {
    
    var viewController: NYCSchoolDetailViewControllerProtocol?
    
    func buildViewModel(_ response: NYCSchoolDetailResponseModel) {
        let viewmodel = NYCSchoolDetailViewModel(nycSchoolDetailResponseModel: response)
        viewController?.fetchSchoolDetail(viewModel: viewmodel)
    }
}
