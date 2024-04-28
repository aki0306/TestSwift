//
//  NSObjectProtocolExtension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/28.
//

import UIKit

extension NSObjectProtocol {

    static var className: String {
        return String(describing: self)
    }

}
