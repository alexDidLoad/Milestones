//
//  ViewController.swift
//  iOS Notes
//
//  Created by Alexander Ha on 10/28/20.
//

import UIKit

class TableViewController: UITableViewController {
    
    var notes = [Note]()
    
    override func loadView() {
        super.loadView()
        title = "iOS Notes"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNotes()
        
        let write = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(compose))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarText = UIBarButtonItem(title: "Notes", style: .plain, target: nil, action: nil)
        toolbarText.isEnabled = false
        navigationController?.setToolbarHidden(false, animated: false)
        
        toolbarItems = [spacer, toolbarText, spacer, write]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = notes[indexPath.row]
        
        let dateString: String
        let date = DateFormatter()
        let time = DateFormatter()
        date.dateFormat = "MM/dd/yy"
        time.dateFormat = "h:mm a"
        
        if date.string(from: note.creation) == date.string(from: Date()) {
            dateString = time.string(from: note.creation)
        } else {
            dateString = date.string(from: note.creation)
        }
        
        if let lineBreakIndex = note.body.firstIndex(of: "\n") {
            let noteBodyString = String(note.body.prefix(upTo: lineBreakIndex))
            cell.textLabel?.text = noteBodyString
            cell.detailTextLabel?.text = "\(dateString)" + noteBodyString.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            cell.textLabel?.text = note.body
            cell.detailTextLabel?.text = "\(dateString) No additional text"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.notes = notes
            vc.selectedNote = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
    @objc func compose() {
        //clicking compose will bring user to DetailViewController
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            //creates new note with empty string
            let newNote = Note(body: "")
            //places newNote at position 0 in array of notes
            notes.insert(newNote, at: 0)
            vc.notes = notes
            vc.selectedNote = 0
            
            navigationController?.pushViewController(vc, animated: true)
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
    
    
    
}

