import SwiftUI
import CoreData

struct OurDishes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""
    
    var body: some View {
        VStack {
            LittleLemonLogo()
                .padding(.bottom, 20)
            
            NavigationView {
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List(dishes) { dish in
                            DisplayDish(dish: dish)
                        }
                        .searchable(text: $searchText)
                    }
            }
            .padding(.top, -10)//
            .scrollContentBackground(.hidden)
            .task {
               await dishesModel.reload(viewContext)
           }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    private func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            let searchText = searchText.lowercased()
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        let sortDescriptor = NSSortDescriptor(
            keyPath: \Dish.title,
            ascending: true)
        return [sortDescriptor]
    }
}

struct OurDishes_Previews: PreviewProvider {
    static var previews: some View {
        OurDishes().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}






