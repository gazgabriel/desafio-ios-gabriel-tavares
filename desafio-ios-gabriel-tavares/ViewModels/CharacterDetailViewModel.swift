//
//  CharacterDetailViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 18/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import UIKit

struct CharacterDetailViewModel {
    
    let character:Character

    init (character: Character) {
        self.character = character
    }
    
    var name: String{
        return character.name
    }
    
    var description: String?{
        if character.description!.count > 0 {
                return character.description
        }
        return "Description not found."
    }
    
    
    var thumbnail: URL? {
        return URL(string: character.thumbnail.path+"."+character.thumbnail.extension)
    }
    
    func comicButton(button: UIButton) -> UIButton {
        if character.comics.available == 0 {
            button.isHidden = true
            button.isEnabled = false
        }
        else{
            button.isHidden = false
            button.isEnabled = true
        }
        return button
    }
}



