//
//  SearchTableViewCell.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/05.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalNameLbl: UILabel!
    @IBOutlet weak var departmentNameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
}
