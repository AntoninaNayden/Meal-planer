import SwiftUI

struct LieferungScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    // ✅ Spacer для позиционирования в верхней части экрана
                    Spacer()
                        .frame(height: 0)
                    
                    // ✅ Изображение "lief" теперь в верхней части экрана
                    Image("lief")
                        .resizable()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.435)
                        .padding(.top, geometry.size.width * 0.19)
                        .position(x: geometry.size.width / 2, y: 0 )
                    
                    Image("liefcart")
                        .resizable()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.635)
                        .padding(.top, -84)
                }
                .padding()
                
                // ✅ Кнопка "Назад" в верхнем левом углу
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color(red: 236/255, green: 240/255, blue: 244/255))
                        .frame(width: geometry.size.width * 0.09, height: geometry.size.width * 0.09)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        )
                        .shadow(radius: 4)
                }
                .padding(.leading, 16)
                .padding(.top, 16) // ✅ Позиционирование в верхнем левом углу
                .zIndex(1) // ✅ Поднимаем кнопку выше остальных элементов
                
                // ✅ Прокручиваемое изображение внизу
                ScrollView {
                    Image("lieflist")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .padding(.top, geometry.size.width * 0.6)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LieferungScreen()
}

