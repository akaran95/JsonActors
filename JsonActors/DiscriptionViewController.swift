//
//  DiscriptionViewController.swift
//  JsonActors
//
//  Created by Karan Arora on 08/01/18.
//  Copyright © 2018 Karan Arora. All rights reserved.
//

import UIKit

class DiscriptionViewController: UIViewController {
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var countryLBL: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var spouseLbl: UILabel!
    @IBOutlet weak var children: UILabel!
    @IBOutlet weak var discriptionLbl: UILabel!
    
    
    var abc: actor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLbl.text = abc?.name
        dobLbl.text = abc?.dob
        countryLBL.text = abc?.country
        heightLbl.text = abc?.height
        spouseLbl.text = abc?.spouse
        children.text = abc?.children
        discriptionLbl.text = abc?.description
        heroImage.downloadedFrom(link: (abc?.image)!)

    }


}
