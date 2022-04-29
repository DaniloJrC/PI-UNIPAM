//
//  Author.swift
//  PI UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import Foundation

struct Author: Equatable, Codable {
    
    let id: String
    let name: String
    let createdAt: Date
    let biography: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, name, createdAt, biography
    }
}
