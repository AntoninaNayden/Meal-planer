import SwiftUI

struct Success: View {
    @State private var navigateToRecipe = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image("gnomsuccess")
                        .resizable()
                        .frame(width: 340, height: 450)
                        .padding(.leading, 80)
                    
                    Button(action: {
                        navigateToRecipe = true
                    }, label: {
                        Image("success")
                            .resizable()
                            .frame(width: 335, height: 110)
                    })
                    
                    NavigationLink(
                        destination: RecipeView(),
                        isActive: $navigateToRecipe
                    ) {
                        EmptyView()
                    }
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
    Success()
}

