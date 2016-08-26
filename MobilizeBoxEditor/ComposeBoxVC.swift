//
//  ComposeBoxVC.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import UIKit
import NextGrowingTextView
import SnapKit

class ComposeBoxVC: UIViewController, KeyBoardEditingViewDelegate {
    let maxNumberOfLines = 15
    let keyBoardEditingViewHeight = 40
    let textViewTopPadding = 20
    let imgPickedHeight = 150
    let defaultPadding = 10
    let textView = NextGrowingTextView()
    let keyBoardEditingView = KeyBoardEditingView()
    var editingViewBottomConstraint: ConstraintDescriptionEditable!
    let imgPicked = UIImageView()
    let imageService: ImageService
    
    //MARK: LifeCycle
    init(imageService: ImageService) {
        self.imageService = imageService
        self.imageService.getImages { (success, imageWidget) in
            //
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMyView()
        self.setupTextView()
        self.setupKeyBoardEditingView()
        self.setupTapGestur()
        self.setupImgPicked()
        self.addObservers()
    }
    
    deinit {
        self.removeObservers()
    }
    
    override func keyBoardHeightDidChange(height: CGFloat) {
        self.keyBoardEditingView.snp_updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottom).offset(-height)
        }
        self.keyBoardEditingView.layoutIfNeeded()
    }
    //MARK: Setups
    func setupMyView() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    func setupTextView() {
        self.view.addSubview(self.textView)
        self.textView.snp_makeConstraints { (make) in
            make.top.equalTo(self.snp_topLayoutGuideTop).offset(textViewTopPadding)
            make.left.equalTo(self.view.snp_left).offset(defaultPadding)
            make.right.equalTo(self.view.snp_right).offset(-defaultPadding)
        }
        self.textView.maxNumberOfLines = maxNumberOfLines
        let placeHolder = NSAttributedString(string: "Type your message", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        self.textView.placeholderAttributedText = placeHolder
    }
    
    func setupKeyBoardEditingView() {
        self.keyBoardEditingView.delegate = self
        self.view.addSubview(self.keyBoardEditingView)
        self.keyBoardEditingView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(keyBoardEditingViewHeight)
        }
    }
    func setupTapGestur() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ComposeBoxVC.didTapOnScreen))
        self.view.addGestureRecognizer(tap)
    }
    func setupImgPicked() {
        self.view.addSubview(self.imgPicked)
        self.imgPicked.snp_makeConstraints { (make) in
            make.top.equalTo(self.textView.snp_bottom)
            make.left.equalTo(self.view.snp_left).offset(defaultPadding)
            make.right.equalTo(self.view.snp_right).offset(-defaultPadding)
            make.height.equalTo(imgPickedHeight)
        }
        self.imgPicked.clipsToBounds = true
        self.imgPicked.contentMode = UIViewContentMode.ScaleAspectFill
        self.imgPicked.image = UIImage(named: "testBackground.jpeg")
    }
    //MARK: Actions
    func didTapOnScreen() {
        self.view.endEditing(true)
    }
    //MARK: KeyBoardEditingViewDelegate
    
    func didPressUploadImage() {
        let imagePicker = ImagePicker()
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}