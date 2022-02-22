//
//  GalleryCollectionFlowLayout.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 22.02.22.
//

import UIKit

class GalleryCollectionFlowLayout: UICollectionViewFlowLayout {
    
    var scaleOffset: CGFloat = 200
    var scaleFactor: CGFloat = 0.9
    
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init(itemSize: CGSize) {
        super.init()
        self.itemSize = itemSize
        minimumLineSpacing = Constants.galleryMinimumLineSpacing
        scrollDirection = .horizontal
    }
       
    
    override func shouldInvalidateLayout(forBoundsChange _: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView,
            let superAttributes = super.layoutAttributesForElements(in: rect) else {
                return super.layoutAttributesForElements(in: rect)
        }
        
        let contentOffset = collectionView.contentOffset
        let size = collectionView.bounds.size
        
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX
        
        guard case let newAttributesArray as [UICollectionViewLayoutAttributes] = NSArray(array: superAttributes, copyItems: true) else {
            return nil
        }
        
        newAttributesArray.forEach {
            let distanceFromCenter = visibleCenterX - $0.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), self.scaleOffset)
            let scale = absDistanceFromCenter * (self.scaleFactor - 1) / self.scaleOffset + 1
            $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        }
        return newAttributesArray
    }
}
