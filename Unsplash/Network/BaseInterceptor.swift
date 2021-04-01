//
//  BaseInterceptor.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation
import Alamofire

class BaseInterceptor:RequestInterceptor {
    
    //
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        NSLog("BaseInterceptor - adap() called")
        var request = urlRequest
        
        request.addValue("appliction/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("appliction/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        //공통 파라미터 추가
        var dictionary = [String:String]()
        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
        
        do{
            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
        }catch(let error){
            NSLog(error.localizedDescription)
        }
        completion(.success(request))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        NSLog("BaseInterceptor - retry() called")
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        let data = ["statusCode" : statusCode]
        NotificationCenter.default.post(name: NSNotification.Name(NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
        completion(.doNotRetry)
    }
}
