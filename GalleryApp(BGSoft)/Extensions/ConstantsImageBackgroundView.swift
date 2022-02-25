//
//  ConstantsImageBackgroundView.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 24.02.22.
//

import Foundation
import UIKit

struct ConstantsBackgroundView {
    static let bottomDistanceToView: CGFloat = 0
    static let topDistanceToView: CGFloat = 0
    static let leftDistanceToView: CGFloat = 25
    static let rightDistanceToView: CGFloat = 25
    
    static let galleryMinimumLineSpacing: CGFloat = 50
    static let galleryItemWidth = UIScreen.main.bounds.width - ConstantsBackgroundView.galleryMinimumLineSpacing
    static let galleryItemHeight = UIScreen.main.bounds.height * 0.8
    
    static let cornerRadius: CGFloat = 30
    static let shadowRadius: CGFloat = 8
    static let shadowOpacity  = 0.75
}
