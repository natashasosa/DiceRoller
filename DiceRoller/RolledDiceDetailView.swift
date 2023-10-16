//
//  RolledDiceDetail.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 16/10/23.
//

import SwiftUI

struct RolledDiceDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    let dice: Dice

    var body: some View {
        ScrollView {
            Image(String(dice.diceFaces))
                .resizable()
                .scaledToFill()

                Text("This round's result:")
                    .font(.title)
                    .padding(.bottom, 16)

                Text("Dice rolled: \(dice.numberOfDice).")
                    .padding(.bottom, 2)

                Text("Type of dice: \(dice.diceFaces)-sided dice.")
                    .padding(.bottom, 16)

                Text("What you got:")
                    .padding(.bottom, 2)
            VStack {

                GeometryReader { geo in
                    // Dice VStack
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(0..<dice.numberOfDice, id: \.self) { index in
                                VStack {
                                    ZStack {
                                        Rectangle()
                                            .overlay {
                                                switch colorScheme {
                                                case .light:
                                                    Color.white
                                                case.dark:
                                                    Color.red
                                                default:
                                                    Color.red
                                                }
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                            .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.33), radius: 5, y: 5)
                                            .frame(width: 50, height: 50)

                                        Text("\(dice.diceValues[index])")
                                            .font(.title)
                                            .monospacedDigit()
                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

//struct RolledDiceDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RolledDiceDetailView()
//    }
//}
