//
//  ViewController.swift
//  Crawler
//
//  Created by Dunya Kirkali on 8/4/18.
//  Copyright © 2018 Ahtung. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var fromField: NSTextField!
    @IBOutlet weak var toField: NSTextField!
    @IBOutlet weak var searchButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fromField.delegate = self
        toField.delegate = self
        searchButton.action = #selector(ViewController.search)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        let field = obj.object as! NSTextField
        switch field {
        case fromField:
            print("Aa")
        case toField:
            print("Bb")
        default:
            print("~~")
        }
    }
}

extension ViewController {
    @objc func search() {
        print("Search")
    }
}
