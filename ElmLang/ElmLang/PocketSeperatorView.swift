//
//  PockectCellSeperatorView.swift
//  ElmLang
//
//  Created by 于天航 on 16/8/17.
//  Copyright © 2016年 402v. All rights reserved.
//

import UIKit

class PocketSeperatorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(hexString: "#f5f5f5")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.frame = layoutAttributes.frame
    }
}
