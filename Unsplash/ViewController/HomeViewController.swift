//
//  ViewController.swift
//  Unsplash
//
//  Created by Terry on 2021/03/31.
//

import UIKit
import Toast_Swift

class HomeViewController: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var searchFilterSeg: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    //MARK:- override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        keyboardDismissTabGesture.delegate = self
        self.config()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("HomeViewController viewWillAppear() called")
        
        // 키보드 올라가는 이벤트를 받는 처리
        // 키보드 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidehandle), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder() // 포커싱주기
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("HomeViewController viewWillDisappear() called")
        //키보드 노티피케이션 해제
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification,object: nil)

    }
    
    //화면이 넘어가기 전에 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segueId.PHOTO_LIST:
            //다음 화면의 뷰컨트롤러를 가져온다.
            let nextVc = segue.destination as! PhotoCellectionViewController
            
            guard let userInputText = searchBar.text else { return }
            nextVc.vcTitle = userInputText
        case segueId.USER_LIST:
            //다음 화면의 뷰컨트롤러를 가져온다.
            let nextVc = segue.destination as! UserListViewController
            
            guard let userInputText = searchBar.text else { return }
            nextVc.vcTitle = userInputText
        default:
            print("default")
        }
    }
    //MARK:- Private Methods
    private func config(){
        //ui 설정
        SearchButton.layer.cornerRadius = 10
        //서치바 경계선 없애기
        searchBar.searchBarStyle = .minimal
        //제스처 추가
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
        
    }
    private func pushVC(){
        var segueId: String = ""
        switch searchFilterSeg.selectedSegmentIndex {
        case 0:
            NSLog("사진화면으로 이동")
            segueId = "seguePhoto"
        case 1:
            NSLog("유저화면으로 이동")
            segueId = "segueUserList"
        default:
            NSLog("default")
        }
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    @objc func keyboardWillShowHandle(notification: NSNotification){
        //키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height < SearchButton.frame.origin.y {
                let distance = keyboardSize.height - SearchButton.frame.origin.y
                self.view.frame.origin.y = distance + SearchButton.frame.height
            }
            
        }
        self.view.frame.origin.y = -100
    }
    @objc func keyboardWillHidehandle(){
        self.view.frame.origin.y = 0
        
    }
    
    
    
    //MARK:- IBAction methos
    @IBAction func didTappedSearchFilter(_ sender: UISegmentedControl) {
        NSLog("HomeViewController - didTappedSearchFilter() called")
        var searchBarTitle = ""
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        searchBar.placeholder = "\(searchBarTitle) 입력 "
        
        //포커싱 on
        searchBar.becomeFirstResponder()
        //포커싱 off
        //        searchBar.resignFirstResponder()
    }
    
    @IBAction func didTappedSearchButton(_ sender: UIButton) {
        NSLog("HomeViewController - didTappedSearchButton() called \(searchFilterSeg.selectedSegmentIndex)")
        pushVC()
    }
    
    //MARK: - UISearchBar Delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userInputString = searchBar.text else {return}
        if userInputString.isEmpty {
            self.view.makeToast("📢 검색 키워드를 입력해주세요. 📢", duration:1.0, position: .center)
        }else{
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    // 서치바에 입력할때 감지 textDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSLog("HomeViewController - searchBar textDidChange() called \(searchText)")
        
        //사용자가 입력한 값이 없을때
        if (searchText.isEmpty){
            SearchButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                //포커싱 해제
                searchBar.resignFirstResponder()
            }
        }else{
            SearchButton.isHidden = false
        }
        
    }
    //글자가 입력될때 글자수 감지 shouldChangeTextIn
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        NSLog("shouldChangeTextIn : \(searchBar.text?.appending(text).count ?? 0)")
        
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        if (inputTextCount >= 12 ){
            self.view.makeToast("📢 12자 까지만 입력가능합니다. 📢", duration:1.0, position: .center)
            
        }
        
//        if inputTextCount <= 12 {
//            return true
//        }else{
//            return false
//        }
        
        return inputTextCount <= 12
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        NSLog("HomeController - gestureRecognizer() called ")
        
        if(touch.view?.isDescendant(of: searchFilterSeg) == true){
            return false
        } else if (touch.view?.isDescendant(of: searchBar) == true){
            return false
        } else {
            view.endEditing(true)
            return true
        }
    }
}
