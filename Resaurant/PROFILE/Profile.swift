import Foundation

struct Profile {
  var firstName:String
  var lastName:String
  var email:String
    var isLoggedIn: Bool
  var id = UUID()
  
    init(new: Bool = false,
         firstName: String = "",
       lastName: String = "",
       email: String = "",
       isLoggedIn: Bool = false) {
      
        if new == true {
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.isLoggedIn = isLoggedIn
        } else {
            let context = PersistenceController.shared.container.viewContext
            
            if let customer = Customer.customerLoggedIn(context) {
                
                self.firstName = customer.firstName
                self.lastName = customer.lastName
                self.email = customer.email
                self.isLoggedIn = customer.isLoggedIn
                print("profile called: \(customer): \(self)")
            } else {
                
                self.firstName = firstName
                self.lastName = lastName
                self.email = email
                self.isLoggedIn = isLoggedIn
                print("profile called else: \(self)")
            }
        }
  }
  
}



