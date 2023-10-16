//
//  DiceView.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 16/10/23.
//

import SwiftUI

struct DiceView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @Binding var numberOfDice: Int
    @Binding var diceFaces: Int
    @Binding var diceValues: [Int]

    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0

    @State private var angleValue: Angle = Angle(degrees: 0)

    @ObservedObject var savedDice: SavedDice

    var body: some View {
        VStack {
            GeometryReader { geo in
                // Dice VStack
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<numberOfDice, id: \.self) { index in
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
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.33), radius: 10, y: 10)
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)

                                    Text("\(diceValues[index])")
                                        .font(.largeTitle)
                                        .monospacedDigit()
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                        .scaleEffect(2.5)
                                }
                            }
                            .rotation3DEffect(angleValue, axis: (x: 0, y: 0, z: 1))
                            .offset(x: offsetX, y: offsetY)
                        }
                    }
                }
                .frame(maxHeight: geo.size.height * 0.8)
                .padding()

                // Buttons VStack
                VStack {
                    Spacer()

                    HStack {
                        // Histroy Button
                        Button {
                            saveRolledDice()
                        } label: {
                            Image(systemName: "square.and.arrow.down.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }

                        Spacer()

                        // Roll Dice Button
                        Button {
                            rollDice()
                        } label: {
                            Text("Roll Dice")
                                .font(.title.weight(.medium))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 200)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }

                        Spacer()

                        // Settings Button
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "gear")
                                .font(.title.weight(.bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(colorScheme == .dark ? Color.gray.opacity(0.5) : Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                    }
                    .padding(20)
                    .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.33), radius: 10, y: 10)
                }
            }
        }
    }

    // Method to Roll Dice & update Animation values
    func rollDice() {
        var newDiceValues = [Int]()

        while newDiceValues == diceValues || newDiceValues == [] {
            newDiceValues = []

            for _ in 0..<numberOfDice {
                newDiceValues.append(Int.random(in: 0...diceFaces))
            }
        }

        diceValues = []
        diceValues.append(contentsOf: newDiceValues)
        print(diceValues)


        /// Animation Property value changes
        withAnimation(.interpolatingSpring(stiffness: 300, damping: 2)) {
            offsetX = CGFloat.random(in: -30...30)
            offsetY = CGFloat.random(in: -100...100)

            angleValue = Angle(degrees: Double.random(in: -1800.00...1800.00) * Double.random(in: -1800.00...1800.00))


            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.interpolatingSpring(stiffness: 40, damping: 5)) {
                    offsetX = CGFloat.random(in: -10...10)
                    offsetY = CGFloat.random(in: -10...10)
                    angleValue = Angle(degrees: Double.random(in: -30.00...30.00))
                }
            }
        }
    }

    func saveRolledDice() {
        let newDice = Dice(numberOfDice: numberOfDice, diceFaces: diceFaces, diceValues: diceValues)

        savedDice.rolledDice.append(newDice)
        savedDice.saveDice()

        print(savedDice.rolledDice.count)
    }
}

//struct DiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiceView()
//    }
//}
