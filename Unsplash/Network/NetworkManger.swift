//
//  NetworkManger.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager{
    
    //싱글턴 적용
    static let shared = NetworkManager()
    
    //인터셉터
    let intercepters = Interceptor(interceptors: [ BaseInterceptor() ])
    
    //로거 설정
    let logger = [AFLogger()] as [EventMonitor]
    
    //세션 설정
    var session = Session.default
    
    private init(){
        session = Session(interceptor: intercepters, eventMonitors: logger)
    }
    
    func getPhotos(searchTerm userInput: String, completion: @escaping (Result<[Photo],customError>) -> Void){
        NSLog("getPhotos() called userInput : \(userInput)")
        
        self.session
            .request(searchRouter.searchPhotos(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON { (response) in
                guard let responseValue = response.value else { return }
                let responseJson = JSON(responseValue)
                var photos = [Photo]()
                let jsonArray = responseJson["results"]
                for (_,subJson):(String,JSON) in jsonArray {
                    //데이터 파싱
                    let thumbnail = subJson["urls"]["thumb"].string ?? ""
                    let username = subJson["user"]["username"].string ?? ""
                    let likesCount = subJson["likes"].intValue
                    let createdAt = subJson["created_at"].string ?? ""
                    let photoItem = Photo(thumbnail: thumbnail, username: username, likeCount: likesCount, createAt: createdAt)
                    photos.append(photoItem)
                }
                if photos.count > 0 {
                    completion(.success(photos))
                }else {
                    completion(.failure(.noContent))
                }
            }
    }
    
    func getUsers(searchTerm userInput: String, complation: @escaping (Result<[Users], customError>) -> Void){
        NSLog("getUsers() called userinput: \(userInput)")
        
        self.session
            .request(searchRouter.searchUsers(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON { response in
                guard let responseValue = response.value else { return }
                let responseJson = JSON(responseValue)
                var users = [Users]()
                let jsonArray = responseJson["results"]
                for (_,subJon):(String,JSON) in jsonArray {
                    let username = subJon["username"].string ?? ""
                    let bio = subJon["bio"].string ?? ""
                    let profileImage = subJon["profile_image"]["medium"].string ?? ""
                    let userItem = Users(username: username, bio: bio, profileImage: profileImage)
                    users.append(userItem)
                }
                if users.count > 0 {
                    complation(.success(users))
                }else {
                    complation(.failure(.noContent))
                }
                
            }
    }
}
