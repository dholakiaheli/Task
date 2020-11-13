//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Heli Bavishi on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextLabel: UITextField!
    @IBOutlet weak var dueTextLabel: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
            }
        }
    
    var dueDateValue: Date?
    var isComplete: Bool?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextLabel.inputView = datePicker
        updateViews()
    }
   
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        dueTextLabel.text = datePicker.date.stringValue()
        dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        nameTextLabel.resignFirstResponder()
        dueTextLabel.resignFirstResponder()
        noteTextView.resignFirstResponder()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = nameTextLabel.text,
             let dueString = dueTextLabel.text,
             let due = dateFormatter.date(from: dueString),
             let note = noteTextView.text else { return }
        if let task = task {
            TaskController.shared.updateTask(name: name, notes: note, due: due, task: task)
        }else {
            TaskController.shared.createTask(name: name, notes: note, due: due)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextLabel.text = task.name
        noteTextView.text = task.notes
        dueTextLabel.text = task.due?.stringValue()
    }
}
