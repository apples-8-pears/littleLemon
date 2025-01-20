//
//  ProfileView.swift
//  M4Exercise
//
//  Created by Brenda Doty on 1/15/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var tabSelection: Int
    @Binding var tabViewSelection: Int
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Image("littleLemon")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 5)
                    .padding(.leading, 60)
                    .padding(.trailing, 40)
                
                VStack {
                    Text("Personal Information")
                        .font(.headline)
                    Image("Profile Picture")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .frame(maxWidth: .infinity)
                
                ProfileForm(isLoggedIn: $isLoggedIn)
                
            }
            .navigationBarTitle("", displayMode: .inline) // Optional: Customize the title for the nav bar
            .toolbar {
                // Optional: Add a custom back button if needed
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        tabSelection = 0 // Switch to Menu tab
                        tabViewSelection = 0
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.blue)
                    }
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var tabSelection = 1
    @State static var tabViewSelection = 0
    @State static var isLoggedIn = true
    
    static var previews: some View {
        ProfileView(tabSelection: $tabSelection, tabViewSelection: $tabViewSelection, isLoggedIn: $isLoggedIn)
            .environmentObject(Model())
    }
}
