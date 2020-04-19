//
//  CharacterViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

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
    
    func thumbnail(imageView: UIImageView, index:Int)  -> UIImageView {
        if characters[index].thumbnail.path.hasSuffix("image_not_available") || characters[index].thumbnail.path.hasSuffix("4c002e0305708") {
            imageView.image = UIImage(named: "placeholder.png")
            return imageView
        }
        imageView.kf.setImage(with: URL(string: characters[index].thumbnail.path+"."+characters[index].thumbnail.extension))
        return imageView
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
