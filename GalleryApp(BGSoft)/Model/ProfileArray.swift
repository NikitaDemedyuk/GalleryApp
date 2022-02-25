//
//  ProfileArray.swift
//  GalleryApp(BGSoft)
//
//  Created by Никита on 21.02.22.
//

import Foundation

struct ProfileArray: Decodable {
    var profiles: [Profile]
   
    private struct ProfileCodingKeys: CodingKey {
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    init(from decoder: Decoder) throws {
        profiles = []
        
        let container = try decoder.container(keyedBy: ProfileCodingKeys.self)
        
        for key in container.allKeys {
            var object = try container.decode(Profile.self, forKey: key)
            object.id = key.stringValue
            profiles.append(object)
        }
    }
}
