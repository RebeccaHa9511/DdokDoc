//
//  DetailViewController.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/05.
//

import UIKit
import Alamofire
import Kingfisher
import CoreLocation


class DetailViewController: UIViewController {

    
    var placeName : String = ""
    var depname : String = ""
    
    
    var detailDATA: [Hospitals] = []
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var hospitalNameNavItem: UINavigationItem!
    
    //받아올 INFO
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var hospnameLabel: UILabel!
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupData()
        
    }

  
    
    // MARK: -  BASIC UI
    func configureUI() {
        backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        
        phoneButton.layer.cornerRadius = 10
        phoneButton.clipsToBounds = true
    }
   
    func setupData(){
        hospnameLabel.text = placeName
        hospitalNameNavItem.title = placeName
        departmentLabel.text = depname
        
    }
   
    
}


