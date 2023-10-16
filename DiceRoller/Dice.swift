//
//  SavedDice.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 16/10/23.
//

import Foundation

struct Dice: Identifiable, Codable {
    var id = UUID()
    let numberOfDice: Int
    let diceFaces: Int
    let diceValues: [Int]
}
