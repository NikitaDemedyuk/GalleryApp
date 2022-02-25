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
        
        collectionView.fetchPhotos()
        
        collectionView.collectionViewLayout = GalleryCollectionFlowLayout(/*itemSize: CGSize(width: ConstantsBackgroundView.galleryItemWidth, height: ConstantsBackgroundView.galleryItemHeight)*/)
        
        view.addSubview(collectionView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: ConstantsCollectionView.collectionViewToTop),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ConstantsCollectionView.collectionViewToBottom),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
