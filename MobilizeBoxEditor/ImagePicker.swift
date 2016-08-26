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
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
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
        self.collectionView.backgroundColor = UIColor.redColor()
        self.collectionView.registerClass(ImagePickerCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    //CollectionView Delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImagePickerCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}