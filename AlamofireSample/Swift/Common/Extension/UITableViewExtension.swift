//
//  UITableViewExtension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/28.
//

import UIKit

extension UITableViewCell {

    static var identifier: String {
        return className
    }

}

extension UITableView {

    func registerCustomCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(
            UINib(nibName: T.identifier, bundle: nil),
            forCellReuseIdentifier: T.identifier
        )
    }

    func dequeueReusableCustomCell<T: UITableViewCell>(with cellType: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }

}
