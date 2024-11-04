//
//  ContentView.swift
//  RPS_game
//
//  Created by Daniil Borisenko on 03.11.2024.
//

import SwiftUI

enum Items: String, CaseIterable{
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}


struct ContentView: View {
    //TODO: попробовать убоать везде словарь и испольщовать RawValue у enum
    var items = [Items.paper: "paper", Items.rock: "rock", Items.scissors: "scissors"]
    var winningPairs: [Items: Items] = [
        .rock: .scissors,
        .paper: .rock,
        .scissors: .paper
    ]
    
    @State private var counter = 0
    @State private var currerntScore = 0
    @State private var currentAppChoise = Items.random()
    @State private var isNeedWin = Bool.random()
    @State private var currentStatus = false
    @State private var showEndGameAlert = false
    
    
    func tapItem(_ item: Items) {
        if isNeedWin {
            currentStatus = winningPairs[item] == currentAppChoise
        }
        else {
            currentStatus = winningPairs[currentAppChoise] == item
        }
        
        currerntScore += !currentStatus && currerntScore != 0 ? -1 : 1
        counter += 1
        currentAppChoise = Items.random()
        isNeedWin = Bool.random()
        
        if counter == 3 { endGame() }
    }
    
    
    func endGame() {
        showEndGameAlert = true
    }
    
    
    func refresh() {
        counter = 0
        currerntScore = 0
        currentAppChoise = Items.random()
        isNeedWin = Bool.random()
    }
    
//---------------
    
    var body: some View {
        ZStack {
            VStack {
                Text("Score: \(currerntScore)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack{
                    Text("Oponent choose")
                        .font(.largeTitle)
                    Image(items[currentAppChoise, default: "scissors"])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .top)
                }
                
                VStack {
                    HStack{
                        Text("You have to")
                            .font(.largeTitle)
                        Text(isNeedWin ? "WIN" : "LOSE")
                            .font(.largeTitle)
                            .foregroundStyle(isNeedWin ? .green : .red)
                            .bold()
                    }
                }
                
                HStack {
                    ForEach(Array(items), id: \.key) { item in
                        Button(action: {
                            tapItem(item.key)
                        }, label: {
                            Image(item.value)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100, alignment: .top)
                        })
                    }
                }
            }
            .alert(isPresented: $showEndGameAlert) {
                Alert(title: Text("Game Ended!"),
                      message: Text("You have a \(currerntScore) scores!"),
                      primaryButton: Alert.Button.default(Text("Restart"), action: { refresh() }),
                      secondaryButton: Alert.Button.cancel(Text("Finish")))
            }
            
        }
    }
}


extension Items {
    /// Return a random item from this enum
    static func random() -> Self {
        return Self.allCases.randomElement() ?? .scissors
    }
}

#Preview {
    ContentView()
}
