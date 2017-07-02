//
//  CategoriesViewController.swift
//  QIAssignment
//
//  Created by Bilal Bhutta on 1/7/17.
//  Copyright © 2017 Bilal Bhutta. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {

    var list : [QCategory] = [QCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Categories"
        list = NearbyPlacesController.getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sort categories list by views
        list.sort() { $0.views > $1.views}
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CATEGORY_CELL"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = list[indexPath.row].name
        return cell
    }
    
    let nearbySearchSegueIdentifier = "nearby-search-by-category"
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: nearbySearchSegueIdentifier, sender: list[indexPath.row])
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == nearbySearchSegueIdentifier {
            guard let category = sender as? QCategory else {
                return
            }            
            if let vc = segue.destination as? NearbyPlacesViewController {
                vc.category = category
            }
        }
    }
}

// MARK: - Category Extension to get / set views

extension QCategory {
    private static let ketPrefix = "category-"
    
    var views:Int {
        get {
            return UserDefaults.standard.integer(forKey: QCategory.ketPrefix + name)
        }
    }
    
    func markView() {
        UserDefaults.standard.set(views + 1, forKey: QCategory.ketPrefix + name)
    }
}
