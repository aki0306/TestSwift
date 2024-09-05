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
    
    let yearPickerView = UIPickerView()
    let monthPickerView = UIPickerView()
    let dayPickerView = UIPickerView()
    
    // 年、月、日用のデータソース
    let years = Array(1900...2100)
    let months = Array(1...12)
    var days = Array(1...31)

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
        
        // 各ピッカービューのデリゲートとデータソースを設定
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        dayPickerView.delegate = self
        dayPickerView.dataSource = self

        // ピッカービューを追加
        setupPickerViewLayout()
        
        // 現在の日付を取得して初期選択を設定
        setInitialSelection()
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
    
        // ピッカービューのレイアウト設定
        func setupPickerViewLayout() {
            yearPickerView.translatesAutoresizingMaskIntoConstraints = false
            monthPickerView.translatesAutoresizingMaskIntoConstraints = false
            dayPickerView.translatesAutoresizingMaskIntoConstraints = false
    
            view.addSubview(yearPickerView)
            view.addSubview(monthPickerView)
            view.addSubview(dayPickerView)
    
            // 年ピッカービューのレイアウト
            NSLayoutConstraint.activate([
                yearPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                yearPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                yearPickerView.widthAnchor.constraint(equalToConstant: 100),
                yearPickerView.heightAnchor.constraint(equalToConstant: 200)
            ])
    
            // 月ピッカービューのレイアウト
            NSLayoutConstraint.activate([
                monthPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                monthPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                monthPickerView.widthAnchor.constraint(equalToConstant: 100),
                monthPickerView.heightAnchor.constraint(equalToConstant: 200)
            ])
    
            // 日ピッカービューのレイアウト
            NSLayoutConstraint.activate([
                dayPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
                dayPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                dayPickerView.widthAnchor.constraint(equalToConstant: 100),
                dayPickerView.heightAnchor.constraint(equalToConstant: 200)
            ])
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

extension  BrowsingHistoryViewController: ThemaSearchCellDelegate {
    
    func tapThemaSearchBtn(_ tag: Int) {
        print("")
    }
    
}

extension BrowsingHistoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // ピッカービューごとの行数を設定
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPickerView {
            return years.count
        } else if pickerView == monthPickerView {
            return months.count
        } else if pickerView == dayPickerView {
            return days.count
        }
        return 0
    }

    // ピッカービューごとのコンポーネント数を設定（1つのコンポーネントだけ使用）
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // ピッカービューに表示するデータを設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == yearPickerView {
            return "\(years[row])年"
        } else if pickerView == monthPickerView {
            return "\(months[row])月"
        } else if pickerView == dayPickerView {
            return "\(days[row])日"
        }
        return nil
    }

    // ピッカービューで選択された値を取得
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedYear = years[yearPickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[monthPickerView.selectedRow(inComponent: 0)]
        let selectedDay = days[dayPickerView.selectedRow(inComponent: 0)]
        
        print("選択された日付: \(selectedYear)年 \(selectedMonth)月 \(selectedDay)日")
        
        // 月が変更された時に、日にちを更新する
        if pickerView == monthPickerView || pickerView == yearPickerView {
            updateDays(for: selectedYear, month: selectedMonth)
        }
    }

    // 月に応じて「日」の範囲を更新する
    func updateDays(for year: Int, month: Int) {
        switch month {
        case 2:
            days = isLeapYear(year) ? Array(1...29) : Array(1...28)
        case 4, 6, 9, 11:
            days = Array(1...30)
        default:
            days = Array(1...31)
        }
        dayPickerView.reloadAllComponents()
    }

    // うるう年の判定
    func isLeapYear(_ year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    // 現在の日付を取得して、初期選択を設定する
    func setInitialSelection() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        // 年ピッカーの初期選択
        if let yearIndex = years.firstIndex(of: currentYear) {
            yearPickerView.selectRow(yearIndex, inComponent: 0, animated: false)
        }
        
        // 月ピッカーの初期選択
        monthPickerView.selectRow(currentMonth - 1, inComponent: 0, animated: false)
        
        // 日ピッカーの初期選択
        dayPickerView.selectRow(currentDay - 1, inComponent: 0, animated: false)
    }
}

