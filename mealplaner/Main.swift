import SwiftUI

struct Recipe: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: String
    let category: String
    let imageURL: String
    let price: String
    let weight: String
    
    private let baseWeight = 150
       
       var basePrice: Double {
           Double(price.replacingOccurrences(of: "€", with: "").replacingOccurrences(of: ",", with: ".")) ?? 0.0
       }
       
       func computedPrice(for weight: Int) -> Double {
           let weightFactor = Double(weight) / Double(baseWeight)
           return basePrice * weightFactor
       }
}

let recipes: [Recipe] = [
    Recipe(name: "Brotkorb", description: "Brotkorb mit Brot und Brezel, serviert mit Pfeffer- und Frischkäsesauce", ingredients: "Brot, Brezel, Pfeffersauce, Frischkäse.", category: "APERITIFS", imageURL: "https://okulusr.cyou/images/Image-APERITIFS-1.jpg", price: "€4,50", weight: "300 gr"),
    
    Recipe(name: "Flammkuchen", description: "Dünner knuspriger Boden + zarte Crème fraîche = der perfekte Boden für Flammkuchen.", ingredients: "Knuspriger Teig, Speck, rote Zwiebeln, Champignons, Käse, Paprika, grüne Zwiebeln.", category: "APERITIFS", imageURL: "https://okulusr.cyou/images/Image-APERITIFS-2.jpg", price: "€5,75", weight: "500 gr"),
    
    Recipe(name: "Kartoffelsuppe", description: "In den kalten Herbst- und Wintermonaten gibt es nichts Besseres als eine warme und wärmende Kartoffelsuppe.", ingredients: "Kartoffeln, Lauch, Karotten, Zwiebeln, Knoblauch, Sahne, Speck, Wurst.", category: "APERITIFS", imageURL: "https://okulusr.cyou/images/Image-APERITIFS-3.jpg", price: "€5,25", weight: "350 gr"),
    
    Recipe(name: "Käse- und Fleischplatte", description: "Jeder ist herzlich eingeladen, einen Käse-Aperitif zu genießen.", ingredients: "Blauschimmelkäse, Bergkäse, Brie, Kräuterfrischkäse, Cheddar, Gouda", category: "APERITIFS", imageURL: "https://okulusr.cyou/images/Image-APERITIFS-4.jpg", price: "€7,75", weight: "330 gr"),
    
    Recipe(name: "Käsefondue", description: "Käsefondue mit französischem Baguette und frischem Gemüse", ingredients: "Baguette, Gruyere, Emmentaler, Knoblauch, Weißwein, Kirschwasser, Pfeffer, Muskatnuss", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-1.jpg", price: "€15,75", weight: "200 gr"),
    
    Recipe(name: "Bratwurst und Currywurst", description: "Traditionelle deutsche Würstchen, serviert mit Kartoffelpüree und Sauerkraut", ingredients: "Deutsche Würstchen, Kartoffelpüree, Sauerkraut.", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-2.jpg", price: "€15,25", weight: "225 gr"),
    
    Recipe(name: "Halbes Hänchen", description: "Ein halbes gegrilltes Hähnchen, serviert mit Kartoffelsalat, Krautsalat und Apfelmus", ingredients: "Gegrilltes Hähnchen, Kartoffelsalat, Krautsalat, Apfelpüree", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-3.jpg", price: "€16,75", weight: "280 gr"),
    
    Recipe(name: "Schnitzel", description: "Klassisches Schweineschnitzel, serviert mit Bratkartoffeln, Rahmfleisch und Preiselbeersauce", ingredients: "Schweinefleisch, Bratkartoffeln, Rahm- und Fleischsauce, Preiselbeersauce.", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-4.jpg", price: "€16,75", weight: "300 gr"),
    
    Recipe(name: "Rindergoulash", description: "Rindergulasch, serviert mit Bauernbrot und Krautsalat", ingredients: "Gulasch, Brot, Krautsalat.", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-5.jpg", price: "€15,50", weight: "330 gr"),
    
    Recipe(name: "Ziegenkäsesalat", description: "Ziegenkäse-Rollsalat mit Gemüse ist eine wunderbare Kombination aus Geschmack und Farbe.", ingredients: "Ziegenkäse, Zwiebeln, frische Gurken, Kirschtomaten, Croutons, Cashews und Rösti", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-6.jpg", price: "€13,50", weight: "275 gr"),
    
    Recipe(name: "Vegetarische Wurstplatte", description: "Ein Teller mit heißen vegetarischen Würstchen, serviert mit Kartoffelpüree und Sauerkraut", ingredients: "Vegetarische Würstchen, Kartoffelpüree, Sauerkraut.", category: "HAUPTKURSE", imageURL: "https://okulusr.cyou/images/Image-HAUPTKURSE-7.jpg", price: "€15,25", weight: "260 gr"),
    
    Recipe(name: "Schweinhaxe", description: "Knusprige Schweineknie, serviert mit gebackenen Minikartoffeln und Ratatouille von Sommergemüse", ingredients: "Schweinefleisch, gebackene Kartoffeln, Ratatouille, Gemüse.", category: "UNSERE SPEZIALITÄTEN", imageURL: "https://okulusr.cyou/images/Image-UNSERE%20SPEZIALIT%C3%84TEN-1.jpg", price: "€18,50", weight: "770 gr"),
    
    Recipe(name: "Bratkartoffeln", description: "Kartoffeln mit Kräutern aus dem Ofen", ingredients: "Kartoffeln, Kräuter", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-1.jpg", price: "€3,25", weight: "185 gr"),
    
    Recipe(name: "Gemischter Salat", description: "Salat - ein gemischter Salat ist immer lecker, ob im Restaurant oder nach der Arbeit.", ingredients: "Grüner Salat, Tomaten, Gurken, Mais, rote Zwiebeln, Radieschen, Brunnenkresse, Feta", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-2.jpg", price: "€2,75", weight: "220 gr"),
    
    Recipe(name: "Sauerkraut", description: "Kartoffelpüree mit Sauerkraut", ingredients: "Kartoffeln, Sauerkraut", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-3.jpg", price: "€3,25", weight: "150 gr"),
    
    Recipe(name: "Weißkohlsalat", description: "Dieser klassische Weißkohlsalat passt gut zu gebratenen oder gegrillten Gerichten", ingredients: "Salat aus Weißkohl, Karotten, Zwiebeln, Mayonnaise-Dressing", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-4.jpg", price: "€3,00", weight: "180 gr"),
    
    Recipe(name: "Kartoffelsalat", description: "Klassischer hausgemachter Kartoffelsalat", ingredients: "Kartoffeln, Senf, Essig, Zwiebeln", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-5.jpg", price: "€4,00", weight: "200 gr"),
    
    Recipe(name: "Rösti", description: "Kartoffelhackbraten", ingredients: "Ei, Kartoffeln", category: "WARNIER", imageURL: "https://okulusr.cyou/images/Image-WARNIER-6.jpg", price: "€4,50", weight: "320 gr"),
    
    Recipe(name: "Heiße Liebe mit Schokolade", description: "Vanilleeis mit Beeren, Schokoladenstückchen und Schlagsahne", ingredients: "Eiscreme, Beeren, Schokolade, Sahne.", category: "NACHSPEISEN", imageURL: "https://okulusr.cyou/images/Image-NACHSPEISEN-1.jpg", price: "€5,25", weight: "215 gr"),
    
    Recipe(name: "Apfelstrudel", description: "Apfelstrudel mit Vanillesoße und Rote Grütze (ein traditionelles deutsches Dessert aus Waldbeeren)", ingredients: "Apfel, Beeren, Vanillesoße", category: "NACHSPEISEN", imageURL: "https://okulusr.cyou/images/Image-NACHSPEISEN-2.jpg", price: "€7,25", weight: "330 gr"),
    
    Recipe(name: "Milchmädchen Himbeeren Tarte", description: "Benannt nach der Kondensmilch von Milkmädchen", ingredients: "Kondensmilch, Hüttenkäse, Beeren.", category: "NACHSPEISEN", imageURL: "https://okulusr.cyou/images/Image-NACHSPEISEN-3.jpg", price: "€5,75", weight: "250 gr")
]

struct RecipeDetailView: View {
    let recipe: Recipe
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var selectedWeight: Int = 150
    @State private var quantity: Int = 1
    @State private var isRestaurantViewPresented = false
    @Environment(\.presentationMode) var presentationMode // Добавляем переменную для закрытия попапа
    
    var calculatedPrice: Double {
        recipe.computedPrice(for: selectedWeight) * Double(quantity)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: recipe.imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(recipe.name)
                            .font(.custom("Sen-Regular", size: 24))
                            .foregroundColor(.black)
                            .bold()
                        Button(action: {
                            isRestaurantViewPresented.toggle()
                        }) {
                            Image("restaurant")
                                .resizable()
                                .frame(width: 140, height: 35)
                        }
                        
                        HStack {
                            Image("restaurantIcon")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        Text(recipe.description)
                            .font(.custom("Sen-Regular", size: 18))
                            .foregroundColor(Color(red: 160/255, green: 165/255, blue: 186/255))
                        
                        Spacer()
                            .frame(height: 20)
                        
                        // Выбор веса
                        HStack(spacing: 0) {
                            Text("Größe:")
                                .font(.custom("Sen-Regular", size: 20))
                                .bold()
                                .foregroundColor(Color(red: 160/255, green: 165/255, blue: 186/255))
                            
                            ForEach([100, 150, 200], id: \.self) { weight in
                                Button(action: {
                                    selectedWeight = weight
                                }) {
                                    Text("\(weight) Gr.")
                                        .font(.custom("Sen-Regular", size: 14))
                                        .foregroundColor(selectedWeight == weight ? .white : .black)
                                        .padding(17)
                                        .background(
                                            Circle()
                                                .fill(selectedWeight == weight ? Color(red: 63/255, green: 193/255, blue: 46/255) : Color(red: 240/255, green: 245/255, blue: 250/255))
                                                .frame(width: 70, height: 70)
                                        )
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        // Ингредиенты
                        Text("Ingredients:")
                            .font(.custom("Sen-Regular", size: 20))
                            .bold()
                            .foregroundColor(.black)
                        
                        Text(recipe.ingredients)
                            .font(.custom("Sen-Regular", size: 18))
                            .foregroundColor(Color(red: 160/255, green: 165/255, blue: 186/255))
                    }
                    .padding()
                    
                    // Количество и цена
                    HStack {
                        ZStack {
                            Image("blackFon")
                                .resizable()
                                .frame(width: 150, height: 70)
                            
                            HStack(spacing: 0) {
                                Button(action: {
                                    if quantity > 1 { quantity -= 1 }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                                
                                Text("\(quantity)")
                                    .font(.custom("Sen-Regular", size: 20))
                                    .frame(width: 40, alignment: .center)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    quantity += 1
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.top, -20)
                        }
                        
                        Text("€\(String(format: "%.2f", calculatedPrice))")
                            .font(.custom("Sen-Regular", size: 24))
                            .bold()
                            .foregroundColor(.black)
                            .padding(.top, -22)
                    }
                    
                    // Кнопка "Добавить в корзину"
                    Button(action: {
                        cartViewModel.addToCart(recipe: recipe, quantity: quantity, weight: selectedWeight)
                        
                        // Закрытие попапа после добавления в корзину
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("addToCart")
                            .resizable()
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.09)
                            //.frame(maxWidth: .infinity)
                           // .frame(height: 60)
                    }
                    .padding()
                    .padding(.top, -30)
                }
            }
            .sheet(isPresented: $isRestaurantViewPresented) {
                RestaurantDetailView()
            }
            .navigationTitle("Recipe Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


enum Tab {
    case home
    case kart
    case geo
    case profile
    case drops
}


struct MainTabView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedTab = .home
            }) {
                ZStack{
                    if (selectedTab == .home){
                        Image("greenfon")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .padding(.top, 20)
                    }
                    else{
                        
                    }
                    VStack {
                        Image("tab1")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .font(.system(size: 24))
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = .kart
            }) {
                ZStack{
                    if (selectedTab == .kart){
                        Image("greenfon")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .padding(.top, 20)
                    }
                    else{
                        
                    }
                    VStack {
                        Image("tab2")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = .geo
            }) {
                ZStack{
                    if (selectedTab == .geo){
                        Image("greenfon")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .padding(.top, 20)
                    }
                    else{
                        
                    }
                    VStack {
                        Image("tab3")
                            .resizable()
                            .frame(width: 30, height: 30)
                           
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = .profile
            }) {
                ZStack{
                    if (selectedTab == .profile){
                        Image("greenfon")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .padding(.top, 20)
                    }
                    else{
                        
                    }
                    VStack {
                        Image("tab4")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            
            Spacer()
            Button(action: {
                selectedTab = .drops
            }) {
                ZStack{
                    if (selectedTab == .drops){
                        Image("greenfon")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .padding(.top, 20)
                    }
                    else{
                        
                    }
                    VStack {
                        Image("tab5")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .frame(width: 400, height: 100)
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}


struct RestaurantDetailView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var selectedRecipe: Recipe?
    @State private var selectedCategory: String = "Lebensmittel"
    var body: some View {
        GeometryReader{ geometry in
            ScrollView {
                VStack {
                    // Изображение ресторана
                    Image("restaurantImage")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Image("kartofel")
                            .resizable()
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.19)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        // Категории продуктов
                        HStack(spacing: 12) {
                            CategoryButton(title: "Lebensmittel", isSelected: selectedCategory == "Lebensmittel") {
                                selectedCategory = "Lebensmittel"
                            }
                            
                            CategoryButton(title: "Getränke", isSelected: selectedCategory == "Getränke") {
                                selectedCategory = "Getränke"
                            }
                            
                            CategoryButton(title: "Salate", isSelected: selectedCategory == "Salate") {
                                selectedCategory = "Salate"
                            }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(recipes.filter { $0.category == "Beliebt" }, id: \ .self) { recipe in
                                    Button(action: {
                                        selectedRecipe = recipe
                                    }) {
                                        RecipeCard(recipe: recipe)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct CategoryButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Sen-Regular", size: 16))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(isSelected ? Color(red: 63/255, green: 193/255, blue: 46/255) : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(isSelected ? Color.clear : Color(red: 63/255, green: 193/255, blue: 46/255), lineWidth: 1.5)
                )
                .cornerRadius(32)
                .shadow(color: isSelected ? Color.gray.opacity(0.2) : .clear, radius: 5, x: 0, y: 2)
        }
    }
}

struct RecipeView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var selectedTab: Tab = .home
    @State private var selectedRecipe: Recipe?
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    
                    switch selectedTab {
                    case .home:
                        cartContent(size: geometry.size)
                    case .geo:
                        Karte()
                    case .profile:
                        ProfileView()
                    case .drops:
                        MainScreen()
                    case .kart:
                        CartView()
                    }
                    
                    Spacer()
                    
                    MainTabView(selectedTab: $selectedTab)
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color.white)
                        .ignoresSafeArea(edges: .bottom)
                }
                
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    
    func cartContent(size: CGSize) -> some View {
        ZStack {
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image("mainPicture")
                        .resizable()
                                              .scaledToFill()
                                              .frame(width: size.width, height: size.height * 0.35) // 35% высоты экрана
                                              .clipped()
                                              .padding(.bottom, size.height * 0.02)
                    
                    ZStack {
                        Image("squareWhite")
                            .resizable()
                            .frame(width: 390)
                            .frame(height: 190)
                        Text("Beliebt")
                            .font(.custom("Sen-Regular", size: 17))
                            .padding(.bottom,10)
                            //.padding(.trailing,255)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, size.height * 0.007)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(recipes/*.filter { $0.category == "Beliebt" }*/, id: \ .self) { recipe in
                                ZStack{
                                   
                                   // Button(action: {
                                      
                                   // }) {
                                        RecipeCard(recipe: recipe)
                                   // }
                                    Button(action: {
                                        selectedRecipe = recipe
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title)
                                            .foregroundColor(Color(red: 63/255, green: 193/255, blue: 46/255))
                                    }
                                    .padding(.bottom, 135)
                                    .padding(.leading, 100)
                                    .environmentObject(cartViewModel)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, -55)
                    
                    ZStack {
                        Image("squareWhite")
                            .resizable()
                            .frame(width: 390)
                            .frame(height: 190)
                        Text("Neuerungen")
                            .font(.custom("Sen-Regular", size: 17))
                            .padding(.bottom,10)
                            //.padding(.trailing,210)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, size.height * 0.013)
                    
                    VStack(spacing: 10) {
                        ForEach(recipes/*.filter { $0.category == "Neuerungen" }*/, id: \ .self) { recipe in
                            ZStack{
                               
                              //  Button(action: {
                                   
                               // }) {
                                    RecipeRow(recipe: recipe)
                                        .environmentObject(cartViewModel)
                               // }
                                Button(action: {
                                    selectedRecipe = recipe
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(Color(red: 63/255, green: 193/255, blue: 46/255))
                                }
                                .padding(.leading, UIScreen.main.bounds.width / 1.3)
                                .environmentObject(cartViewModel)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, -50)
                }
            }
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(recipe: recipe)
                    .environmentObject(cartViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: recipe.imageURL)) { image in
                image.resizable()
                    .frame(width: 90, height: 85)
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .cornerRadius(15)
            
            Text(recipe.name)
                .font(.footnote)
                .foregroundColor(.black)
                .bold()
                .lineLimit(1)
                .padding(.horizontal, 5)
            Text(recipe.ingredients)
                .foregroundColor(Color.gray)
                .font(.custom("Sen-Regular", size: 14))
                .multilineTextAlignment(.leading)

            HStack{
            Text(recipe.price)
                .font(.subheadline)
                .bold()
                .padding(.horizontal, 5)
                .foregroundColor(.black)
                Spacer()
                    .frame(width: 30)
                
                  
            }
        }
        .frame(width: 130, height: 170)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.imageURL)) { image in
                image.resizable()
                    .frame(width: 90, height: 85)
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .cornerRadius(15)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .bold()
                Text(recipe.ingredients)
                    //.font(.headline)
                    .foregroundColor(Color.gray)
                    .font(.custom("Sen-Regular", size: 14))
                    .multilineTextAlignment(.leading)
                    
                Text(recipe.weight)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(recipe.price)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
            }
            Spacer()
            
           
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
#Preview{
    RecipeView()
}

