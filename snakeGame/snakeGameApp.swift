//
//  snakeGameApp.swift
//  snakeGame
//
//  Created by Xavier Pedrals Camprubí on 5/12/25.
//

import SwiftUI

@main
struct snakeGameApp: App {
    
    @StateObject private var game = snakeGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                        HomeTab()
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }

                snakeGameView(viewModel: game)
                            .tabItem {
                                Label("Search", systemImage: "magnifyingglass")
                            }

//                        SettingsTab()
//                            .tabItem {
//                                Label("Settings", systemImage: "gearshape")
//                            }
                    }
            
            
//            snakeGameView(viewModel: game)
        }
    }
}

struct HomeTab: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "house.fill")
                    .font(.system(size: 48))
                Text("Home Tab")
                    .font(.title2)
                Text("Welcome to your 3-tab app.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
