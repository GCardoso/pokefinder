//
//  PokemonListVC.swift
//  PokeFinder
//
//  Created by Guilherme Gomes Cardoso on 5/15/17.
//  Copyright © 2017 Guilherme Cardoso. All rights reserved.
//

import UIKit

class PokemonListVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var callback: ((Pokemon) -> Void)?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    var pokemon = [Pokemon]()
    var filteredpokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        // Do any additional setup after loading the view.
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredpokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredpokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke: poke)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
            }
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        poke = inSearchMode ? filteredpokemon[indexPath.row] : pokemon[indexPath.row]
        //performSegue(withIdentifier: "PokemonMapVC", sender: poke)
        self.callback!(poke)
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredpokemon.count : pokemon.count
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
