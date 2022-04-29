//
//  Article.swift
//  PI UNIPAM
//
//  Created by Danilo Constancio on 24/04/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Article: Equatable, Codable {
    
    let id: String
    let title: String
    let subtitle: String
    let createdAt: Date
    let text: String
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        
        case id, title, subtitle, createdAt, text, author
    }
}
