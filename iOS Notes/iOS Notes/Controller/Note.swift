//
//  Note.swift
//  iOS Notes
//
//  Created by Alexander Ha on 10/29/20.
//

import UIKit

class Note: Codable, Equatable {

    var body: String
    var creation: Date
    
    init(body: String) {
        self.body = body
        self.creation = Date()
    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(body, forKey: "body")
//        coder.encode(creation, forKey: "creation")
//    }
//
//    required init(coder decoder: NSCoder) {
//        //decodes body object
//        body = decoder.decodeObject(forKey: "body") as! String
//        creation = decoder.decodeObject(forKey: "creation") as! Date
//    }
    static func == (lhs: Note, rhs: Note) -> Bool {
        return true
    }
    
    
}
