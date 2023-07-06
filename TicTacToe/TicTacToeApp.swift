//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Hari krishna on 23/06/23.
//

import SwiftUI

@main
struct TicTacToeApp: App {
    @StateObject var gameService = GameService()
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(gameService)
        }
    }
}
