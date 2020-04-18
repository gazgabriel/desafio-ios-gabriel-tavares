//
//  CharacterDetailViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 16/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    
    @IBOutlet weak var thumbnail: UIImageView?
    
    @IBOutlet weak var name: UILabel?
    
    
    @IBOutlet weak var descripion: UILabel?
    
    @IBOutlet weak var btnHQDetail: UIButton?
    
    var character:Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name?.text = character?.name
        descripion?.text = character?.description
        
        let url = URL(string: (character?.thumbnail.path)!+"."+(character?.thumbnail.extension)!)
        
        getData(from: url!) { data, response, error in
                   guard let data = data, error == nil else { return }
                   print(response?.suggestedFilename ?? url!.lastPathComponent)
                   DispatchQueue.main.async() {
                    self.thumbnail?.image = UIImage(data: data)
                   }
               }
    
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
