//
//  NYCSchoolListPresenter.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

class NYCSchoolListPresenter: NYCSchoolListPresenterProtocol {
    
    var viewController: NYCViewControllerProtocol?

    func buildViewModel(_ response: NYCSchoolListResponseModel) {
        let viewmodel = NYCSchoolListViewModel(nycSchoolListResponseModel: response)
        viewController?.fetchSchoolList(viewModel: viewmodel)
    }
}
