//
//  SearchViewController.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/04.
//

import UIKit
import CoreLocation
import Alamofire
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate  {
    
    @IBOutlet weak var locationButton: UIButton!
    
    
    var refreashControl = UIRefreshControl()
    let locationManager = CLLocationManager()
    let kakaoLocalDataManager = KakaoLocalDataManager()
    let naverImageDataManager = NaverImageDataManager()
    
    var hospitalInfos: [LocationInfo] = []

    // (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    //위치정보
    var currentLocationString: String = " 현위치: 온천동 "
    var x = "129.067745"
    var y = "35.214596"
    
    

    
    var isAvailable = true
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //NAVIGATION BAR

        setupDatas()
        

        //LOCATION MANAGER
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        requestNotificationPermission()
        
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            self.locationButton.titleLabel?.text = locationString
            print("💸💸💸💸   \(locationString)")
        }
        

        //COLLECTION VIEW
        self.collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreashControl
        refreashControl.addTarget(self, action: #selector(pullToRefreash(_:)), for: .valueChanged)
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationButton.titleLabel?.text = currentLocationString

    }
    
    // MARK: - SETUP DATA
    
    func setupDatas(){
        kakaoLocalDataManager.fetchHospitals(x: x, y: y, page: 1, delegate: self, searchTerm: searchTerm ?? "")
        
    }
 
    // MARK: - PULL TO REFRESH
    
    @objc func pullToRefreash(_ sender: Any) {
        self.hospitalInfos = []
        locationManager.requestLocation()
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            
            self.currentLocationString = locationString
            self.locationButton.titleLabel?.text = self.currentLocationString
        }
        kakaoLocalDataManager.fetchHospitals(x: x, y: y, page: 1, delegate: self, searchTerm: searchTerm ?? "")
        self.isAvailable = true

    }
    
    // MARK: - Notification
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                
                print("Push: 권한 허용")
            } else {
                
                print("Push: 권한 거부")
            }
        })
    }
        

    // MARK: - CollectionView Setup

    func configureCollectionView() {
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .systemGray5

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.frame.width
            layout.itemSize = CGSize(width: width, height: width / 19 * 25)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            
    }

}
}

// MARK: - DELEGATES

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func changeHeight() {
        self.collectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hospitalInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        

        if indexPath.row < hospitalInfos.count {
        let hospitalInfo = hospitalInfos[indexPath.row]
        
        
        
        cell.hospitalNameLbl.text = hospitalInfo.detail.place_name
        cell.departmentLbl.text = hospitalInfo.detail.category_name
        cell.distanceLbl.text = hospitalInfo.distance(latitude: Double(y)!, longitude: Double(x)!) + "km"
        cell.locationLbl.text = hospitalInfo.detail.address_name
            cell.backgroundColor = .white
        
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 465, height: 235)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            DetailViewController, let index =
            collectionView.indexPathsForSelectedItems?.first {
            destination.placeName = hospitalInfos[index.row].detail.place_name
            destination.depname = hospitalInfos[index.row].detail.category_name

        }
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .coverVertical

        

        
    }
        

        

            

        
    
}



// MARK: - EXTENDED NETWORKING - 네트워크 성공시 실행.
extension SearchViewController {
    
    // 네트워크 성공시 실행
    func didRetrieveLocal(response: KakaoLocalResponse) {
        
        DispatchQueue.main.async {
           self.collectionView.refreshControl?.endRefreshing()
        }
        
        if response.meta.is_end {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
        print("\(response.documents)")
        
        
        for (index, detail) in response.documents.enumerated() {
            //각각의 셀에 대해 이미지 요청
            naverImageDataManager.fetchImage(place_name: detail.place_name, location: currentLocationString) { urlString in
                if urlString != "요청실패" {
                    self.dismissIndicator()
                    
                    //이미지 urlString 을 받아온 경우. 이를 구조체로 묶어 뷰컨트롤러에 추가.
                    self.hospitalInfos.append(LocationInfo(urlString: urlString, detail: detail))
                    
                    //사용자 응답성 개선을 위해 main 큐에서 reload
                
                    self.collectionView.reloadData()
                
                    
                } else {
                    
                    self.dismissIndicator()
                    print("\(index)이미지 요청 실패")
                }
            }
        }
    }
    
    func failedToRequest(message: String) {
        self.dismissIndicator()
        self.isAvailable = true
    }
}

// MARK: - Location Delegate

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            
            self.x = String(coordinate.longitude)
            self.y = String(coordinate.latitude)
            print("위치 정보 불러오기 완료")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription + "🗺 ")
    }
}

