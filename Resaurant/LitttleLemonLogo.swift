import SwiftUI

struct LittleLemonLogo: View {
    var body: some View {
        VStack {
            Image("littleLemon")
                .padding(.top, 50)
            Text("Chicago")
                .font(.title.bold())
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 120)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a mondern twist.")
                .font(.headline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 40)
                .padding(.leading, 50)
                .padding(.top, 2)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
    }
}

struct LittleLemonLogo_Previews: PreviewProvider {
    static var previews: some View {
        LittleLemonLogo()
    }
}


