//
//  ViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/01/27.
//

import UIKit

class BrowsingHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var data: [String] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableView.updateConstraints()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        
//        let url = "URLをいれてね"
//        let headers: HTTPHeaders = [
//            "Contenttype": "application/json"
//        ]
//        let parameters:[String: Any] = [
//            "username": "",
//            "password": ""
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { respons in
//            switch respons.result {
//            case .success(let success): break
//            case .failure(let failure): break
//            }
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = UserDefaults.test
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = CGFloat(self.tableView.contentSize.height)
    }
    
    private func initView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        
        self.tableView.registerCustomCell(BrowsingHistoryCell.self)
        
    }
}

extension BrowsingHistoryViewController: UITableViewDelegate {
}

extension BrowsingHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: BrowsingHistoryCell.self)
        return cell
    }
    
}

