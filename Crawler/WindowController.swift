//
//  WindowController.swift
//  Crawler
//
//  Created by Dunya Kirkali on 8/14/18.
//  Copyright © 2018 Ahtung. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var toolbar: NSToolbar!
    @IBOutlet weak var printToolbarItem: NSToolbarItem!
    @IBOutlet weak var colorToolbarItem: NSToolbarItem!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        toolbar.delegate = self
        
        printToolbarItem.action = #selector(printSelected(sender:))
    }
}

extension WindowController: NSToolbarDelegate {

}

extension WindowController {    
    @objc func printSelected(sender: NSToolbarItem) {
        print("TODO")
    }
}
