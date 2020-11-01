//
//  ViewController.swift
//  MileStone2Project
//
//  Created by Alexander Ha on 9/21/20.
//  Copyright © 2020 Alexander Ha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    //initializes picture object that is an empty array of string
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Milestone 2 Project"
        navigationController?.navigationBar.isHidden = false
        //assigns the bundle path to a variable
        let path = Bundle.main.resourcePath!
        //assigns the filemanager to the variable fm
        let fm = FileManager.default
        //assigns constant to perform a shallow search of the specified directory and returns the paths of an array of type string
        let images = try! fm.contentsOfDirectory(atPath: path)
        
        for image in images {
            if image.hasPrefix("flag of"){
                pictures.append(image)
            }
            pictures = pictures.sorted()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let flags = UIImage(named: pictures[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = pictures[indexPath.row].uppercased()
        cell.imageView?.image = flags
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
                vc.selectedFlag = pictures[indexPath.row]
                vc.selectedImageNumber = indexPath.row + 1
                vc.totalImages = pictures.count
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    
    
}
