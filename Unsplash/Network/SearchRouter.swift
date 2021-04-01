//
//  SearchRouter.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation
import Alamofire

//검색관련 API 호출
enum searchRouter: URLRequestConvertible {
    case searchPhotos(term :String)
    case searchUsers(term :String)
    
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }
    
    var method: HTTPMethod {
//        example
//        switch self {
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
        
        switch self {
        case .searchPhotos, .searchUsers:
            return .get
        }
    }
    
    var endPoint: String {
        switch self {
        case .searchPhotos:
            return "photos/"
        case .searchUsers:
            return "users/"
        }
    }
    
    var parameters:[String:String] {
        switch self {
        case let .searchPhotos(term),let .searchUsers(term):
            return ["query": term]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        NSLog("searchRouter - asURLRequest called")
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
        return request
    }
}
