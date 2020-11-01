//
//  ViewController.swift
//  Milestone 4
//
//  Created by Alexander Ha on 10/6/20.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - UI Elements
    var titleLabel: UILabel!
    var underscoreLabel: UILabel!
    var guessText: UITextField!
    var usedLettersLabel: UILabel!
    var scoreLabel: UILabel!
    
    //MARK: - Properties
    var score: Int!
    var badChars = [Character]()
    var goodChars = [Character]()
    var allWords = [String]()
    var selectedWordIndex = 0
    var selectedWord = ""
    
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        titleLabel.text = "Hangman"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        underscoreLabel = UILabel()
        underscoreLabel.font = UIFont.systemFont(ofSize: 30)
        underscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(underscoreLabel)
        
        guessText = UITextField()
        guessText.placeholder = "Enter Guess Here"
        guessText.textAlignment = .center
        guessText.borderStyle = .roundedRect
        guessText.layer.cornerRadius = 20
        guessText.layer.masksToBounds = true
        guessText.layer.borderWidth = 2
        guessText.layer.borderColor = UIColor.lightGray.cgColor
        guessText.adjustsFontForContentSizeCategory = false
        guessText.font = UIFont.systemFont(ofSize: 30)
        guessText.allowsEditingTextAttributes = true
        guessText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(guessText)
        
        usedLettersLabel = UILabel()
        usedLettersLabel.text = ""
        usedLettersLabel.font = UIFont.systemFont(ofSize: 25)
        usedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usedLettersLabel)
        
        scoreLabel = UILabel()
        scoreLabel.text = "Score: \(score ?? 0)"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usedLettersLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            usedLettersLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            guessText.bottomAnchor.constraint(equalTo: usedLettersLabel.topAnchor, constant: -40),
            guessText.centerXAnchor.constraint(equalTo: usedLettersLabel.centerXAnchor),
            underscoreLabel.bottomAnchor.constraint(equalTo: guessText.topAnchor, constant: -50),
            underscoreLabel.centerXAnchor.constraint(equalTo: guessText.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let wordsURL = Bundle.main.url(forResource: "hangmanWords", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL){
                allWords = words.components(separatedBy: "\n")
            }
        }
        
        if allWords == [String]() {
            allWords = defaultString()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func startGame() {
        selectedWord = allWords[selectedWordIndex].lowercased()
        badChars = []
        goodChars = []
        usedLettersLabel.text = ""
        var displayWord = ""
        for _ in selectedWord.characters {
            displayWord += "__  "
        }
        
    }
    
    func defaultString() -> [String] {
        return ["Cow", "Pig", "Goose"]
    }
    
    
}

