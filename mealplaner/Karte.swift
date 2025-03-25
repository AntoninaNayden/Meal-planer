import SwiftUI
struct Karte: View {
    @State private var navigateToLogin = false
    @State private var navigateToSignUp = false
    @State private var showPopup = true
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    VStack(spacing: 0) {
                        Image("karte")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 1.1) // 110% ширины экрана (для растяжки)
                            .frame(height: geometry.size.height * 1.1) // 110% высоты экрана
                            .padding(.top, -geometry.size.height * 0.15) // Смещение вверх на 10% высоты
                            .padding(.leading, -geometry.size.height * 0.035)
                    }
                }
                .background(
                    Image("fonKarte")
                        .resizable()
                        .scaledToFill()
                        .padding(.leading, -geometry.size.height * 0.35)
                        .frame(width: geometry.size.width, height: geometry.size.height) // Растягиваем фон на весь экран
                        .ignoresSafeArea()
                )
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    Karte()
}

