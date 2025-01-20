import SwiftUI

struct ProfileForm: View {
    
    @EnvironmentObject var model:Model
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Form {
                Group{
                    Group{
                        VStack(alignment: .leading) {
                            Text("First Name: ")
                                .font(.caption)
                            TextField(isLoggedIn ? firstName : "FirstName", text: $firstName)
                            
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Last Name: ")
                                .font(.caption)
                            TextField(isLoggedIn ? lastName : "LastName", text: $lastName)
                            
                        }
                        .padding(.bottom)
                        .onAppear {
                            print(isLoggedIn)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("email: ")
                                .font(.caption)
                            TextField(isLoggedIn ? email : "email@emailProvider", text: $email)
                                .keyboardType(.emailAddress)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        .padding(.bottom)
                    }
                    .padding(.bottom)
                    
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text(isLoggedIn ? "Update Profile" : "Register/Loggin")
                    })
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 10)
                    
                    if isLoggedIn {
                        
                        Button(action: {
                            validateForm(logout: true)
                        }, label: {
                            Text("Logout")
                        })
                        .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                        .background(Color.yellow)
                        .cornerRadius(20)
                        .padding(.top, 10)
                    }

                }
                
            }
            .padding(.top, -40)
            .scrollContentBackground(.hidden)
            .alert("ERROR", isPresented: $showFormInvalidMessage, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(self.errorMessage)
            })
        }
        .onAppear {
            print("on appear")
            let profile = Profile()
            if profile.isLoggedIn {
                firstName = profile.firstName
                lastName = profile.lastName
                email = profile.email
            }
        }
    }
    
    private func validateForm(logout: Bool = false) {
        let context = PersistenceController.shared.container.viewContext
        
        let firstNameIsValid = isValid(name: firstName)
        let lastNameIsValid = isValid(name: lastName)
        let emailIsValid = isValid(email: email)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid
        else {
            var invalidNameMessage = ""
            if (firstName.isEmpty || !isValid(name: firstName)) || (lastName.isEmpty || !isValid(name: lastName)) {
                invalidNameMessage = "Names can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidEmailMessage = ""
            if !email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "Email cannot be blank or have an invalid email form."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n \(invalidNameMessage)\(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return
        }
        
        if logout {
            
            Customer.deleteAllCustomer(context)
            isLoggedIn = false
            
        } else {
            
            let temporaryProfile = Profile(
                firstName: firstName,
                lastName: lastName,
                email: email,
                isLoggedIn: true
            )
            print("temp profile: \(temporaryProfile)")
            
            Customer.add(oldProfile: model.profile, newProfile: temporaryProfile, context)
            
            isLoggedIn = true
        }
        
        let profile = Profile()
        print("profile after save: \(profile)")
        model.profile = profile
        firstName = profile.firstName
        lastName = profile.lastName
        email = profile.email
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    
}

struct ProfileForm_Previews: PreviewProvider {
    @State static var isLoggedIn = true
    
    static var previews: some View {
        ProfileForm(isLoggedIn: $isLoggedIn).environmentObject(Model())
    }
}









