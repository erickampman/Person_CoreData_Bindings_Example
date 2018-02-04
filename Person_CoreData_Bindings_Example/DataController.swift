//
//  DataController.swift
//  CoreDataEarTest
//
//  Created by Eric Kampman on 2/1/18.
//  Copyright © 2018 Eric Kampman. All rights reserved.
//

import Cocoa

class DataController: NSPersistentContainer {
    
    func addPerson(name: String) {
        if nil == fetchPerson(name: name) {
            let person = Person(context: moc)
            person.name = name
            do {
                try moc.save()
            }
            catch {
                Swift.print("addPerson failed to save")
            }
        }
    }
    
    func fetchPerson(name: String) -> Person? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: moc)
        let predicate = NSPredicate(format: "name == %@", name as NSString)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        do {
            let objs = try moc.fetch(fetchRequest)
            if objs.count > 0 {
                Swift.print("Person \(name) exists")
                return objs[0] as? Person
            }
            return nil
        }
        catch {
            return nil
        }
    }
    
    func exists(entityName: String) ->Bool {
        return count(entityName: entityName) != 0
    }
    
    func count(entityName: String) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: moc)
        fetchRequest.entity = entity
        
        do {
            let objs = try moc.fetch(fetchRequest)
            Swift.print("fetch : \(String(describing: objs))")
            return objs.count
        }
        catch {
            return 0
        }
    }
    
    func deleteAll(entityName: String) {
        let delFetchRqst = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let delRqst = NSBatchDeleteRequest(fetchRequest: delFetchRqst)
        
        do {
            try psc.execute(delRqst, with: moc)
        }
        catch {
            Swift.print("deleteAll failed")
        }
    }
    
    @objc dynamic var moc: NSManagedObjectContext {
        return viewContext
    }
    
    @objc dynamic var psc: NSPersistentStoreCoordinator {
        return persistentStoreCoordinator
        
    }

}
