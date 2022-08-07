//
//  MainViewController.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/03.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    //BANNER
    @IBOutlet weak var bannerscrollView: UIScrollView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    var images = [UIImage(named: "banner1"), UIImage(named: "banner2")]
    var imageViews = [UIImageView]()
    

    @IBOutlet weak var searchBarButton: UIButton!
    
    
    // MARK: - viewdidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BANNER
        bannerscrollView.delegate = self
        addContentScrollView()
        setPageControl()
        
        //SEARCH BAR
        configureSearchBar()
        
        
    }
    
    // MARK: - LIFE
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    
    // MARK: - Banner Scroll View
    private func addContentScrollView() {
           for i in 0..<images.count {
               let imageView = UIImageView()
               let xPos = self.view.frame.width * CGFloat(i)
               imageView.frame = CGRect(x: xPos, y: 0, width: bannerscrollView.bounds.width, height: bannerscrollView.bounds.height)
               imageView.image = images[i]
               bannerscrollView.addSubview(imageView)
               bannerscrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
           }
       }
 
    private func setPageControl() {
        bannerPageControl.numberOfPages = images.count
     }

    private func setPageControlSelectedPage(currentPage:Int) {
        bannerPageControl.currentPage = currentPage
       }
    
    func scrollViewDidScroll(_ bannerscrollView: UIScrollView) {
          let value = bannerscrollView.contentOffset.x/bannerscrollView.frame.size.width
          setPageControlSelectedPage(currentPage: Int(round(value)))
      }
    

    // MARK: - SearchBar
    func configureSearchBar() {
        searchBarButton.setTitle("", for: .normal)
    }
    
//    @IBAction func searchBarTapped(_ sender: UIButton) {
//        let newVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController")
//        newVC?.modalTransitionStyle = .coverVertical
//                newVC?.modalPresentationStyle = .fullScreen
//                self.present(newVC!, animated: true, completion: nil)
//        
//        
//
//    }
    
    
}

