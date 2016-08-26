//
//  KeyBoardEditingView.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol KeyBoardEditingViewDelegate {
    func didPressUploadImage()
}

class KeyBoardEditingView: UIView {
    let btnUploadImage = UIImageView()
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.lightGrayColor()
        self.setupBtnUploadImage()
    }
    
    func setupBtnUploadImage() {
        self.addSubview(self.btnUploadImage)
        self.btnUploadImage.image = UIImage(named: "Image_Upload.png")
        self.btnUploadImage.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            make.width.equalTo(self.snp_height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}