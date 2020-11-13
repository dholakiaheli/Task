//
//  TaskController.swift
//  Task
//
//  Created by Heli Bavishi on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    //    var tasks: [Task] {
    //        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
    //        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    //    }

        //Mock data
    //    var mockTasks: [Task] = {
    //        let mockData = Task(name: "Task1", notes: "task1 Detail", due: Date(), isComplete: true)
    //        return [mockData]
    //    }()
    
    var fetchedResultsController: NSFetchedResultsController<Task>
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: true)]
        
        let resultController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error fetching obj \(error.localizedDescription)")
        }
    }
    
    //CRUD
    //Create
    func createTask(name: String,notes: String, due: Date) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    //Update
    func updateTask(name: String,notes: String, due: Date, task: Task) {
        task.name = name
        task.due = due
        task.notes = notes
        saveToPersistentStore()
    }
    
    //Delete
    func removeTask(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
    }
    
    //Persistent
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
//    func fetchTasks()->[Task] {
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }
    
    func taskIsComplete(for task: Task) {
        task.isComplete.toggle()
        saveToPersistentStore()
    }
} //END of class
