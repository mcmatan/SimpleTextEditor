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


class ComposeBoxVC: UIViewController {
    let maxNumberOfLines = 17
    let keyBoardEditingViewHeight = 60
    let textView = NextGrowingTextView()
    let keyBoardEditingView = KeyBoardEditingView()
    var editingViewBottomConstraint: ConstraintDescriptionEditable!
    
    //MARK: LifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
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
        self.addObservers()
    }
    
    deinit {
        self.removeObservers()
    }
    
    override func keyBoardHeightDidChange(height: CGFloat) {
        self.keyBoardEditingView.snp_updateConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottom).offset(-height)
        }
        //UIView.animateWithDuration(1) {
            self.keyBoardEditingView.layoutIfNeeded()
        //}
    }
    //MARK: Setups
    func setupMyView() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    func setupTextView() {
        self.view.addSubview(self.textView)
        self.textView.backgroundColor = UIColor.redColor()
        self.textView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view.snp_width)
            make.top.equalTo(self.snp_topLayoutGuideTop).offset(10)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        self.textView.maxNumberOfLines = maxNumberOfLines
    }
    
    func setupKeyBoardEditingView() {
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
    //MARK: Actions
    func didTapOnScreen() {
        self.view.endEditing(true)
    }
}