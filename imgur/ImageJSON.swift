//
//  ImageJSON.swift
//  imgur
//
//  Created by Alexandr Kurdyukov on 14.10.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit

struct ImageJSON {
    
    var hashStr = String()
    var URL = String()
    var title = String()
    var description = String()
    
    init() {
        
    }
    
    init(hashStr: Any?, url: Any?, title: Any?, desc: Any?) {
        if hashStr is String {
            self.hashStr = hashStr as! String
        } else {
            self.hashStr = ""
        }
        if url is String {
            self.URL = url as! String
        } else {
            self.URL = ""
        }
        if title is String {
            self.title = title as! String
        } else {
            self.title = ""
        }
        if desc is String {
            self.description = desc as! String
        } else {
            self.description = ""
        }
    }
}
