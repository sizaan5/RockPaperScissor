//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Izaan Saleem on 29/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    let emojis = ["👊", "📄", "✂️"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    @State private var shouldWin = Bool.random()
    
    @State private var appMoveIndex = Int.random(in: 0..<3)
    @State private var playerScore = 0
    @State private var round = 1
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [.blue, .black], center: .top, startRadius: 200, endRadius: 600)
            VStack {
                Spacer()
                Text("Round \(round)/10")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .fontDesign(.monospaced)
                Spacer()
                VStack {
                    Text("Select a move to \(shouldWin ? "win" : "lose") against")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                        .fontDesign(.serif)
                    Text("\(emojis[appMoveIndex])")
                        .font(.largeTitle)
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                }
                .padding()
                HStack {
                    ForEach(0..<3) { index in
                        Button("\(emojis[index])") {
                            checkMove(move: index, shouldWin: shouldWin, appMove: emojis[appMoveIndex])
                        }
                        .padding()
                        .background(.white)
                        .clipShape(.buttonBorder)
                        .font(.largeTitle)
                    }
                }
                Spacer()
                Text("Score: \(playerScore)")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your score is \(playerScore)"),
                    primaryButton: .default(
                        Text("Play Again"),
                        action: {
                            self.resetGame()
                        }),
                    secondaryButton: .cancel()
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private func checkMove(move: Int, shouldWin: Bool, appMove: String) {
        if move == 0 {
            // tap on rock
            if shouldWin {
                if appMove == "📄" {
                    // true
                    playerScore -= 1
                } else if appMove == "✂️" {
                    playerScore += 1
                    // false
                } else {
                    // same
                    return
                }
            } else {
                if appMove == "📄" {
                    // false
                    playerScore += 1
                } else if appMove == "✂️" {
                    // true
                    playerScore -= 1
                } else {
                    // same
                    return
                }
            }
        } else if move == 1 {
            // tap on paper
            if shouldWin {
                if appMove == "👊" {
                    // false
                    playerScore += 1
                } else if appMove == "✂️" {
                    // true
                    playerScore -= 1
                } else {
                    // same
                    return
                }
            } else {
                if appMove == "👊" {
                    // true
                    playerScore -= 1
                } else if appMove == "✂️" {
                    // false
                    playerScore += 1
                } else {
                    // same
                    return
                }
            }
        } else if move == 2 {
            // tap in scissor
            if shouldWin {
                if appMove == "👊" {
                    // true
                    playerScore -= 1
                } else if appMove == "📄" {
                    // false
                    playerScore += 1
                } else {
                    // same
                    return
                }
            } else {
                if appMove == "👊" {
                    // false
                    playerScore += 1
                } else if appMove == "📄" {
                    // true
                    playerScore -= 1
                } else {
                    // same
                    return
                }
            }
        }
        round += 1
        appMoveIndex = Int.random(in: 0..<3)
        self.shouldWin = Bool.random()
        
        if round >= 10 {
            showAlert = true
        }
    }
    
    private func resetGame() {
        round = 1
        playerScore = 0
        moves.shuffle()
    }
}

#Preview {
    ContentView()
}
