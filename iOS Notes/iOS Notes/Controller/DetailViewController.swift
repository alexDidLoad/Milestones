//
//  DetailViewController.swift
//  iOS Notes
//
//  Created by Alexander Ha on 10/28/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    var notes: [Note]!
    var selectedNote: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        textView.text = notes[selectedNote].body
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveNote()
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let vc = viewController as? TableViewController {
            vc.notes = notes
            vc.tableView.reloadData()
        }
    }
    
    func saveNote() {
        if selectedNote >= 0 {
            if textView.text == "" {
                notes.remove(at: selectedNote)
            } else {
                notes[selectedNote].body = textView.text
            }
        }
        
        let jsonEncoder = JSONEncoder()
        
        if let savedNote = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedNote, forKey: UserKeys.savedNotes)
        } else {
            print("Failed to save note")
        }
    }
    
    func loadNotes() {
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: UserKeys.savedNotes) as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("failed to load notes")
            }
        }
    }
    
    
    @objc func shareTapped() {
        let sharingNote = textView.text!
        let avc = UIActivityViewController(activityItems: [sharingNote], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
}
