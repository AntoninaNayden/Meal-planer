import SwiftUI


struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("isGuest") private var isGuest: Bool = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("emailAddress") private var emailAddress: String = ""
    @AppStorage("isRegistered") private var isRegistered: Bool = false
   // @AppStorage("password") private var password: String = ""
    @State private var navigateToSuccess = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    ZStack {
                        Image("Clovers")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
                            .clipped()
                            .colorMultiply(.green)
                        
                        Image("gnomLog")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 1.5)
                            .offset(x: UIScreen.main.bounds.width * 0.09, y: UIScreen.main.bounds.height * 0.09)
                    }
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
                    .ignoresSafeArea(edges: .top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack(spacing: 10) {
                    CustomTextField(title: "EMAIL", text: $email)
                    CustomTextField(title: "PASSWORD", text: $password, isSecure: true)
                    
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.custom("Sen-Regular", size: 16))
                    }
                    
                    Spacer().frame(height: 10)
                    
                    // 🔹 КНОПКА ВХОДА
                    Button(action: {
                        authorizeUser()
                    }, label: {
                        Image("login")
                            .resizable()
                            .frame(width: 335, height: 70)
                    })
                    
                    // 🔹 ПЕРЕХОД В `Success`
                    NavigationLink(destination: RecipeView(), isActive: $navigateToSuccess) {
                        EmptyView()
                    }
                    
                    // 🔹 КНОПКА ВХОДА КАК ГОСТЬ
                    Button(action: {
                        enterAsGuest()
                    }) {
                        Text("Weiter als Gast")
                            .font(.custom("Sen-Regular", size: 18))
                            .foregroundColor(.green)
                            .padding()
                            .frame(width: 335, height: 50)
                            .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                            .cornerRadius(16)
                    }
                    .padding(.top, 20)
                }
                .frame(width: UIScreen.main.bounds.width + 12, height: 520)
                .background(Color.white)
                .cornerRadius(20)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    private func authorizeUser() {
        guard !email.isEmpty, !password.isEmpty else {
            showError = true
            errorMessage = "Please fill all fields"
            return
        }

        let parameters: [String: Any] = [
            "login": email,
            "pass": password,
            "metod": "autorization"
        ]

        guard let url = URL(string: "http://ai429a.twcloack.online/api.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Network error"
                }
                return
            }

            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    DispatchQueue.main.async {
                        showError = true
                        errorMessage = "Invalid server response"
                    }
                    return
                }

                print("🔹 Parsed JSON: \(jsonResponse)")

                if let successMessage = jsonResponse["success"] as? String {
                    // ✅ Успешная авторизация
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        isGuest = false
                        emailAddress = email
                        
                        if let name = jsonResponse["name"] as? String {
                            userName = name
                        }

                        navigateToSuccess = true
                    }
                } else if let errorMessageFromServer = jsonResponse["error"] as? String {
                    if errorMessageFromServer == "User deleted" {
                        // ✅ Если аккаунт удалён — показываем сообщение и разрешаем регистрацию
                        DispatchQueue.main.async {
                            showError = true
                            errorMessage = "Account deleted. Please register again."
                            isRegistered = false
                        }
                    } else {
                        // ✅ Любая другая ошибка
                        DispatchQueue.main.async {
                            showError = true
                            errorMessage = errorMessageFromServer
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    showError = true
                    errorMessage = "Invalid JSON format"
                }
            }
        }.resume()
    }


    private func enterAsGuest() {
        isLoggedIn = true
        isGuest = true
        userName = "Gast"
        emailAddress = "Gast"
        navigateToSuccess = true
    }


}

#Preview {
    Login()
}

