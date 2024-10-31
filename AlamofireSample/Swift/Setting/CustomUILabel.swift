//
//  CustomUILabel.swift
//  AlamofireSample
//
//  Created by アキ on 2024/10/12.
//

import UIKit

class HiraginoUILabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        // ヒラギノフォントで日本語と英語が混じっている場合のラベルサイズずれ対応
        if let font = self.font,
            font.familyName.hasPrefix("Hiragino") { // 念の為ヒラギノフォントであること確認
            size.width = ceil(size.width);
            size.height = ceil(size.height + abs(font.descender) + 2);
        }
        return size;
    }
}
