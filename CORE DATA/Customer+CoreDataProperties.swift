//
//  Customer+CoreDataProperties.swift
//  M4Exercise
//
//  Created by Brenda Doty on 1/15/25.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var email: String
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var isLoggedIn: Bool

}

extension Customer : Identifiable {

}
