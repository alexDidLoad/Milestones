//
//  ViewController.swift
//  Shopping List Challenge
//
//  Created by Alexander Ha on 9/26/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    var item: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        tableView.backgroundColor = UIColor.gray
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CLEAR", style: .done, target: self, action: #selector(deleteItemAlert))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [addButton, shareButton]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        cell.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        cell.textLabel?.textColor = UIColor.black

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ac = UIAlertController(title: "Delete Item?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Yes", style: .destructive) {
            [weak self] action in
            self?.deleteOne(indexPath)
        })
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        
        present(ac, animated: true)
    }
    //MARK: - Add Item Methods
    
    @objc func add() {
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addTextField()
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func submit(_ item: String?) {
        if let unwrappedItem = item {
            shoppingList.append(unwrappedItem)
            tableView.reloadData()
        }
    }
    
    //MARK: - Delete Method
    
    @objc func deleteItemAlert() {
        let ac = UIAlertController(title: "Delete List", message: "Are you sure you want to delete everything?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            [weak self] action in
            self?.deleteItems()
            
        }
        ac.addAction(UIAlertAction(title: "Keep", style: .cancel))
        ac.addAction(deleteAction)
        present(ac, animated: true)
        
    }
    
    func deleteItems() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    func deleteOne(_ path: IndexPath) {
        shoppingList.remove(at: path.row)
        tableView.reloadData()
    }
    
    //MARK: - Share Method
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let avc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[0]
        present(avc, animated: true)
    }
    
}






