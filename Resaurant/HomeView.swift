import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var model = Model()
    @State var tabSelection = 0
    @State var previousTabSelection = -1 // any invalid value
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            TabView (selection: $model.tabViewSelectedIndex){
                OurDishes()
                    .tag(0)
                    .tabItem {
                        Label("Menu", systemImage: "fork.knife.circle")
                    }
                    .onAppear() {
                        tabSelection = 0
                    }
                
                ProfileView(tabSelection: $tabSelection, tabViewSelection: $model.tabViewSelectedIndex, isLoggedIn: $isLoggedIn)
                    .tag(1)
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
                    .onAppear() {
                        tabSelection = 1
                    }
            }
            .id(tabSelection)
            .environmentObject(model)

        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    @State static var isLoggedIn = true
    static var previews: some View {
        HomeView(isLoggedIn: $isLoggedIn).environmentObject(Model()).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}




