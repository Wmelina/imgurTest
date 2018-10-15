//
//  DetailViewController.swift
//  imgur
//
//  Created by Alexandr Kurdyukov on 12.10.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var locTitle: UILabel!
    @IBOutlet weak var locDescription: UILabel!

    var localID = String()
    var localName = String()
    var localDesription = String()
    var imageURL = String()
    
    var imageInfo = ImageJSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locTitle.text = localName
        locDescription.text = localDesription
        ImageLoad.asyncGetImage(imageURL, image)
        request("https://api.imgur.com/3/gallery/image/\(localID)", method: .get, headers: ["Authorization": "Client-ID 6ad88542dea9006"]).responseJSON { (response) in
            if let json = response.result.value {
                print(json)
            }
        }
    }
}



