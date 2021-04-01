//
//  NetworkManger.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation
import Alamofire

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
}
