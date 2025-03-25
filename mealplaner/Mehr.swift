import SwiftUI

struct MainScreen: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                Image("mehr")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.18)
                
                VStack(spacing: 40) {
                    NavigationLink(destination: LieferungScreen()) {
                        HStack {
                            VStack {
                                Image("liefer")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14)
                            }
                            .frame(width: geometry.size.width * 0.15)
                            
                            VStack {
                                Text("Lieferung")
                                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.05))
                                    .foregroundColor(.black)
                            }
                            .frame(width: geometry.size.width * 0.4)
                            
                            VStack {
                                Image("right")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.width * 0.09)
                            }
                            .frame(width: geometry.size.width * 0.1)
                        }
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.09)
                    }
                    
                    NavigationLink(destination: WerbeaktionenScreen()) {
                        HStack {
                            VStack {
                                Image("werbe")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14)
                            }
                            .frame(width: geometry.size.width * 0.15)
                            
                            VStack {
                                Text("Werbeaktionen")
                                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.05))
                                    .foregroundColor(.black)
                            }
                            .frame(width: geometry.size.width * 0.4)
                            
                            VStack {
                                Image("right")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.width * 0.09)
                            }
                            .frame(width: geometry.size.width * 0.1)
                        }
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.09)

                    }
                    
                    NavigationLink(destination: RueckmeldungScreen()) {
                        HStack {
                            VStack {
                                Image("ruck")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.14, height: geometry.size.width * 0.14)
                            }
                            .frame(width: geometry.size.width * 0.15)
                            
                            VStack {
                                Text("Rückmeldung")
                                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.05))
                                    .foregroundColor(.black)
                            }
                            .frame(width: geometry.size.width * 0.4)
                            
                            VStack {
                                Image("right")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.09, height: geometry.size.width * 0.09)
                            }
                            .frame(width: geometry.size.width * 0.1)
                        }
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height * 0.09)
                    }
                }
                .frame(width: geometry.size.width * 0.87)
                .padding(.vertical, 40)
                .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                .cornerRadius(geometry.size.width * 0.03)
                .padding(.bottom, geometry.size.height * 0.57)
            }
          
        }
        .navigationBarBackButtonHidden(true)
    }
}

import SwiftUI

struct WerbeaktionenScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack(spacing: 0) {
                    Image("werb")
                        .resizable()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.6)
                        .padding(.top, -geometry.size.width * 0.3)
                    
                    Image("sales")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 1.0)
                        .padding(.top, -30)
                }
                .padding()
                
                // ✅ Кнопка назад в верхнем левом углу
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color(red: 236/255, green: 240/255, blue: 244/255))
                        .frame(width: geometry.size.width * 0.082, height: geometry.size.width * 0.082)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        )
                        .shadow(radius: 4)
                }
                .padding(.leading, 16)
                .padding(.top, 16) // ✅ Позиционирование в верхнем левом углу
                .zIndex(1) // ✅ Поднимаем кнопку выше всех элементов
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WerbeaktionenScreen()
}


struct RueckmeldungScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack {
                    VStack(spacing: 0) {
                        Image("ruckmel")
                            .resizable()
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.3)
                            .padding(.top, -14)
                    }
                    
                    // ✅ Поля ввода
                    VStack(alignment: .leading, spacing: 15) {
                        Text("VOLLSTÄNDIGER NAME")
                            .font(.custom("Sen-Regular", size: 14))
                            .foregroundColor(.black)
                        TextField("Gast", text: .constant(""))
                            .padding()
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(12)
                        
                        Text("EMAIL")
                            .font(.custom("Sen-Regular", size: 14))
                            .foregroundColor(.black)
                        TextField("hellogmail.com", text: .constant(""))
                            .padding()
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(12)
                        
                        Text("RUFNUMMER")
                            .font(.custom("Sen-Regular", size: 14))
                            .foregroundColor(.black)
                        TextField("408-841-0926", text: .constant(""))
                            .padding()
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(12)
                        
                        Text("KOMMENTAR")
                            .font(.custom("Sen-Regular", size: 14))
                            .foregroundColor(.black)
                        TextField("Kommentar", text: .constant(""))
                            .padding()
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(12)
                        
                        // ✅ Кнопка отправки
                        Button(action: {}) {
                            Image("senden")
                                .resizable()
                                .frame(width: geometry.size.width * 0.9, height: 70)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                // ✅ Кнопка назад в верхнем левом углу
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color(red: 236/255, green: 240/255, blue: 244/255))
                        .frame(width: geometry.size.width * 0.082, height: geometry.size.width * 0.082)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        )
                        .shadow(radius: 4)
                }
                .padding(.leading, 16)
                .padding(.top, 16) // ✅ Позиционирование в верхнем левом углу
                .zIndex(1) // ✅ Поднимаем кнопку выше всех элементов
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    RueckmeldungScreen()
}


#Preview {
    MainScreen()
}

