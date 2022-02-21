//
//  Profile.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import Foundation

struct Profile: Identifiable, Hashable, Codable {
    var id: String?
    var user_name: String
    var user_url: String
    var colors: [String]
    var photo_url: String
}
