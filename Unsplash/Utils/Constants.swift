//
//  Constants.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import Foundation

enum segueId {
    static let USER_LIST = "segueUserList"
    static let PHOTO_LIST = "seguePhoto"
}

enum API {
    static let BASE_URL : String = "https://api.unsplash.com/"
    static let CLIENT_ID : String = "QeHlNIEldhPFyrLY2aSNJ67IEaZGTuN5Um2p4bt4WGU"
}

enum NOTIFICATION {
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
}
