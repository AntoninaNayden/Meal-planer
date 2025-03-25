import SwiftUI

struct LoadingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var isLoadingComplete = false
    @AppStorage("isRegistered") private var isRegistered: Bool = false
    @State private var navigateToLogin = false
    @State private var navigateToSignUp = false
    var body: some View {
        if navigateToLogin {
            Login()
        }
        else if navigateToSignUp {
            SignUp()
        }
        else {
            VStack{
                ZStack {
                    Image("greenClover")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .overlay(
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 200 * (1 - progress))
                                .animation(.easeInOut(duration: 7), value: progress),
                            alignment: .top
                        )
                }
                .background(Color.white)
                .onAppear {
                    progress = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                        isLoadingComplete = true
                        if isRegistered {
                            navigateToLogin = true
                        } else {
                            navigateToSignUp = true
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .background(
                Image("fon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 950, height: 1350)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    LoadingView()
}

