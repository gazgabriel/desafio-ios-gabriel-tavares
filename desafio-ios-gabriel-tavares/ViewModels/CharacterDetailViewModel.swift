//
//  CharacterDetailViewModel.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 18/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


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
    
    func thumbnail(imageView: UIImageView) -> UIImageView {
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = CGColor.init(genericGrayGamma2_2Gray: 10.0, alpha: 1.0)
        imageView.layer.cornerRadius = imageView.frame.size.width/2.0
        imageView.layer.masksToBounds = true
        if character.thumbnail.path.hasSuffix("image_not_available") || character.thumbnail.path.hasSuffix("4c002e0305708") {
            imageView.image = UIImage(named: "placeholder.png")
            return imageView
        }
        imageView.kf.setImage(with: URL(string: character.thumbnail.path+"."+character.thumbnail.extension))
        return imageView
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



