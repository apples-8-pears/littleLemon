import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        for menuItem in menuItems {
            
            let dish = Dish(context: context)
            dish.title = menuItem.title
            if let priceFloat = Double(menuItem.price) {
                dish.price = priceFloat
            } else {
                dish.price = 0.00
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save createDishesFrom", error)
        }
    }
    
    static func deleteAllDish(_ context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
        do {
            try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
            
            try context.save()
        } catch {
            print("Failed to clear records for Dish: \(error.localizedDescription)")
        }
    }
    
}
