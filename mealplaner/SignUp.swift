import SwiftUI

struct ContentView: View {
    @AppStorage("isRegistered") private var isRegistered: Bool = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("isGuest") private var isGuest: Bool = false
    @AppStorage("navigateToRecipe") private var navigateToRecipe: Bool = false
    @StateObject private var cartViewModel = CartViewModel()

    var body: some View {
        if isLoggedIn || navigateToRecipe || isGuest {
            RecipeView()
                .environmentObject(cartViewModel)
        } else if isRegistered {
            Login()
        } else {
            SignUp()
        }
    }
}



import SwiftUI

struct SignUp: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @AppStorage("isRegistered") private var isRegistered: Bool = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("emailAddress") private var emailAddress: String = ""
   // @AppStorage("password") private var password: String = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("isGuest") private var isGuest: Bool = false
    @State private var navigateToSuccess = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack {
                        Image("Clovers")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
                            .clipped()
                            .colorMultiply(.green)

                        Image("gnomSign")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 1.5)
                            .offset(x: UIScreen.main.bounds.width * 0.09, y: UIScreen.main.bounds.height * 0.09)
                    }
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
                    .ignoresSafeArea(edges: .top)

                    VStack(spacing: 10) {
                        CustomTextField(title: "NAME", text: $name)
                        CustomTextField(title: "EMAIL", text: $email)
                        CustomTextField(title: "PASSWORD", text: $password, isSecure: true)
                        CustomTextField(title: "RE-TYPE PASSWORD", text: $confirmPassword, isSecure: true)

                        if showError {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.custom("Sen-Regular", size: 16))
                        }

                        Spacer().frame(height: 10)

                        // 🔹 Кнопка регистрации
                        Button(action: {
                            registerUser()
                        }) {
                            Image("signup")
                                .resizable()
                                .frame(width: 335, height: 70)
                        }

                        // 🔹 Кнопка "Зайти как гость"
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

                        // 🔹 Переход в `Success`
                        NavigationLink(destination: RecipeView(), isActive: $navigateToSuccess) {
                            EmptyView()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width + 12, height: 620)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // ✅ Логика входа как гость
    private func enterAsGuest() {
        isLoggedIn = true
        isGuest = true
        userName = "Gast"
        emailAddress = "Gast"
        navigateToSuccess = true
    }

    // ✅ Логика регистрации пользователя
    private func registerUser() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, password == confirmPassword else {
            showError = true
            errorMessage = "Fields are empty or passwords don't match"
            return
        }

        let parameters: [String: Any] = [
            "name": name,
            "login": email,
            "pass": password,
            "metod": "registration"
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
                    // ✅ Успешная регистрация
                    DispatchQueue.main.async {
                        isRegistered = true
                        isLoggedIn = true
                        isGuest = false
                        userName = name
                        emailAddress = email
                        navigateToSuccess = true
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(password, forKey: "password")
                    }
                } else if let serverError = jsonResponse["error"] as? String {
                    if serverError == "User already exists" {
                        // ✅ Проверяем, помечен ли аккаунт как удалённый
                        DispatchQueue.main.async {
                            showError = true
                            errorMessage = "User already exists"
                        }
                    } else {
                        DispatchQueue.main.async {
                            showError = true
                            errorMessage = serverError
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

}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.custom("Sen-Regular", size: 14))
                .foregroundColor(Color(red: 50/255, green: 52/255, blue: 62/255))

            if isSecure {
                SecureField("", text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: 300, height: 40)
                    .padding()
                    .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                    .cornerRadius(10)
            } else {
                TextField("", text: $text)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .frame(width: 300, height: 40)
                    .padding()
                    .background(Color(red: 243/255, green: 250/255, blue: 240/255))
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    SignUp()
}

