//
//  ViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/01/27.
//

import UIKit
import DropDown

class BrowsingHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    let selectElementDropDown = DropDown()
    let elementArray: [String] = ["火", "水","1","2","火", "水","1","2","火", "水","1","2","火", "水","1","2","火", "水","1","2","火", "水","1","2"]
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = UserDefaults.test
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
        
        self.initSelectElementDropDownMenu()
        
    }
    
    func initSelectElementDropDownMenu(){
        let appearance = DropDown.appearance()
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .white
        appearance.shadowOpacity = 2.0
        appearance.shadowColor = .blue
        selectElementDropDown.anchorView = self.label
        selectElementDropDown.width = self.btn.frame.width
        selectElementDropDown.dataSource = elementArray
        selectElementDropDown.offsetFromWindowBottom = 100
        selectElementDropDown.bottomOffset = CGPoint(x: 0, y: self.label.bounds.height + 10)
        selectElementDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            // 選択されたときのActionを記載する
            print("")
            self.label.text = item
        }
    }
    
    @IBAction func elementDropDownTapped(_ sender: UIButton) {
        selectElementDropDown.show()
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

extension  BrowsingHistoryViewController: @preconcurrency ThemaSearchCellDelegate {
    
    func tapThemaSearchBtn(_ tag: Int) {
        
    }
    
}


