//
//  CharacterDetailViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var descripion: UILabel?
    @IBOutlet weak var btnHQDetail: UIButton?
    
    
    var characterDetailViewModel: CharacterDetailViewModel?
    var character:Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterDetailViewModel = CharacterDetailViewModel(character: self.character!)
        
        self.navigationItem.title = self.characterDetailViewModel?.name
        self.name?.text = self.characterDetailViewModel?.name
        self.descripion?.text = self.characterDetailViewModel?.description
        self.btnHQDetail = self.characterDetailViewModel?.comicButton(button: self.btnHQDetail!)
        self.thumbnail = self.characterDetailViewModel?.thumbnail(imageView: self.thumbnail!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "comicDetail") {
            let viewController = segue.destination as? ComicViewController
            viewController!.characterID = character?.id
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
