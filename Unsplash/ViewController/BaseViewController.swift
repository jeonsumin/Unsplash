//
//  BaseViewController.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
// 모든 뷰에 공통적으로 사용해야할때 baseVC를 만들어서 사용하면 효율적?

import UIKit
import Toast_Swift
class BaseViewController: UIViewController {
    
    var vcTitle:String = "" {
        didSet {
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 인증실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(ErrorPopup), name: NSNotification.Name(NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 인증실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name(NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
        
    //MARK:- objc methods
    @objc func ErrorPopup(noti:NSNotification){
        NSLog("BaseViewController - ErrorPopup()")
        if let data = noti.userInfo?["statusCode"] {
            NSLog("ErrorPopup \(data)")
            // 토스트를 사용했던 스레드가 메인쓰레드가 아니기 때문에 메인스레드에서 돌 수 있도록 설정 
            DispatchQueue.main.async {
                self.view.makeToast("‼️ \(data) 에러 입니 다 ‼️")
            }
            
        }
    }
}

