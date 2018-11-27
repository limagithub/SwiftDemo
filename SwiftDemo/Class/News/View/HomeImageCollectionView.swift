//
//  HomeImageCollectionView.swift
//  ShareDemo
//
//  Created by 秦传龙 on 2018/11/23.
//  Copyright © 2018年 HomeImageCollectionViewqclong. All rights reserved.
//

import UIKit

class HomeImageCollectionView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, NibLoadable {
    
    var collectionView:UICollectionView {
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.itemSize =  CGSize(width: (self.width - 40)/3, height: self.height);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.scrollDirection = .horizontal;
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.register(UINib.init(nibName: "HomeImageCell", bundle: nil), forCellWithReuseIdentifier: "HomeImageCell");
        collectionView.backgroundColor = .clear;
        collectionView.isScrollEnabled = false;
        return collectionView;
        
    }
    
    
    var images = [ImageList]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didSelect: ((_ selectedIndex: Int)->())?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(collectionView);
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeImageCell", for: indexPath) as! HomeImageCell;
        cell.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: image3Width, height: image3Width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.item)
    }
}
