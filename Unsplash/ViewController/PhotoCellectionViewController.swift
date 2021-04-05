//
//  PhotoCellectionViewController.swift
//  Unsplash
//
//  Created by Terry on 2021/03/31.
//

import UIKit
import SDWebImage

class PhotoCellectionViewController: BaseViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var photo = [Photo]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        NSLog("photoCollectoinView - photo : \(photo)")
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return photo.count
        return photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? photoCell else {
            return UICollectionViewCell()
        }
        let photos: Photo = self.photo[indexPath.row]
        cell.photoImage.sd_setImage(with: URL(string: photos.thumbnail), completed: nil)
        cell.photoImage.contentMode = .scaleAspectFill
        
        cell.backgroundColor = .blue
        return cell
    }
    
    //MARK:- private Methods
}

class photoCell:UICollectionViewCell{
    @IBOutlet weak var photoImage: UIImageView!
}
