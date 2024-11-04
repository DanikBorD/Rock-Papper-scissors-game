//
//  ContentView.swift
//  RPS_game
//
//  Created by Daniil Borisenko on 03.11.2024.
//

import SwiftUI

enum Items: CaseIterable{
    case rock, papper, scissors
}


struct ContentView: View {
    let items = [Items.rock: "rock", Items.papper: "papper", Items.scissors: "scissors"]
    
    @State private var curerntScore = 0
    @State private var currentAppChoise = Items.random()
    @State private var isNeedWin = Bool.random()
    
    
    var body: some View {
        VStack {
            Text("Score: \(curerntScore)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            VStack{
                Text("Oponent choise")
                    .font(.largeTitle)
        
                Image(items[currentAppChoise, default: "scissors"])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .top)
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
