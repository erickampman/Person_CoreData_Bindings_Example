//
//  ViewController.swift
//  Person_CoreData_Bindings_Example
//
//  Created by Eric Kampman on 2/4/18.
//  Copyright © 2018 Eric Kampman. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func clear(_ sender: Any) {
        willChangeValue(for: \ViewController.me)
        dataController.deleteAll(entityName: "Person")
        didChangeValue(for: \ViewController.me)
        //        meObjectController.fetch(self)
        nameLabel.setNeedsDisplay()
    }
    @IBAction func add(_ sender: Any) {
        
        // only adds once
        willChangeValue(for: \ViewController.me)
        dataController.addPerson(name: myName);
        didChangeValue(for: \ViewController.me)
        //       meObjectController.fetch(self)
        nameLabel.setNeedsDisplay()
    }
    
    let myName = "John Doe"

    @objc dynamic var dataController:  DataController {
        let delegate = NSApp.delegate as! AppDelegate
        return delegate.persistentContainer
    }
    
    @IBOutlet var personObjectController: NSObjectController!
    @IBOutlet weak var nameLabel: NSTextField!
    
    @objc dynamic var me: Person? {
        return dataController.fetchPerson(name: myName)
    }

}

