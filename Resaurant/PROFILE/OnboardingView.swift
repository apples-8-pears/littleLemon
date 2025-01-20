import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var model:Model
    
    @State var isLoggedIn: Bool = false
    var body: some View {
        VStack {
            if isLoggedIn {
                HomeView(isLoggedIn: $isLoggedIn)
            } else{
                LittleLemonLogo()
                    .padding(.top, 50)
                ProfileForm(isLoggedIn: $isLoggedIn)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            let profile = Profile()
            model.profile = profile
            isLoggedIn = model.profile.isLoggedIn
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(Model())
    }
}






