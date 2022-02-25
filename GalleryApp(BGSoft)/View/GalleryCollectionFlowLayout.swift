//
//  GalleryCollectionFlowLayout.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 22.02.22.
//

import UIKit

class GalleryCollectionFlowLayout: UICollectionViewFlowLayout {
    
    var scaleOffset: CGFloat = ConstantsBackgroundView.galleryItemWidth
    var scaleFactor: CGFloat = ConstantsFlowLayout.scaleFactor
    
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    override init(/*itemSize: CGSize*/) {
        super.init()
        //self.itemSize = itemSize
        minimumLineSpacing = ConstantsBackgroundView.galleryMinimumLineSpacing
        scrollDirection = .horizontal
        self.minimumLineSpacing = ConstantsBackgroundView.galleryMinimumLineSpacing
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
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = self.collectionView else {
            return proposedContentOffset
        }
        
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let layoutAttributes = self.layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        
        
        for attributes in layoutAttributes {
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attributes
                continue
            }
            
            if abs(attributes.center.x - proposedContentOffsetCenterX) < abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attributes
            }
        }
        
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        let offset = newOffsetX - collectionView.contentOffset.x
        
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = ConstantsBackgroundView.galleryItemWidth + minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
}
