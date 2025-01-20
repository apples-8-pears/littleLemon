//
//  Dish+CoreDataProperties.swift
//  M4Exercise
//
//  Created by Brenda Doty on 1/15/25.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String
    @NSManaged public var price: Double
    @NSManaged public var image: String

}

extension Dish : Identifiable {

}
