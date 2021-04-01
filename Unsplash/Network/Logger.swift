//
//  Logger.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation
import Alamofire

class AFLogger: EventMonitor{
    let queue =  DispatchQueue(label:"AFLogger")
    
    func requestDidResume(_ request: Request) {
        NSLog("AFLogger - requestDidResume(request) called ")
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        NSLog("AFLogger - request(didParseResponse) called ")
    }
}
