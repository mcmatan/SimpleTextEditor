//
//  ImagePicker.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import UIKit
import UIKit

import UIKit
class ImagePicker: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let itemSize = CGSize(width: 100, height: 100)
    let layoutInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 10)
    var collectionView: UICollectionView!
    let collectionViewLayout = UICollectionViewFlowLayout()
    let widgets: Array<ImageWidget>
    let reuseIdentifier = "cell"
    let completion: ((widget: ImageWidget)->Void)
    
    init(widgets: Array<ImageWidget>, completion:((widget: ImageWidget)->Void)){
        self.widgets = widgets
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: LofeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    //MARK: setup
    func setupCollectionView() {
        self.collectionViewLayout.itemSize = itemSize
        self.collectionViewLayout.sectionInset = layoutInset
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.collectionViewLayout)
        self.view.addSubview(self.collectionView)
        self.collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view.snp_edges)
        }
        self.collectionView.registerClass(ImagePickerCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    //CollectionView Delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.widgets.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImagePickerCollectionViewCell
        let widget = self.widgets[indexPath.item]
        cell.setImageURL(NSURL(string: widget.imageThemb!)!)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.completion(widget: self.widgets[indexPath.item])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}