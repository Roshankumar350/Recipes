//
//  Recipes+CoreDataProperties.swift
//  Recipe
//
//  Created by Roshan sah on 23/11/20.
//
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var label: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var welcomeDescription: String?

}

extension Recipes : Identifiable {
    
}

extension Recipes {
    static func > (lhs: Recipes, rhs: Recipes) -> Bool {
        return lhs.price ?? "" > rhs.price ?? ""
    }
    static func < (lhs: Recipes, rhs: Recipes) -> Bool {
        return lhs.price ?? "" < rhs.price ?? ""
    }
}
