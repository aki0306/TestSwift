//
//  SearchViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/27.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var refreshImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    private func initView() {
        self.textField.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCustomCell(BrowsingHistoryCell.self)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .clear
        let image = UIImage(named: "arrow")
        self.refreshImageView = UIImageView(image: image)
        self.refreshImageView.contentMode = .scaleAspectFit
        self.refreshImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        self.refreshImageView.center = CGPoint(x: self.refreshControl.bounds.midX,
                                               y: self.refreshControl.bounds.midY)
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl.addSubview(self.refreshImageView)
        self.tableView.refreshControl = self.refreshControl
    }
    
    @objc func refreshData() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.refreshImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            self.refreshControl.endRefreshing()
            self.refreshImageView.transform = .identity
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    // 呼ばれるタイミング：タップされたとき，入力可能になる直前
    // できること：trueでテキスト入力可能，falseで入力不可
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         return true
     }
    
    // 呼ばれるタイミング：タップされて入力可能になったあと
    // できること：テキストの値を取得
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    // 呼ばれるタイミング：キーボードのReturnキーが押されて入力が完了する直前
    // できること：trueで編集を停止，falseはそのまま
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 呼ばれるタイミング：キーボードが閉じたあと
    // できること：テキストの値を取得
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }
    
    // 呼ばれるタイミング：キーボードのClearキーが押されたとき
    // できること：trueでクリア，falseは何もしない
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    // 呼ばれるタイミング：キーボードのReturnキーが押されたとき
    // できること：キーボードを閉じるなど
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserDefaults.test = [textField.text ?? ""]
        textField.resignFirstResponder()
        return true
    }
    
    // 呼ばれるタイミング：テキスト編集中
    // できること：入力文字数の制限など
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}

extension SearchViewController: UITableViewDelegate {
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCustomCell(with: BrowsingHistoryCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

