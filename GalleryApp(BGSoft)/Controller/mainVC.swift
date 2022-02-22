//
//  ViewController.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import UIKit

class mainVC: UIViewController {

    private var collectionView = GalleryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.fetchPhotos()
    
        collectionView.collectionViewLayout = GalleryCollectionFlowLayout(itemSize: CGSize(width: Constants.galleryItemWidth, height: Constants.galleryItemHeight))
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
}
