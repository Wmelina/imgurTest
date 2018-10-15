//
//  ImageLoad.swift
//  imgur
//
//  Created by Alexandr Kurdyukov on 15.10.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit

class ImageLoad {
    
    static func asyncGetImage(_ urlStr: String, _ imageView:UIImageView) {
        let url:URL = URL(string: urlStr)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if data != nil {
                let image = UIImage(data: data!)
                if image != nil {
                    DispatchQueue.main.async(execute:{
                        
                        imageView.image = image
                    })
                }
            }
        })
        task.resume()
    }


    static func getImage(_ urlStr: String, _ imageView: UIImageView) {
        
        let url:URL = URL(string: urlStr)!
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            if image != nil {
                imageView.image = image
                
            }
        } catch let err {
            print(err)
        }
        
    }

}
