//
//  SearchViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/27.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    private func initView() {
        self.textField.delegate = self
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

