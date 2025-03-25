import SwiftUI

struct OrderCart: View {
    @State private var navigateToLogin = false
    @State private var navigateToSignUp = false
    var body: some View {
        if navigateToLogin {
            //Login()
        } else if navigateToSignUp {
           // SignUp()
        } else {
            VStack {
                VStack(spacing: 0) {
                    Image("OrderSuccess")
                        .resizable()
                        .frame(width: 400,height: 570)
                        .padding(.leading, 70)
                    Button(action: {
                    }, label: {
                        Image("order")
                            .resizable()
                            .frame(width: 335, height: 60)
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 243/255, green: 255/255, blue: 220/255))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OrderCart()
}


