//
//  CharacterViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterViewController: UITableViewController {
    
    var listCharacters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Marvel Heroes List"
        let characterRequest = CharacterRequest()
        characterRequest.getCharactersByOffset(offset: 0) { [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let characters):
                self?.listCharacters = characters
            }
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characters", for: indexPath) as! CharacterTableViewCell
        
        let character = self.listCharacters[indexPath.row]
        
        cell.name?.text = character.name.uppercased()
        
        let url = URL(string: character.thumbnail.path+"."+character.thumbnail.extension)
        
        cell.thumbnail?.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.listCharacters.count - 1 {
                let characterRequest = CharacterRequest()
                characterRequest.getCharactersByOffset(offset:self.listCharacters.count+20) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print (error)
                    case .success(let characters):
                        
                        for character in characters {
                            self?.listCharacters.insert(character, at: (self?.listCharacters.endIndex)!)
                        }
                    }
                }
                self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "characterDetail") {
            let index = tableView.indexPathForSelectedRow?.row
            let viewController = segue.destination as? CharacterDetailViewController
            viewController!.character = listCharacters[(index)!]
        }
    }
}




