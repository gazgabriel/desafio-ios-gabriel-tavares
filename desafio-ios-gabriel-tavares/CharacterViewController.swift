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
        
        cell.textLabel?.text = character.name
        
        
        let url = URL(string: character.thumbnail.path+"."+character.thumbnail.extension)
        
        
        // https://stackoverflow.com/a/27712427
        getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            DispatchQueue.main.async() {
                 cell.imageView?.image = UIImage(data: data)
            }
        }

        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = self.listCharacters[indexPath.row]
        
        //self.performSegue(withIdentifier: "characterDetail", sender: character)
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
        
        /*
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let characterDetailViewController = segue.destination as? CharacterDetailViewController,
                let index = tableView.indexPathForSelectedRow?.row
                else {
                    return
            }
            characterDetailViewController.character = listCharacters[index]
        }*/
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}




