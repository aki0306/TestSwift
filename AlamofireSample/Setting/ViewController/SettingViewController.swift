//
//  SettingViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/16.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var otpTextFieldArray: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // ペーストされたテキストが6桁の数字であるか確認
        if string.count == 6, string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            let optArray = Array(string)
            self.otpTextFieldArray[0].text = String(optArray[0])
            self.otpTextFieldArray[1].text = String(optArray[1])
            self.otpTextFieldArray[2].text = String(optArray[2])
            self.otpTextFieldArray[3].text = String(optArray[3])
            self.otpTextFieldArray[4].text = String(optArray[4])
            self.otpTextFieldArray[5].text = String(optArray[5])
            textField.resignFirstResponder()
            return false
        }
        
        // 1文字ずつ入力されるように制限
        if string.count > 1 {
            return false
        }
        
        
        return true
    }
}
