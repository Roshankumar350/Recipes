//
//  Recipe.swift
//  Recipe
//
//  Created by Roshan sah on 22/11/20.
//

import Foundation

struct Recipe: Codable, Hashable, Equatable {
    
    enum Category: String, Codable, CaseIterable, Hashable {
        case mains
        case appetizer
        case dessert
        case clone
        case weird
        
        enum CodingKeys: String, CodingKey {
            case mains
            case appetizer
            case dessert
            case clone
            case weird
        }
    }
    
    let id: Int
    let name: String
    let image: String
    let category: Category
    let label: String
    let price: String
    let welcomeDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, category, label, price
        case welcomeDescription = "description"
    }
}
