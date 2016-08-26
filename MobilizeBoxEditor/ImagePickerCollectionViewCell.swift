//
//  ImagePickerCollectionViewCell.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage
import SnapKit

class ImagePickerCollectionViewCell: UICollectionViewCell {
    let image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        self.addSubview(self.image)
        self.image.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.image.contentMode = UIViewContentMode.ScaleAspectFill
        self.image.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setImageURL(url: NSURL) {
        self.image.pin_updateWithProgress = true
        self.image.pin_setImageFromURL(url)
    }
}