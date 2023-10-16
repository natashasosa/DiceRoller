//
//  ContentView.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var numberOfDice = 6
    @State private var numnberOfDiceRange = [1, 2, 3, 4, 5, 6]
    @State private var diceFaces: Int = 6
    @State private var diceFacesRange = [4, 6, 8, 10, 12, 20]
    @State private var diceValues: [Int] = []
    @State private var showingDiceView = false

    @StateObject private var savedDice = SavedDice()


    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                VStack {
                    Text("How many dice do you want to roll?")
                        .font(.title3.weight(.bold))
                    Picker("", selection: $numberOfDice) {
                        ForEach(numnberOfDiceRange, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack {
                    Text("How many faces will they have?")
                        .font(.title3.weight(.bold))
                    Picker("", selection: $diceFaces) {
                        ForEach(diceFacesRange, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                NavigationLink {
                    RolledDiceView(savedDice: savedDice)
                } label: {
                    Text("My saved dice")
                }
                .font(.title.weight(.medium))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 200)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Button {
                    diceValues = [Int](repeating: 1, count: diceFaces)
                    print(diceValues)
                    showingDiceView = true
                } label: {
                    Text("Start")
                }
                .font(.title.weight(.medium))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 200)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))




            }
            .navigationTitle("Select your dice")
            .padding()
            .sheet(isPresented: $showingDiceView) {
                DiceView(numberOfDice: $numberOfDice, diceFaces: $diceFaces, diceValues: $diceValues, savedDice: savedDice)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
