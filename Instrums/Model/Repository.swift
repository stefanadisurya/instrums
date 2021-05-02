//
//  Repository.swift
//  Instrums
//
//  Created by Stefan Adisurya on 01/05/21.
//

import UIKit
import CoreData

class InstrumentRepository {
    var instrumentNames = [String]()
    var instrumentFacts = [String]()
    
    static func generateInstrumentNames() -> [String] {
        return ["Accordion", "Banjo", "Bass", "Bongo", "Cowbell", "Drum", "Fork", "Guitar", "Harp", "Horn", "Keyboard", "Panpipe", "Saxophone", "Trumpet", "Violin"]
    }
    
    static func generateInstrumentFacts() -> [String] {
        return [
            "In 🇩🇪, 'Akkord' means 'musical chord, concord of sounds'.",
            "Banjo was invented by West Africans 🧑🏿‍🦱",
            "Bass is the key to a solid 'music ground' 💪",
            "Bongo always come as a pair 👫",
            "Cowbell is mainly used in Latin music 💃🏽",
            "The oldest drum to be discovered is the Alligator Drum 🥁",
            "John Shore invented tuning fork in 1752 🍴",
            "The shortest guitar is just 10 microns 🎸",
            "Harp is believed to have existed since 15,000 BC 🦖",
            "It was used especially by postilions of the 18th and 19th centuries 👨🏻‍✈️",
            "Keyboard is capable on producing a vairty of sounds 🎹",
            "Panpipe is also called syrinx 😲",
            "The standard saxophone has 23 keys 🎶",
            "Trumpet are actually 3500 years old 👴🏻",
            "Playing the violin burns approximately 170 calories per hour 🏋🏻‍♂️"
        ]
    }
}

class StepRepository {
    var stepName = [String]()
    
    static func generateSteps() -> [String] {
        return [
            "Tap to hear the instrument sound",
            "Guess the instrument",
            "Score 10 to finish",
            "Play again!"
        ]
    }
}
