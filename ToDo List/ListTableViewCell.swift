//
//  ListTableViewCell.swift
//  ToDo List
//
//  Created by 顏逸修 on 2023/4/3.
//

import UIKit


protocol ListTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
}


class ListTableViewCell: UITableViewCell {
    
    weak var delegate: ListTableViewCellDelegate?

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
    
}
