import SwiftUI

struct CartItem: Identifiable {
    let id = UUID()
    let recipe: Recipe
    var quantity: Int
    var weight: Int
    
    // ✅ Пересчёт цены через метод computedPrice(for:)
    var totalPrice: Double {
        recipe.computedPrice(for: weight) * Double(quantity)
    }
}

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var selectedTab: Tab = .kart
    
    var body: some View {
        ZStack {
            // ✅ Фон корзины
            Image("clover1")
                .resizable()
                .scaledToFill()
                .frame(width: 160)
                .frame(height: 200)
                .padding(.top, -200)
                .padding(.leading, -210)
                .ignoresSafeArea()
            
            Image("clover2")
                .resizable()
                .scaledToFill()
                .frame(width: 150)
                .frame(height: 200)
                .padding(.top, 300)
                .padding(.leading, 250)
                .ignoresSafeArea()
            
            if cartViewModel.cartItems.isEmpty {
                VStack {
                    Text("Wagen")
                        .font(.custom("Sen-Regular", size: 22))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                        .padding(.horizontal)

                    Spacer()
                    
                    Image("emptyCart")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 600)
                }
            } else {
                VStack(alignment: .leading) {
                    // ✅ Заголовок корзины
                    Text("Wagen")
                        .font(.custom("Sen-Regular", size: 22))
                        .bold()
                        .padding()
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(cartViewModel.cartItems) { item in
                                HStack {
                                    // ✅ Изображение рецепта
                                    AsyncImage(url: URL(string: item.recipe.imageURL)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(10)
                                    
                                    VStack(alignment: .leading) {
                                        Text(item.recipe.name)
                                            .font(.custom("Sen-Regular", size: 18))
                                            .bold()
                                        
                                        Text(item.recipe.description)
                                            .font(.custom("Sen-Regular", size: 14))
                                            .foregroundColor(.gray)
                                        
                                        // ✅ Отображение корректной цены
                                        Text("Insgesamt: €\(String(format: "%.2f", item.totalPrice))")
                                            .font(.custom("Sen-Regular", size: 18))
                                            .bold()
                                            .foregroundColor(.black)
                                        
                                        Text("\(item.weight) Gr.")
                                            .font(.custom("Sen-Regular", size: 16))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    // ✅ Количество +/-
                                    HStack {
                                        Button(action: {
                                            if item.quantity > 1 {
                                                if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }) {
                                                    cartViewModel.cartItems[index].quantity -= 1
                                                }
                                            } else {
                                                cartViewModel.removeFromCart(item: item)
                                            }
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Text("\(item.quantity)")
                                            .font(.custom("Sen-Regular", size: 18))
                                            .frame(width: 30, alignment: .center)
                                            .foregroundColor(.black)
                                        
                                        Button(action: {
                                            if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }) {
                                                cartViewModel.cartItems[index].quantity += 1
                                            }
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // ✅ Адрес доставки
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lieferadresse")
                            .font(.custom("Sen-Regular", size: 18))
                            .bold()
                        
                        HStack {
                            Text("86304 Friedberg, Albrechtsstrasse, 6")
                                .font(.custom("Sen-Regular", size: 16))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Bearbeiten")
                                .font(.custom("Sen-Regular", size: 16))
                                .foregroundColor(Color(red: 63/255, green: 193/255, blue: 46/255))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        // ✅ Кнопка "Оформить заказ"
                        Button(action: {
                            // ✅ Действие при оформлении заказа
                        }) {
                            Image("bestell")
                                .resizable()
                                .frame(width: 350, height: 60)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


