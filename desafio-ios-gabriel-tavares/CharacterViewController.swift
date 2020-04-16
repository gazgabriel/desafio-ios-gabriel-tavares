//
//  CharacterViewController.swift
//  desafio-ios-gabriel-tavares
//
//  Created by Gabriel Tavares on 15/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import UIKit

class CharacterViewController: UITableViewController {
    
    var listCharacters = [Character]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listCharacters.count) Characters found"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let characterRequest = CharacterRequest()
        characterRequest.getCharacters { [weak self] result in
            switch result {
            case .failure(let error):
                print (error)
            case .success(let characters):
                self?.listCharacters = characters
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characters", for: indexPath)
        
        let character = self.listCharacters[indexPath.row]
        
        cell.textLabel?.text = character.name
        
        
        return cell
    }


}

