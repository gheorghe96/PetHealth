//
//  String.swift
//  pethealth
//
//  Created by Gheorghe Curca on 30.08.2023.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
