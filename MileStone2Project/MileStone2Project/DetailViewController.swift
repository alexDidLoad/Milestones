//
//  DetailViewController.swift
//  MileStone2Project
//
//  Created by Alexander Ha on 9/21/20.
//  Copyright © 2020 Alexander Ha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedImageNumber = 0
    var totalImages = 0
    var selectedFlag: String?
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 1.0) else {
            print("no image")
            return
        }
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}
