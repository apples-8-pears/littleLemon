//
//  Customer+Extension.swift
//  M4Exercise
//
//  Created by Brenda Doty on 1/15/25.
//

import Foundation
import CoreData


extension Customer {
    
    static func customerLoggedIn(_ context:NSManagedObjectContext) -> Customer? {
        
        let fetchRequest: NSFetchRequest<Customer> = NSFetchRequest(entityName: "Customer")
        
        do {
            let results = try context.fetch(fetchRequest)
            print("customerloggedin results: \(results.count)")
            if !results.isEmpty {
                let predicate = NSPredicate(format: "isLoggedIn == %@", NSNumber(value: true))
                
                    fetchRequest.predicate = predicate
                    
                do {
                    let results = try context.fetch(fetchRequest)
                    if !results.isEmpty {
                        return results.first
                    }
                } catch {
                    print("error while searching for customer: \(error)")
                }
            }
        } catch {
            print("error while searching for customer: \(error)")
        }
        
        return nil
    }
    
    static func customerExists(profile: Profile, _ context:NSManagedObjectContext) -> Customer? {
        
        let fetchRequest: NSFetchRequest<Customer> = NSFetchRequest(entityName: "Customer")
        
        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                        NSPredicate(format: "firstName == %@", profile.firstName),
                        NSPredicate(format: "lastName == %@", profile.lastName),
                        NSPredicate(format: "email == %@", profile.email)
                    ])
                
                    fetchRequest.predicate = predicate
                    
                do {
                    let results = try context.fetch(fetchRequest)
                    if !results.isEmpty {
                        return results.first
                    }
                } catch {
                    print("error while searching for customer: \(error)")
                }
            }
        } catch {
            print("error while searching for customer: \(error)")
        }
        
        return nil
    }

    static func add(oldProfile:Profile, newProfile: Profile, _ context:NSManagedObjectContext) {
        print("old: \(oldProfile), new: \(newProfile)")
        
        if let customer = self.customerExists(profile: oldProfile, context) {
            customer.firstName = newProfile.firstName
            customer.lastName = newProfile.lastName
            customer.email = newProfile.email
            customer.isLoggedIn = newProfile.isLoggedIn
            
            print("saving customer exists: \(customer)")
            
        } else {
            let customer = Customer(context: context)
            customer.firstName = newProfile.firstName
            customer.lastName = newProfile.lastName
            customer.email = newProfile.email
            customer.isLoggedIn = newProfile.isLoggedIn
            
            print("saving customer: \(customer)")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save Customer: \(error.localizedDescription)")
        }
    }
    
    static func deleteAllCustomer(_ context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Customer")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
        do {
            try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
            
            try context.save()
        } catch {
            print("Failed to clear records for Customer: \(error.localizedDescription)")
        }
    }
    
}
