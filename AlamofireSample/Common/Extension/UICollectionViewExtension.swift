//
//  UICollectionView extension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/28.
//

import UIKit

extension UICollectionViewCell {

    static var identifier: String {
        return className
    }

}

extension UICollectionView {

    func registerCustomCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(
            UINib(nibName: T.identifier, bundle: nil),
            forCellWithReuseIdentifier: T.identifier
        )
    }

    func dequeueReusableCustomCell<T: UICollectionViewCell>(with cellType: T.Type,
                                                            indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier,
                                   for: indexPath) as! T
    }

}
