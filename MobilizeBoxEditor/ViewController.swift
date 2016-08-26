//
//  ViewController.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let btnStartEditing = UIButton()
    var composeBoxVC: ComposeBoxVC?
    var imageService: ImageService?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContainer()
        self.view.addSubview(self.btnStartEditing)
        self.btnStartEditing.snp_makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        self.btnStartEditing.setTitle("Start editing", forState: UIControlState.Normal)
        self.btnStartEditing.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.btnStartEditing.layer.shadowColor = UIColor.grayColor().CGColor
        self.btnStartEditing.layer.shadowOffset = CGSize(width: 2.0,height: 2.0)
        self.btnStartEditing.layer.shadowRadius = 2
        self.btnStartEditing.layer.shadowOpacity = 1.0
        self.btnStartEditing.addTarget(self, action: #selector(ViewController.didPressStartEditing), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setupContainer() {
        self.imageService = ImageService()
        self.composeBoxVC = ComposeBoxVC(imageService: imageService!)
    }

    func didPressStartEditing() {
        self.presentViewController(self.composeBoxVC!, animated: true, completion: nil)
    }

}

