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
    @State private var diceFacesRange = [4, 6, 8, 12, 20]


    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("How many dice do you want to roll?")
                            .font(.title3.weight(.bold))
                        Picker("", selection: $numberOfDice) {
                            ForEach(numnberOfDiceRange, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section {
                        Text("How many faces will they have?")
                            .font(.title3.weight(.bold))
                        Picker("", selection: $diceFaces) {
                            ForEach(diceFacesRange, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Spacer()

                NavigationLink("Start", destination: DiceView(numberOfDice: $numberOfDice, diceFaces: $diceFaces))
            }
            .navigationTitle("Select your dice")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
