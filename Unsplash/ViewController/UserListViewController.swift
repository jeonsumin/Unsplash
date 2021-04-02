//
//  UserListViewController.swift
//  Unsplash
//
//  Created by Terry on 2021/03/31.
//

import UIKit

class UserListViewController: BaseViewController {

    var userList = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("UserList userList.count \(userList.count)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
