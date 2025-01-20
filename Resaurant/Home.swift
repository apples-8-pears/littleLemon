//
//  Home.swift
//  M4Exercise
//
//  Created by Brenda Doty on 1/15/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            LittleLemonLogo()
            
            OurDishes()
                .padding()
        }
    }
}

#Preview {
    Home().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
