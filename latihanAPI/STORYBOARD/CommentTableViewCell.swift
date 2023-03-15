//
//  CommentTableViewCell.swift
//  latihanAPI
//
//  Created by Salma Ayu on 14/03/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "CommentTableViewCell"
    @IBOutlet weak var postIdLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
