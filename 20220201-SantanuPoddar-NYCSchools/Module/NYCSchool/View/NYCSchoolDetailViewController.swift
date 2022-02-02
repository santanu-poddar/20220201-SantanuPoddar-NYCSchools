//
//  NYCSchoolDetailViewController.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import UIKit

class NYCSchoolDetailViewController: UIViewController {
    
    /// NYC school Details interactor declaration
    private var interactor: NYCSchoolDetailInteractorProtocol?
    /// dbn var decaration
    var dbn: String?
       
    
    /// IBOutlet declaration to show all the SAT related data
    
    /**
    "dbn": "31R080",
    "school_name": "THE MICHAEL J. PETRIDES SCHOOL",
    "num_of_sat_test_takers": "107",
    "sat_critical_reading_avg_score": "472",
    "sat_math_avg_score": "488",
    "sat_writing_avg_score": "466"
    */
    
    @IBOutlet var satDataStackView: UIStackView!
    @IBOutlet var dbnLabel: UILabel!
    @IBOutlet var school_NameLabel: UILabel!
    @IBOutlet var num_of_sat_test_takersLabel: UILabel!
    @IBOutlet var reading_avg_scoreLabel: UILabel!
    @IBOutlet var math_avg_scoreLabel: UILabel!
    @IBOutlet var writing_avg_scoreLabel: UILabel!

    // MARK: - Life Cycle Method
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCleanArchStack()
        loadData(dbn: self.dbn ?? "")
    }
    
    // MARK: - CleanArchStack
    // MARK: -
    private func setupCleanArchStack() {
        let viewController = self
        let interactor = NYCSchoolDetailInteractor()
        let presenter = NYCSchoolDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: - Function to fetch the SAT Data for each school using the 'DBN' from API call
    // MARK: -
    private func loadData(dbn: String) {
        interactor?.fetchSchoolDetail(dbn: dbn)
    }
   
}

// MARK: - NYCSchoolDetailViewController Protocol Method
// MARK: -

extension NYCSchoolDetailViewController: NYCSchoolDetailViewControllerProtocol {
    func fetchSchoolDetail(viewModel: NYCSchoolDetailViewModel) {
        displaySatData(viewModel: viewModel)
    }
    
    /// Function to diapy the SAT scroes from View Model Object
    private func displaySatData(viewModel: NYCSchoolDetailViewModel) {
        if !(viewModel.nycSchoolDetailResponseModel?.schoolData?.isEmpty ?? false) {
            dbnLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.dbn
            school_NameLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.schoolName
            self.title = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.schoolName
            num_of_sat_test_takersLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.numOfSatTestTakers
            reading_avg_scoreLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.satCriticalReadingAvgScore
            math_avg_scoreLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.satMathAvgScore
            writing_avg_scoreLabel.text = viewModel.nycSchoolDetailResponseModel?.schoolData?.first?.satWritingAvgScore
        } else {
            satDataStackView.isHidden = true
            self.title = "School Details Not Found"
            print("No Data returned from API")
        }
    }
    
    
}
