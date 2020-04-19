//
//  CharacterViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

struct CharacterViewModel {

    var characters:[Character]
    
    init (characters: [Character]) {
        self.characters = characters
    }
    
    var lines:Int {
        return characters.count
    }
    
    func name(index:Int) -> String {
        return characters[index].name.uppercased()
    }
    
    func thumbnail(index:Int) -> URL {
        return URL(string: characters[index].thumbnail.path+"."+characters[index].thumbnail.extension)!
        
    }
    
    func characterAt(index:Int) -> Character {
        return characters[index]
    }
    
    mutating func insertCharacteres(list: [Character]) {
        for character in list {
            characters.insert(character, at: (characters.endIndex))
        }
        
    }
    
    
    
    
}
