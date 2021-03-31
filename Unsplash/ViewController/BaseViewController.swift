//
//  BaseViewController.swift
//  Unsplash
//
//  Created by Terry on 2021/04/01.
//

import UIKit

class BaseViewController: UIViewController {
    
    var vcTitle:String = "" {
        didSet {
            self.title = vcTitle
        }
    }
}

