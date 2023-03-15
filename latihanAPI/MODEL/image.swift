//
//  image.swift
//  latihanAPI
//
//  Created by Salma Ayu on 15/03/23.
//

import Foundation

struct ImageApi: Codable {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailUrl : String
    
    enum CodingKeys : CodingKey{
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
