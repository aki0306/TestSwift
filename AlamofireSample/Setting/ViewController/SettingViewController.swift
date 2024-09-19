//
//  SettingViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/16.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var otpTextFieldArray: [UITextField]!
    @IBOutlet var birthDateTextFieldArray: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        if string.isEmpty {
            return true
        }
        
        // 年テキストフィールドの場合
        if textField == self.birthDateTextFieldArray[0] {
            if updatedText.count == 4 {
                self.birthDateTextFieldArray[0].text = updatedText
                self.birthDateTextFieldArray[1].becomeFirstResponder() // 4桁入力が完了したら月にカーソル移動
                return false
            }
            return updatedText.count <= 4
        }
        // 月テキストフィールドの場合
        else if textField == self.birthDateTextFieldArray[1] {
            if updatedText.count == 2 && Int(updatedText) ?? 0 > 0 && Int(updatedText) ?? 0 <= 12 {
                self.birthDateTextFieldArray[1].text = updatedText
                self.birthDateTextFieldArray[2].becomeFirstResponder() // 2桁入力が完了したら日付にカーソル移動
                return false
            }
            return updatedText.count <= 2 && (Int(updatedText) != nil && Int(updatedText)! >= 1 && Int(updatedText)! <= 12)
        }
        // 日テキストフィールドの場合
        else if textField == self.birthDateTextFieldArray[2] {
            if updatedText.count == 2 && Int(updatedText) ?? 0 > 0 && Int(updatedText) ?? 0 <= 31 {
                self.birthDateTextFieldArray[2].text = updatedText
                self.birthDateTextFieldArray[2].resignFirstResponder() // 入力が完了したらキーボードを閉じる
                return false
            }
            return updatedText.count <= 2 && (Int(updatedText) != nil && Int(updatedText)! >= 1 && Int(updatedText)! <= 31)

        }
        
        return true
        
        
//        // ペーストされたテキストが6桁の数字であるか確認
//        if string.count == 6, string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
//            let optArray = Array(string)
//            self.otpTextFieldArray[0].text = String(optArray[0])
//            self.otpTextFieldArray[1].text = String(optArray[1])
//            self.otpTextFieldArray[2].text = String(optArray[2])
//            self.otpTextFieldArray[3].text = String(optArray[3])
//            self.otpTextFieldArray[4].text = String(optArray[4])
//            self.otpTextFieldArray[5].text = String(optArray[5])
//            textField.resignFirstResponder()
//            return false
//        }
//        
//        // 1文字ずつ入力されるように制限
//        if string.count > 1 {
//            return false
//        }
    }
}
