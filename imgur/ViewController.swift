//
//  ViewController.swift
//  imgur
//
//  Created by Alexandr Kurdyukov on 11.10.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imageJSON = [ImageJSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        let width = (view.frame.size.width - 21) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.isPagingEnabled = true
        
        request("https://api.imgur.com/3/album/cvnADJK/images", method: .get, headers: ["Authorization": "Client-ID 6ad88542dea9006"]).responseJSON(completionHandler: { (response) in
            if let json = response.result.value {
                var imageJson = json as! [String:Any]
                var arrayOfImage = imageJson["data"] as! [[String:Any]]
                for index in 0..<arrayOfImage.count {
                    self.imageJSON.append(ImageJSON(hashStr: arrayOfImage[index]["id"], url: arrayOfImage[index]["link"], title: arrayOfImage[index]["title"], desc: arrayOfImage[index]["description"]))
                    print(self.imageJSON[index])
                }
                self.collectionView.reloadData()
            }
        })
    }
}


//collection view
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageJSON.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        ImageLoad.asyncGetImage(imageJSON[indexPath.row].URL, cell.image)
        cell.name.text = imageJSON[indexPath.row].title
        
        return cell
        
    }
}

//segue
extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = getIndexPathForSelectedCell() {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.localName = imageJSON[indexPath.row].title
            detailViewController.localDesription = imageJSON[indexPath.row].description
            //getImage(imageJSON[indexPath.row].URL, detailViewController.localImageView)
            //better async in detailview
            detailViewController.imageURL = imageJSON[indexPath.row].URL
            detailViewController.localID = imageJSON[indexPath.row].hashStr
        }
        
    }
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
    
        var indexPath:NSIndexPath?
        if collectionView.indexPathsForSelectedItems?.count != 0 {
            indexPath = collectionView.indexPathsForSelectedItems?[0] as NSIndexPath?
        }
        return indexPath
        
    }
}


