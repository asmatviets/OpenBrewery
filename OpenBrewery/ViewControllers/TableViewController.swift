//
//  TableViewController.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 07.05.2023.
//

import UIKit


final class TableViewController: UITableViewController {
    
    private var breweries: [Brewery] = []
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        fetchBreweries()
        title = "Choose you brewery"
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.brewery = breweries[indexPath.row]
        }
        
        if (segue.identifier == "mapViewSegue") {
            guard let mapVC = segue.destination as? MapViewController else { return }
            mapVC.breweries = breweries
        }

    }


    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breweries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let brewery = breweries[indexPath.row]
        
        content.image = UIImage(named: brewery.stateProvince)
        content.imageProperties.maximumSize.height = 30
        content.imageProperties.maximumSize.width = 40
        content.imageProperties.cornerRadius = 10
        content.text = brewery.name
        content.textProperties.color = .black
        content.textProperties.font = .boldSystemFont(ofSize: 12)
        
        content.secondaryText = brewery.city + ", " + brewery.stateProvince
        content.textToSecondaryTextVerticalPadding = 5
        cell.contentConfiguration = content
        cell.backgroundConfiguration = .clear()
        return cell
    }
}
    // MARK: - Networking
    extension TableViewController {

        private func fetchBreweries() {
            networkManager.fetch([Brewery].self, from: Link.brewery.url) { [weak self] result in
                switch result {
                case .success(let breweries):
                    self?.breweries = breweries
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

