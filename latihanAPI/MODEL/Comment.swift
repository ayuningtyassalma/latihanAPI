//
//  File.swift
//  latihanAPI
//
//  Created by Salma Ayu on 14/03/23.
//

import Foundation


struct Comment: Codable {
    var postId : Int
    var id : Int
    var name : String
    var email : String
    var body : String
    
    enum CodingKeys: CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
}
