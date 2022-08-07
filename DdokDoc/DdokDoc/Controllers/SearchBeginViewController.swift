//
//  SearchBeginViewController.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/06.
//

import UIKit

class SearchBeginViewController: UIViewController {


    // 🍎 서치 Results컨트롤러 ⭐️
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController)

    var networkManager = KakaoLocalDataManager.shared

    //BUTTONS
    @IBOutlet weak var locbutton: UIButton!
    @IBOutlet weak var datebutton: UIButton!
    @IBOutlet weak var entbutton: UIButton!
    @IBOutlet weak var eyebutton: UIButton!
    
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        configureUI()
    
        


    }
    
    // MARK: - NAV BAR CUSTOMIZE
    
    func configureNavBAR() {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = UIImage (named: "chevron.left")
    }
    
    // MARK: - BASIC UIs
    
    func configureUI(){
        locbutton.layer.cornerRadius = 5
        locbutton.clipsToBounds = true
        datebutton.layer.cornerRadius = 5
        datebutton.clipsToBounds = true
        
        entbutton.layer.cornerRadius = 10
        entbutton.clipsToBounds = true
        eyebutton.layer.cornerRadius = 10
        eyebutton.clipsToBounds = true
        
    }
    

    // MARK: - SEARCHBAR
    func setupSearchBar() {
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "증상 또는 병원을 검색해보세요."
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.searchController = searchController



        // 🍎 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self

        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }



}

extension SearchBeginViewController : UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
