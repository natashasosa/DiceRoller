//
//  SavedDices.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 16/10/23.
//

import Foundation

class SavedDice: ObservableObject {
    @Published var rolledDice: [Dice]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDice")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            rolledDice = try JSONDecoder().decode([Dice].self, from: data)
        } catch {
            rolledDice = []
        }
    }

    func saveDice() {
        do {
            let data = try JSONEncoder().encode(rolledDice)
            try data.write(to: savePath)
        } catch {
            print("Error saving people: \(error)")
        }
    }

    func deleteDice(withID id: UUID) {
        if let index = rolledDice.firstIndex(where: { $0.id == id }) {
            rolledDice.remove(at: index)
            saveDice() // Save the updated data after deletion
        }
    }
}
