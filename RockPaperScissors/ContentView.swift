//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by EDSON FELIPE VASCONCELOS on 14/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var rpsArray = ["✊", "✋", "✌️"]
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var selectedItem = ""
    @State private var computerChoice = ""
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var moveAmount = 0
    
    @State private var showingResult = false
    
    func itemTapped(_ number: String) {
        correctAnswer = Int.random(in: 0..<3)
        selectedItem = number
        
        if selectedItem == rpsArray[correctAnswer] {
            scoreTitle = "A tie!"
        } else if selectedItem == "✊" && rpsArray[correctAnswer] == "✋" || selectedItem == "✋" && rpsArray[correctAnswer] == "✌️" || selectedItem == "✌️" && rpsArray[correctAnswer] == "✊" {
            userScore -= 1
            scoreTitle = "You lose!"
        } else {
            userScore += 1
            scoreTitle = "You win!"
        }
        
        showingResult.toggle()
        computerChoice = rpsArray[correctAnswer]
    }
    
    func newTurn() {
        moveAmount += 1
        correctAnswer = Int.random(in: 0..<3)
        computerChoice = ""
    }
    
    func reset() {
        moveAmount = 0
        userScore = 0
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .black]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock, Paper and Scissors")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Choose your move")
                    .font(.title2)
                
                HStack(spacing: 40) {
                    ForEach(rpsArray, id: \.self) { rps in
                        Button {
                            self.itemTapped(rps)
                        } label: {
                            Text("\(rps)")
                                .padding()
                                .font(.largeTitle)
                                .background(.black)
                                .cornerRadius(15)
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Computer Choice")
                    .font(.title2)
                
                Text("\(computerChoice == "" ? "???" : computerChoice)")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 100)
                    .background(.black)
                    .cornerRadius(15)
                    .padding()
                
                Text("Your score: \(userScore)")
                    .padding()
                    .font(.title2.bold())
                    .background(userScore > 0 ? .green : .red)
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .padding()
            }
            .padding()
        }
        .alert("Result", isPresented: $showingResult) {
            if moveAmount < 10 {
                Button("Continue", action: newTurn)
            } else {
                if userScore < 5 {
                    Button("Try again", action: reset)
                        .buttonStyle(.bordered)
                } else {
                    Button("New game", action: reset)
                }
            }
        } message: {
            if moveAmount < 10 {
                if selectedItem == rpsArray[correctAnswer] {
                    Text("A tie!")
                } else if selectedItem == "✊" && rpsArray[correctAnswer] == "✋" || selectedItem == "✋" && rpsArray[correctAnswer] == "✌️" || selectedItem == "✌️" && rpsArray[correctAnswer] == "✊" {
                    Text(scoreTitle)
                } else {
                    Text(scoreTitle)
                }
            } else {
                if userScore < 5 {
                    Text("Game over\n you lose!")
                } else {
                    Text("You won! Your score is: \(userScore)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
