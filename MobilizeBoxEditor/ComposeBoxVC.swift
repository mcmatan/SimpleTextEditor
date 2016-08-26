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
import PINRemoteImage

class ComposeBoxVC: UIViewController, KeyBoardEditingViewDelegate {
    let maxNumberOfLines = 15
    let keyBoardEditingViewHeight = 40
    let textViewTopPadding = 20
    let imgPickedHeight = 150
    let defaultPadding: CGFloat = 10.0
    let textView = NextGrowingTextView()
    let keyBoardEditingView = KeyBoardEditingView()
    var editingViewBottomConstraint: ConstraintDescriptionEditable!
    let imgPicked = UIImageView()
    let imageService: ImageService
    var imageWidgets : Array<ImageWidget>?
    
    //MARK: LifeCycle
    init(imageService: ImageService) {
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
        self.getImageWidgets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMyView()
        self.setupTextView()
        self.setupImgPicked()
        self.setupKeyBoardEditingView()
        self.addObservers()
        self.view.layoutIfNeeded()
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
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
        }
        self.textView.contentInset = UIEdgeInsetsMake(0, defaultPadding, 0, -defaultPadding)
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
    }
    //MARK: Actions
    func didTapOnScreen() {
        self.view.endEditing(true)
    }
    func showNoImagesAlert() {
        let alert = UIAlertController(title: "Sorry somthing is wrong, please try again later ):", message: "Can't seem to find any images", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: { actionPress in})
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    //MARK: KeyBoardEditingViewDelegate
    
    func didPressUploadImage() {
        if let isImageWidgets = self.imageWidgets {
            let imagePicker = ImagePicker(widgets: isImageWidgets, completion: { (widget) in
                self.imgPicked.pin_updateWithProgress = true
                self.imgPicked.pin_setImageFromURL(NSURL(string: widget.imageOriginal!))
            })
            self.presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            self.showNoImagesAlert()
        }
    }
    
    //MARK: ImageGetting
    func getImageWidgets() {
        self.imageService.getImagesWidgets { (success, imageWidget) in
            if success == true {
                self.imageWidgets = imageWidget!
            }
        }
    }
}