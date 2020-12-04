//
//  HBDrinkListTableViewController.swift
//  Drink-ObjC
//
//  Created by Heli Bavishi on 12/3/20.
//

import UIKit

class HBDrinkListTableViewController: UITableViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var drink: HBDrink?
//    var drink: [String] = []
    var drinkImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HBDrinkController.sharedInstance().drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        let drink = HBDrinkController.sharedInstance().drinks[indexPath.row]
        cell.textLabel?.text = drink.drinkName
        cell.detailTextLabel?.text = drink.drinkCategory
        
        HBDrinkController.sharedInstance().fetchImage(for: drink) { (image) in
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
       return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
    
    func fetchDrink(searchTerm: String) {
        HBDrinkController.sharedInstance().fetchDrink(forSearchTerm: searchTerm) { (drink) in
            HBDrinkController.sharedInstance().fetchImage(for: drink) { (image) in
                DispatchQueue.main.async {
                    self.drink = drink
                    self.drinkImage = image
                    self.tableView.reloadData()
                }
            }
        }
    }
}//End of class

extension HBDrinkListTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.fetchDrink(searchTerm: searchText)
    }
}
