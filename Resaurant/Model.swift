import Foundation

class Model:ObservableObject {
  
    @Published var profile = Profile()
    @Published var followNavitationLink = false
  
  @Published var displayTabBar = true
  @Published var tabBarChanged = false
  @Published var tabViewSelectedIndex = Int.max {
    didSet {
      tabBarChanged = true
    }
  }
}
