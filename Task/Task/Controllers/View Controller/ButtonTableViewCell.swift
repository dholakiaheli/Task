//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Heli Bavishi on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(for sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var primaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateButton(_ isComplete: Bool) {
        if isComplete {
        self.completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            self.completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(for: self)
    }
}
    extension ButtonTableViewCell {
        func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

