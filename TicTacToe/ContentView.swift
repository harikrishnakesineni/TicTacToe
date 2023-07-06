//
//  ContentView.swift
//  TicTacToe
//
//  Created by Hari krishna on 23/06/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameService: GameService
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    private var startGameButtonisDisabled: Bool {
        gameType == .undetermined ||
        (gameType == .bot && yourName.isEmpty) ||
        gameType == .single && opponentName.isEmpty
    }

    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Select Game Type")
                    .tag(GameType.undetermined)
                Text("Two Sharing device")
                    .tag(GameType.single)
                Text("Challenge your device")
                    .tag(GameType.bot)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
            Text(gameType.description)
                .padding()
            
            VStack {
                switch gameType {
                case .single:
                    VStack {
                        TextField("Your Name", text: $yourName)
                        TextField("Opponent Name", text: $opponentName)
                    }
                case .bot:
                    TextField("Your Name", text: $yourName)
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            
            if gameType != .peer {
                Button("Start Game") {
                    gameService.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(startGameButtonisDisabled)
                
                Image("LaunchScreen")
            }
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $startGame) {
            GameView()
        }
        .navigationTitle("Tic Tac Toe")
        .inNavigationStack()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameService())
    }
}
