//
//  ThemaSearchCell.swift
//  AlamofireSample
//
//  Created by アキ on 2024/04/29.
//

import UIKit

protocol ThemaSearchCellDelegate: AnyObject {
    func tapThemaSearchBtn(_ tag: Int)
}

class ThemaSearchCell: UICollectionViewCell {
    
    @IBOutlet weak var themaSearchBtn: UIButton!
    
    weak var themaSearchCellDelegate: ThemaSearchCellDelegate?
    
    func setData(data: String) {
        var config = UIButton.Configuration.plain()
        config.title = data
        self.themaSearchBtn.configuration = config
        
    }
    
    @IBAction func didTapThemaSearch(_ sender: UIButton) {
        self.themaSearchCellDelegate?.tapThemaSearchBtn(sender.tag)
    }
    
}
