import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []

    func addToCart(recipe: Recipe, quantity: Int, weight: Int) {
        if let index = cartItems.firstIndex(where: { $0.recipe.id == recipe.id && $0.weight == weight }) {
            cartItems[index].quantity += quantity
        } else {
            let newItem = CartItem(recipe: recipe, quantity: quantity, weight: weight)
            cartItems.append(newItem)
        }
    }

    func removeFromCart(item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }
}
