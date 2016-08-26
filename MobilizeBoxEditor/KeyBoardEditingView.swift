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

protocol KeyBoardEditingViewDelegate: class {
    func didPressUploadImage()
}

class KeyBoardEditingView: UIView {
    weak var delegate: KeyBoardEditingViewDelegate?
    let btnBold = UIButton()
    let btnFile = UIButton()
    let btnImage = UIButton()
    let btnIndent = UIButton()
    let btnItalic = UIButton()
    let btnLink = UIButton()
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.lightGrayColor()
        self.setupStackViewWithButtons()
    }
    
    func setupStackViewWithButtons() {
        self.btnBold.setImage(UIImage(named: "bold"), forState: UIControlState.Normal)
        self.btnBold.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.btnFile.setImage(UIImage(named: "file"), forState: UIControlState.Normal)
        self.btnFile.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.btnImage.setImage(UIImage(named: "image"), forState: UIControlState.Normal)
        self.btnImage.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.btnImage.addTarget(self, action: #selector(KeyBoardEditingView.didPressBtnImage), forControlEvents: UIControlEvents.TouchUpInside)
        self.btnIndent.setImage(UIImage(named: "indent"), forState: UIControlState.Normal)
        self.btnIndent.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.btnItalic.setImage(UIImage(named: "italic"), forState: UIControlState.Normal)
        self.btnItalic.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.btnLink.setImage(UIImage(named: "link"), forState: UIControlState.Normal)
        self.btnLink.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [self.btnBold, self.btnFile, self.btnIndent, self.btnItalic, self.btnLink, self.btnImage])
        stackView.distribution = UIStackViewDistribution.FillEqually
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing = 10
        self.addSubview(stackView)
        stackView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(self.snp_height).multipliedBy(0.5)
            make.centerY.equalTo(self.snp_centerY)
        }
        stackView.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Actions
    
    func didPressBtnImage() {
        if let isDelegate =  self.delegate {
            isDelegate.didPressUploadImage()
        }
    }
}