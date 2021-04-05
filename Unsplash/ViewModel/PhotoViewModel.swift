//
//  PhotoViewModel.swift
//  Unsplash
//
//  Created by Terry on 2021/04/06.
//

import Foundation
import Toast_Swift

class PhotoViewModel {
    var Photos : [Photo] = []
    
    func fetchDate(searchTerm userInput: String){
        NetworkManager.shared.getPhotos(searchTerm: userInput) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedPhotos):
                self.Photos = fetchedPhotos
            case .failure(let error):
                NSLog("error :\(error.localizedDescription)")
                
            }
        }
    }
}
