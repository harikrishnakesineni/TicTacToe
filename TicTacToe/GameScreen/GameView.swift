//
//  GameView.swift
//  TicTacToe
//
//  Created by Hari krishna on 24/06/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameService: GameService
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if [gameService.player1.isCurrent, gameService.player2.isCurrent].allSatisfy{ $0 == false } {
                Text("Select a player to start")
            }
            HStack {
                Button(gameService.player1.name) {
                    gameService.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: gameService.player1.isCurrent))
                
                Button(gameService.player2.name) {
                    gameService.player2.isCurrent = true
                    if gameService.gameType == .bot {
                        Task {
                            await gameService.deviceMove
                        }
                    }
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: gameService.player2.isCurrent))
            }
            .disabled(gameService.gameStarted)
            
            VStack {
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(3...5, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(6...8, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
            }
            .overlay {
                if gameService.isThinking {
                    VStack {
                        Text("Thinking...")
                            .foregroundColor(Color(.systemBackground))
                            .background(Rectangle().fill(Color.primary))
                        ProgressView()
                    }
                }
            }
            .disabled(gameService.boardDisabled)
            
            VStack {
                if gameService.gameOver {
                    Text("Game Over")
                    if gameService.possibleMoves.isEmpty {
                        Text("Nobody Wins")
                    } else {
                        Text("\(gameService.currentPlayer.name) wins!")
                    }
                    
                    Button("New Game") {
                        gameService.reset()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .font(.largeTitle)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Tic Tac Toe")
        .onAppear {
            gameService.reset()
        }
        .inNavigationStack()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10).fill(isCurrent ? Color.green : Color.gray))
            .foregroundColor(.white)
    }
}
