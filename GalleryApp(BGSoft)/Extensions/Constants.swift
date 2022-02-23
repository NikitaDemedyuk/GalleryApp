//
//  Extensions.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 23.02.22.
//

import Foundation
import UIKit

struct Constants {
    static let leftDistanceToView: CGFloat = 35
    static let rightDistanceToView: CGFloat = 35
    static let galleryMinimumLineSpacing: CGFloat = 50
    static let galleryItemWidth = UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.galleryMinimumLineSpacing + 60
    static let galleryItemHeight = UIScreen.main.bounds.height * 0.8
}
