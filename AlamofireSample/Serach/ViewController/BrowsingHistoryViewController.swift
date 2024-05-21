//
//  ViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/01/27.
//

import UIKit

class BrowsingHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    // 1行あたりのアイテム数
    private let itemsPerRow: CGFloat = 2
    
    var data: [String] = [] {
        didSet {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableView.updateConstraints()
        }
        
    }
    
    // テーマ検索のデータ
    var themaData: [String] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.collectionView.updateConstraints()
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
        if let vc = UIApplication.topViewController() {
            if vc is BrowsingHistoryViewController {
                print("")
            }
        }
        print("")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = CGFloat(self.tableView.contentSize.height)
        self.collectionViewHeight.constant = CGFloat(self.collectionView.contentSize.height)
    }
    
    private func initView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = false
        
        self.tableView.registerCustomCell(BrowsingHistoryCell.self)
        self.collectionView.registerCustomCell(ThemaSearchCell.self)
        
        self.themaData = ["あ", "い", "う", "え", "お", "か"]
        
        // JSON文字列
        let jsonString = """
        {
            "key1": "value1",
            "key2": 42,
            "key3": {
                "nestedKey1": "nestedValue1",
                "nestedKey2": [1, 2, 3]
            },
            "key4": true,
            "key5": 3.14
        }
        """

        do {
//            // JSON文字列をData型に変換
//            let jsonData = jsonString.data(using: .utf8)!
//            
//            // JSONデータをAnyDecodable構造体にデコード
//            let decodedData = try JSONDecoder().decode(AnyDecodable.self, from: jsonData)
//            
//            // デコードされたデータを利用する
//            if let dictionary = decodedData.value as? [String: Any] {
//                print(dictionary)
//            }
            // JSON文字列をData型に変換
            let jsonData = jsonString.data(using: .utf8)!
            
            // JSONデータをAnyDecodable構造体にデコード
            let decodedData = try JSONDecoder().decode(AnyDecodable.self, from: jsonData)
            
            // デコードされたデータを利用する
            for keyValue in decodedData.values {
                print("Key: \(keyValue.key), Value: \(keyValue.value)")
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BrowsingHistoryViewController: UICollectionViewDelegate {
}

extension BrowsingHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.themaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: ThemaSearchCell.self, indexPath: indexPath)
        cell.themaSearchBtn.tag = indexPath.row
        cell.themaSearchCellDelegate = self
        cell.setData(data: themaData[indexPath.item])
        return cell
    }
    
    // セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}

extension BrowsingHistoryViewController: UICollectionViewDelegateFlowLayout {
    
    // Screenサイズに応じたセルサイズを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 5, height: 40.0)
    }
    
}

extension  BrowsingHistoryViewController: ThemaSearchCellDelegate {
    
    func tapThemaSearchBtn(_ tag: Int) {
        print("")
    }
    
}

