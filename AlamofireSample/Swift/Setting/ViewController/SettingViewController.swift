//
//  SettingViewController.swift
//  AlamofireSample
//
//  Created by アキ on 2024/09/16.
//

import UIKit
import Alamofire

class SettingViewController: UIViewController {
    
    @IBOutlet var otpTextFieldArray: [UITextField]!
    @IBOutlet var birthDateTextFieldArray: [UITextField]!
    @IBOutlet var textView: UITextView!
    
    let requestEncoding: String.Encoding = .shiftJIS
    let responseEncoding: String.Encoding = .utf8
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SettingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension SettingViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
