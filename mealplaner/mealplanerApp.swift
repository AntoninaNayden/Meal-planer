//
//  mealplanerApp.swift
//  mealplaner
//
//  Created by Antonina on 17.02.25.
//

import SwiftUI

@main
struct mealplanerApp: App {
    @StateObject private var cartViewModel = CartViewModel()
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(CartViewModel())
        }
    }
}

