//
//  FileManager-DocumentsDirectory.swift
//  DiceRoller
//
//  Created by Natasha Rebelo on 16/10/23.
//

import UIKit

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
