//
//  ViewController.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 27/01/22.
//

import UIKit

class ContestsVC: BaseVC {

    //MARK: Outlet and Variable
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var viewModel = ContestsViewModel()
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchContest() {
            DispatchQueue.main.async {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
            }
        }
    }
    
    //MARK: Methods
    func setInit() {
        setTitle(strTitle: AppString.Contest.uppercased())
        tblView.register(UINib(nibName: Xib.contestCell, bundle: nil), forCellReuseIdentifier: ContestCell.reuseidentifier)
        tblView.addSubview(refreshControl)
        txtSearch.delegate = self
    }
    
    /// Fetch all data from the server and set into tableview
    func fetchContest(completionHandler: @escaping () -> Void) {
        self.viewModel.apiFetchContests { isSuccess in
            if isSuccess! {
                completionHandler()
            }
        }
    }
    
    //MARK: refresh- To Refreh tableview
    @objc func refresh(_ sender: AnyObject) {
        fetchContest { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

//MARK: Tablview Delegate
extension ContestsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.objContestsList.count
    }
    
    /// Fetch all data from the server and set into tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContestCell = tableView.dequeueReusableCell(for: indexPath)
        let singleContest = viewModel.objContestsList[indexPath.row]
        /// pass contest data to the tableviewcell's method
        cell.setData(contestData: singleContest)
        return cell
    }
    
    /// open ios default browser to load contest link
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleContest = viewModel.objContestsList[indexPath.row]
        if let url = singleContest.url {
            self.openURL(strUrl: url)
        }
    }
}

//MARK: TextField Delegate
extension ContestsVC: UITextFieldDelegate {
    /// when search contest and write something in the search textfield
    @IBAction func valueChange(_ sender: UITextField) {
        viewModel.filterData(strSerchText: sender.text!) { [weak self] isSuccess in
            self?.tblView.reloadData()
        }
    }
    
    /// when user click on return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
