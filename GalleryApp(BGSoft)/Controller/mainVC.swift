//
//  ViewController.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import UIKit

class mainVC: UIViewController {

    private var collectionView = GalleryCollectionView()
    
    @objc func canRotate() -> Void {}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.profiles.sorted(by: { $0.user_name < $1.user_name})
        
        collectionView.fetchPhotos()
    
        collectionView.collectionViewLayout = GalleryCollectionFlowLayout(itemSize: CGSize(width: Constants.galleryItemWidth, height: Constants.galleryItemHeight))
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
