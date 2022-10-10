//
//  CharacterModel.swift
//  AppCakeTask
//
//  Created by Rizwan on 10/8/22.
//

import Foundation

enum CharacterRequest{
    struct Response: NetResponse, Codable{
        var statusCode: Int?
        var message: String?
        var results: [CharacterModel]?
        
        enum CodingKeys: String, CodingKey {
            case statusCode
            case results
        }
    }
    
    struct CharacterModel: Codable{
        var id: String
        var type: String
        var description: String
        var category: String
        var characterType: String
        var name: String
        var thumbnail: String
        var thumbnailAnimated: String
        var motionId: String?
        //var motions: String?
        var source: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case type
            case description
            case category
            case characterType = "character_type"
            case name
            case thumbnail
            case thumbnailAnimated = "thumbnail_animated"
            case motionId = "motion_id"
            //case motions
            case source
        }
    }
}
