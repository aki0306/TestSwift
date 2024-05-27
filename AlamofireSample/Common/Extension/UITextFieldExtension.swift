//
//  UITextFieldExtension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/05/27.
//

import UIKit

extension UITextField {
    
    func setRightView(_ view: UIView, padding: CGFloat) {
        // カスタムビューを作成して、与えられたビューをその中に配置
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(view)
        
        // 与えられたビューのオートレイアウト制約を設定
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            view.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: padding),
            view.widthAnchor.constraint(equalToConstant: view.frame.width),
            view.heightAnchor.constraint(equalToConstant: view.frame.height),
            // customView.widthAnchor.constraint(equalToConstant: view.frame.width + abs(padding)),
            customView.widthAnchor.constraint(equalToConstant: view.frame.width + abs(padding)),
            customView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        
        // テキストフィールドのrightViewとしてカスタムビューを設定
        self.rightView = customView
        self.rightViewMode = .always
    }
}
