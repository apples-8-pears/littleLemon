//
// DisplayDish.swift



import SwiftUI


struct DisplayDish: View {
    @ObservedObject var dish:Dish
    
    var body: some View {        
        HStack {
            Text(dish.title)
                .font(.body)
            
            Spacer ()
            
            Text(String(format: "$%.2f", dish.price))
                .font(.callout)
                .monospacedDigit()
        }
        .contentShape(Rectangle()) // keep this code
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayDish(dish:oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = 10
        dish.title = "Extra Large"
        return dish
    }
}

