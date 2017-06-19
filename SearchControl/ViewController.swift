//
//  ViewController.swift
//  SearchControl
//
//  Created by Zhanserik on 6/14/17.
//  Copyright © 2017 Kenes Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var list: [String] = [
        "Hello",
        "Bonjour",
        "Hi",
        "Privet",
        "Salam",
        "Merhaba"
    ]
    
    let searchControl = UISearchController(searchResultsController: nil)
    
    var filter = ""
    var filteredList: [String] {
        if filter.characters.count == 0 {
            return self.list
        }
        let filtered = self.list.filter {
            $0.lowercased().contains(self.filter.lowercased())
        }
        return filtered
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        self.tableView.dataSource = self
        
        searchControl.delegate = self
        searchControl.searchResultsUpdater = self
        searchControl.dimsBackgroundDuringPresentation = false
        searchControl.hidesNavigationBarDuringPresentation = false
        searchControl.searchBar.scopeButtonTitles = [
            "Turkish",
            "Kazakh",
            "Russian",
            "English"
        ]
        
        
       self.tableView.tableHeaderView = searchControl.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredList.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        cell?.textLabel?.text = self.filteredList[indexPath.row]
        return cell!
    }
}


extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        self.filter = searchController.searchBar.text!
        self.tableView.reloadData()
    }
}

