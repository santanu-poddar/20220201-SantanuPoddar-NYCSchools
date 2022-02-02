//
//  ViewController.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    /// NYC school list interactor decaration
    private var interactor: NYCSchoolListInteractorProtocol?
    /// limit to display each set of data in the table view in the api call
    var limit = 25
    /// offset to display next set of offset in the table view in the api call
    var offset = 25
    /// var to hold the array of NYC school list
    var schoolData: [NYCSchoolList]?
    /// cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    /// the storyboard IBOutlet var
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Life Cycle Method
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        self.title = "School List"
        // Do any additional setup after loading the view.
        setupCleanArchStack()
        loadData()
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        // setup the tableview row height
        self.tableView.rowHeight = UITableView.automaticDimension
        // (optional) include this line if you want to remove the extra empty cell divider lines
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 300.0))
        
    }
    
    // MARK: - CleanArchStack
    // MARK: -
    private func setupCleanArchStack() {
        let viewController = self
        let interactor = NYCSchoolListInteractor()
        let presenter = NYCSchoolListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: - Function to fetch NYC school list from API call
    // MARK: -
    private func loadData() {
        interactor?.fetchSchoolList(limit: "\(limit)", offset: "\(offset)")
    }
}

// MARK: - NYCViewControllerProtocol method
// MARK: -
extension ViewController: NYCViewControllerProtocol {
    func fetchSchoolList(viewModel: NYCSchoolListViewModel) {
        
        if schoolData != nil {
            if let nextSetOfSchoolData = viewModel.nycSchoolListResponseModel?.schoolData {
                schoolData?.append(contentsOf: nextSetOfSchoolData)
            }
        } else {
            schoolData = viewModel.nycSchoolListResponseModel?.schoolData
    
            // This view controller itself will provide the delegate methods and row data for the table view.
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        tableView.reloadData()
        offset += 25
    }
}

// MARK: - Table View Delegate and DataSource method
// MARK: -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let schoolData = schoolData {
            return schoolData.count
        } else {
            return 0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell? ?? UITableViewCell()
        
        // set the text from the viewmodel
        if let schoolData = schoolData {
            let school: NYCSchoolList = schoolData[indexPath.row]
            cell.textLabel?.text = school.school_name
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = UIColor(red: 1/255.0, green: 25/255.0, blue: 147/255.0, alpha: 1.0)  
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // move to detail view and pass the dbn to fetch the each school sat data
        let nycSchoolDetailViewController = UIStoryboard.loadViewController(fromStoryboard: Storyboard.main, viewControllerIdentifier: ViewControllerIdentifier.nycSchoolDetailViewController) as! NYCSchoolDetailViewController
        
        if let schoolData = schoolData {
            let school: NYCSchoolList = schoolData[indexPath.row]
            nycSchoolDetailViewController.dbn = school.dbn
        }
        
        self.navigationController?.pushViewController(nycSchoolDetailViewController, animated: true)
    }
}

// MARK: - ScrollView Delegate method
// MARK: -
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = self.tableView.frame.size.height
        let contentOffSetY = self.tableView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentOffSetY
        if distanceFromBottom < height {
            //if scrollView.contentOffset.y >= scrollView.contentSize.height {
            
            //if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            loadData()
        }
    }
}
