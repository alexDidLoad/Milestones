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
        
        //adjusting keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        //setting the barbuttonItems
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        //setting the textViews.text property
        textView.text = notes[selectedNote].body
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveNote()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //sets the detailViewControllers notes property to be the tableViewController's notes property then reloads the tableview.
        if let vc = viewController as? TableViewController {
            vc.notes = notes
            vc.tableView.reloadData()
        }
    }
    
    //MARK: - Save and Loading methods
    
    func saveNote() {
        if selectedNote >= 0 {
            if textView.text == "" {
                notes.remove(at: selectedNote)
            } else {
                notes[selectedNote].body = textView.text
            }
        }
        encoder()
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
   
    func encoder() {
        let jsonEncoder = JSONEncoder()
        
        if let savedNote = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedNote, forKey: UserKeys.savedNotes)
        } else {
            print("Failed to save note")
        }
    }
    
    //MARK: - Sharing method
    
    @objc func shareTapped() {
        let sharingNote = textView.text!
        let avc = UIActivityViewController(activityItems: [sharingNote], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
    //MARK: - Keyboard adjustments
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
        
    }
    
}
