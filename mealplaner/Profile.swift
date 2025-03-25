import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("isRegistered") private var isRegistered: Bool = false
    @AppStorage("isGuest") private var isGuest: Bool = false
    @AppStorage("emailAddress") private var emailAddress: String = ""
    @State private var password = ""
   // @AppStorage("password") private var password: String = ""
    @AppStorage("userName") private var userName: String = "Gast"
    @AppStorage("navigateToRecipe") private var navigateToRecipe: Bool = false
    @State private var isPersonalInfoPresented = false
    @State private var profile = UserProfile.defaultProfile
    @State private var showLogoutMessage = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            ZStack {
//                NavigationView {
                    VStack {
                        Image("profil")
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.14)

                        HStack {
                            Image(uiImage: profile.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .clipShape(Circle())
                                .padding(.leading, geometry.size.width * 0.05)

                            Text(isGuest ? "Gast" : userName)
                                .font(.custom("Sen-Regular", size: geometry.size.width * 0.05))
                                .bold()
                                .padding(.leading, geometry.size.width * 0.025)

                            Text(isGuest ? "hello@gmail.com" : emailAddress)
                                .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
                                .foregroundColor(.gray)

                            Spacer()
                        }
                        .padding(.top, -geometry.size.height * 0.035)
                        .padding(.leading, geometry.size.width * 0.025)

                        VStack(spacing: geometry.size.height * 0.018) {
                            Button(action: { isPersonalInfoPresented = true }) {
                                HStack {
                                    Image("pr1")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                    Spacer()
                                        .frame(width: geometry.size.width * 0.05)
                                    Text("Persönliche Infos")
                                        .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(height: geometry.size.height * 0.07)
                                .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                                .cornerRadius(geometry.size.width * 0.04)
                            }

                            NavigationLink(destination: AddressView()) {
                                HStack {
                                    Image("pr2")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                    Spacer()
                                        .frame(width: geometry.size.width * 0.05)
                                    Text("Adressen")
                                        .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(height: geometry.size.height * 0.07)
                                .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                                .cornerRadius(geometry.size.width * 0.04)
                            }

                            NavigationLink(destination: OrderHistoryView()) {
                                HStack {
                                    Image("pr3")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                    Spacer()
                                        .frame(width: geometry.size.width * 0.05)
                                    Text("Bestellverlauf")
                                        .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .frame(height: geometry.size.height * 0.07)
                                .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                                .cornerRadius(geometry.size.width * 0.04)
                            }
                        }
                        .frame(width: geometry.size.width * 0.87, height: geometry.size.height * 0.29)
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(geometry.size.width * 0.04)
                        .padding()

                        Spacer()

                        Button(action: {
                            deleteAccount()
                        }) {
                            HStack {
                                Image("pr4")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                Text("Abmelden")
                                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                                    .foregroundColor(.red)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(height: geometry.size.height * 0.07)
                            .frame(width: geometry.size.width * 0.87)
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(geometry.size.width * 0.04)
                        }
                        .padding(.bottom, geometry.size.height * 0.14)
                        .padding(.horizontal, geometry.size.width * 0.065)

                        Button(action: {
                            if isGuest {
                                logOut()
                            } else {
                                Task {
                                    _ = await deleteProfile()
                                }
                                logOut()
                            }
                        }) {
                            HStack {
                                Image("pr5")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125)
                                Text("Account löschen")
                                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                                    .foregroundColor(.red)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(height: geometry.size.height * 0.07)
                            .frame(width: geometry.size.width * 0.87)
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(geometry.size.width * 0.04)
                        }
                        .padding(.bottom, geometry.size.height * 0.14)
                        .padding(.horizontal, geometry.size.width * 0.065)
                    }
                    .navigationBarBackButtonHidden(true)
                    .sheet(isPresented: $isPersonalInfoPresented) {
                        PersonalInfoView(profile: $profile)
                    }
                }

                if showLogoutMessage {
                    VStack {
                        Spacer()
                        Text("Sie haben sich erfolgreich abgemeldet")
                            .font(.custom("Sen-Regular", size: geometry.size.width * 0.045))
                            .foregroundColor(Color(red: 63/255, green: 193/255, blue: 46/255))
                            .padding(.top, geometry.size.height * 0.23)
                            .frame(height: geometry.size.height * 0.35)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.5), value: showLogoutMessage)
                    }
//                }
            }
        }
        .environmentObject(cartViewModel)
        .navigationBarBackButtonHidden(true)
        NavigationLink(destination: SignUp(), isActive: $showLogoutMessage) { EmptyView() }.hidden()
    }

    private func logOut() {
        withAnimation {
            showLogoutMessage = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            resetProfile()
            isLoggedIn = false
            isRegistered = false
            isGuest = false
            userName = "Gast"
            emailAddress = ""
            navigateToRecipe = false
        }
    }

    private func deleteProfile() async -> Bool {
        guard let url = URL(string: "http://ai429a.twcloack.online/api.php") else {
            print("❌ Ошибка: Некорректный URL")
            return false
        }
        
        let body: [String: Any] = [
            "login": "\(UserDefaults.standard.object(forKey: "email") ?? "")",
            "pass": "\(UserDefaults.standard.object(forKey: "password") ?? "")",
            "metod": "delete_profile"
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        if let successMessage = json["success"] as? String {
                            print("✅ \(successMessage)")
                            await MainActor.run {
                                withAnimation {
                                    isLoggedIn = false
                                    isRegistered = false
                                    isGuest = false
                                    userName = "Gast"
                                    emailAddress = ""
                                    password = ""
                                    
                                    UserDefaults.standard.removeObject(forKey: "isLoggedIn")
                                    UserDefaults.standard.removeObject(forKey: "isRegistered")
                                    UserDefaults.standard.removeObject(forKey: "isGuest")
                                    UserDefaults.standard.removeObject(forKey: "userName")
                                    UserDefaults.standard.removeObject(forKey: "emailAddress")
                                    UserDefaults.standard.removeObject(forKey: "password")
                                    UserDefaults.standard.removeObject(forKey: "email")
                                    
                                
                                }
                            }
                            
                            return true
                        } else if let errorMessage = json["error"] as? String {
                            print("❌ Ошибка: \(errorMessage)")
                            return false
                        }
                    }
                case 400...499:
                    print("❌ Клиентская ошибка: \(httpResponse.statusCode)")
                case 500...599:
                    print("❌ Серверная ошибка: \(httpResponse.statusCode)")
                default:
                    print("❌ Неизвестная ошибка: \(httpResponse.statusCode)")
                }
            }
        } catch {
            print("❌ Ошибка сети или обработки данных: \(error.localizedDescription)")
            return false
        }
        
        return false
    }

    private func deleteAccount() {
        withAnimation {
            showLogoutMessage = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            resetProfile()
            isLoggedIn = false
            isRegistered = false
            isGuest = false
            userName = "Gast"
            emailAddress = ""
            navigateToRecipe = false
            
            // Удаляем сохранённые данные
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "isRegistered")
            UserDefaults.standard.removeObject(forKey: "isGuest")
            UserDefaults.standard.removeObject(forKey: "userName")
            UserDefaults.standard.removeObject(forKey: "emailAddress")
            
            // Переход на экран логина
            presentationMode.wrappedValue.dismiss()
        }
    }


    private func resetProfile() {
        profile = UserProfile.defaultProfile
    }
}



struct PersonalInfoView: View {
    @AppStorage("emailAddress") private var emailAddress: String = ""
    @AppStorage("userName") private var userName: String = "Gast"
    @EnvironmentObject var cartViewModel: CartViewModel
    @Binding var profile: UserProfile
    @State private var isEditing = false

    var body: some View {
        GeometryReader { geometry in
        VStack {
            HStack {
                Text("Persönliche Infos")
                    .font(.title2)
                    .bold()
                Spacer()
                Button("EDIT") {
                    isEditing.toggle()
                }
                .foregroundColor(.green)
            }
            .padding()

            Image(uiImage: profile.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(.bottom, 10)

            VStack(alignment: .leading, spacing: 15) {
                ProfileRow(title: "VOLLSTÄNDIGER NAME", value: userName, image: "pr1")
                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
                ProfileRow(title: "EMAIL", value: emailAddress, image: "pri2")
                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
                ProfileRow(title: "RUFNUMMER", value: profile.phoneNumber, image: "pri3")
                    .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
            }
            .frame(width: geometry.size.width * 0.87, height: geometry.size.height * 0.59)
           // .padding()
            //.frame(width: 350)
           //.frame(height: 250)
            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
            .cornerRadius(12)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isEditing) {
            EditProfileView(profile: $profile)
        }
    }
}

    struct EditProfileView: View {
        @AppStorage("emailAddress") private var emailAddress: String = ""
        @AppStorage("userName") private var userName: String = "Gast"
        @Binding var profile: UserProfile
        @State private var newImage: UIImage?
        @EnvironmentObject var cartViewModel: CartViewModel
        @State private var showImagePicker = false
        
        var body: some View {
            VStack {
                Text("Profil Bearbeiten")
                    .font(.title2)
                    .bold()
                    .padding()
                
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Image(uiImage: newImage ?? profile.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Image("editicon")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.green)
                                .offset(x: 35, y: 35)
                        )
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $newImage)
                }
                .padding(.bottom, 10)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("VOLLSTÄNDIGER NAME")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    TextField("VOLLSTÄNDIGER NAME", text: $userName)
                        .padding()
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                    
                    Text("EMAIL")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    TextField("EMAIL", text: $emailAddress)
                        .padding()
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(10)
                        .disabled(true)
                        .foregroundColor(.gray)
                    
                    Text("RUFNUMMER")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    TextField("RUFNUMMER", text: $profile.phoneNumber)
                        .padding()
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Кнопка сохранения
                Button(action: {
                    if let newImage = newImage {
                        profile.image = newImage
                    }
                }) {
                    Image("speichern")
                        .resizable()
                        .frame(width: 360, height: 60)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfileRow: View {
    let title: String
    let value: String
    let image: String
    
    var body: some View {
        GeometryReader{ geometry in
            HStack(alignment: .top) {
                Image("\(image)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text(value)
                        .font(.custom("Sen-Regular", size: geometry.size.width * 0.035))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .frame(width: geometry.size.width * 0.87, height: geometry.size.height * 0.29)
            .navigationBarBackButtonHidden(true)
            .frame(height: 60)
            .padding(.horizontal)
        }
    }
}

struct UserProfile {
    var fullName: String
    var email: String
    var phoneNumber: String
    var image: UIImage

    static var defaultProfile = UserProfile(
        fullName: "Emmerich Richter",
        email: "hello@gmail.com",
        phoneNumber: "408-841-0926",
        image: UIImage(named: "emmerich")!
    )
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}
//adress

struct AddressRow: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @Binding var address: Address
    @State private var isEditing = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(address.type.uppercased())
                    .font(.headline)
                    .foregroundColor(.black)
                Text(address.addressLine1)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(address.addressLine2)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack(spacing: 10) {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image("edit")
                        .resizable()
                        .frame(width: 20, height: 20)
                }

                Button(action: {
                    // Удаление будет происходить на уровне AddressView
                }) {
                    Image("delete")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding()
        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
        .cornerRadius(12)
        .sheet(isPresented: $isEditing) {
            EditAddressView(address: $address)
        }
    }
}




struct AddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var addresses = [
        Address(type: "STARTSEITE", addressLine1: "86304 Friedberg,", addressLine2: "Albrechtstrasse, 6"),
        Address(type: "ARBEIT", addressLine1: "86304 Friedberg,", addressLine2: "Albrechtstrasse, 6")
    ]

    @State private var isAddingNewAddress = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color(red: 236/255, green: 240/255, blue: 244/255))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        )
                }
                Spacer()

                Text("Meine Adressen")
                    .font(.title2)
                    .bold()

                Spacer()
            }
            .padding()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach($addresses) { $address in
                        AddressRow(address: $address)
                    }
                }
                .padding(.horizontal)
            }

            // Кнопка для добавления нового адреса
            Button(action: {
            }) {
                Image("neue")
                    .resizable()
                    .frame(width: 360, height: 70)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}


struct EditAddressView: View {
    @Binding var address: Address
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var postalCode: String = ""
    @State private var street: String = ""
    @State private var apartment: String = ""
    @State private var title: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Meine Adressen")
                .font(.title2)
                .bold()
                .padding(.top)

            // Адрес
            VStack(alignment: .leading, spacing: 4) {
                Text("ADRESSE")
                    .font(.caption)
                    .foregroundColor(.gray)

                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.gray)

                    Text("\(address.addressLine1) \(address.addressLine2)")
                        .font(.subheadline)
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding()
                .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                .cornerRadius(12)
            }

            // Улица и индекс
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("STRAßE")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("Albrechtstrasse", text: $street)
                        .padding()
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("POSTLEITZAHL")
                        .font(.caption)
                        .foregroundColor(.gray)

                    TextField("86304", text: $postalCode)
                        .padding()
                        .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                        .cornerRadius(10)
                }
            }

            // Квартира
            VStack(alignment: .leading, spacing: 4) {
                Text("WOHNUNG")
                    .font(.caption)
                    .foregroundColor(.gray)

                TextField("6", text: $apartment)
                    .padding()
                    .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                    .cornerRadius(10)
            }

            // Заголовок
            VStack(alignment: .leading, spacing: 4) {
                Text("ÜBERSCHRIFT")
                    .font(.caption)
                    .foregroundColor(.gray)

                TextField("Startseite", text: $title)
                    .padding()
                    .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                    .cornerRadius(10)
            }

            Spacer()

            // Кнопка сохранения адреса
            Button(action: {
                address.addressLine1 = street
                address.addressLine2 = apartment
                // Здесь логика для сохранения данных
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("standort")
                    .resizable()
                    .frame(width: 360, height: 60)
                    .cornerRadius(10)
                   
            }
            .padding(.bottom)
        }
        .padding()
    }
}


struct Address: Identifiable {
    let id = UUID()
    var type: String
    var addressLine1: String
    var addressLine2: String
}
struct Order: Identifiable {
    let id = UUID()
    let category: String
    let title: String
    let price: Double
    let date: String
    let itemsCount: Int
    let orderNumber: String
    let status: OrderStatus
    let imageName: String
}

enum OrderStatus: String {
    case completed = "Completed"
    case canceled = "Canceled"
}
struct OrderRow: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(order.category)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Spacer()
                Text(order.status.rawValue)
                    .font(.subheadline)
                    .foregroundColor(order.status == .completed ? Color(red: 5/255, green: 156/255, blue: 106/255) : .red)

                    .bold()
            }
            Divider()
                .background(Color.gray)

            HStack {
                Image(order.imageName)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        Text(order.title)
                            .font(.headline)
                        Spacer()
                        Text("#\(order.orderNumber)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("€\(String(format: "%.2f", order.price)) ")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        Text("|   \(order.date)")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("· \(order.itemsCount) Items")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Spacer()

                      
                    }
                }
            }

            HStack {
                Button(action: {
                    // Логика для оценки заказа
                }) {
                    Image("Rate")
                        .resizable()
                        .frame(width: 120, height: 40)
                }

                Spacer()

                Button(action: {
                    // Логика для повторного заказа
                }) {
                    Image("Re-order")
                        .resizable()
                        .frame(width: 120, height: 40)
                }
            }
        }
        .padding()
        .cornerRadius(16)
    }
}
struct OrderHistoryView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var orders = [
        Order(category: "Lebensmittel", title: "Küche der Freude", price: 35.25, date: "29 JAN, 12:30", itemsCount: 3, orderNumber: "162432", status: .completed, imageName: "food1"),
        Order(category: "Getränke", title: "Geschmacksoase", price: 40.15, date: "30 JAN, 12:30", itemsCount: 2, orderNumber: "242432", status: .completed, imageName: "food2"),
        Order(category: "Getränke", title: "Bunte Teller", price: 10.20, date: "30 JAN, 12:30", itemsCount: 1, orderNumber: "240112", status: .canceled, imageName: "food3")
    ]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }

                Spacer()

                Text("Auftragshistorie")
                    .font(.title2)
                    .bold()

                Spacer()
            }
            .padding()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(orders) { order in
                        OrderRow(order: order)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}






#Preview {
    ProfileView()
}
