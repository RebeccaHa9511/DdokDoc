//
//  TabViewController.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/06.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {
    
    //paging 할 뷰컨
    private var viewControllers: Array<UIViewController> = []
 
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HospitalInfoViewController") as! HospitalInfoViewController
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExamInfoViewController") as! ExamInfoViewController
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocInfoVC") as! DocInfoVC
        let vc5 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FacilityVC") as! FacilityVC
        let vc6 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NearbyPharmVC") as! NearbyPharmVC
                    
                viewControllers.append(vc2)
                viewControllers.append(vc3)
        viewControllers.append(vc4)
        viewControllers.append(vc5)
        viewControllers.append(vc6)
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar) //함수 추후 구현
        addBar(bar, dataSource: self, at: .top)
    }

    func settingTabBar (ctBar : TMBar.ButtonBar) {
           ctBar.layout.transitionStyle = .snap
           // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 20.0)
           
           // 간격
           ctBar.layout.interButtonSpacing = 35
               
        ctBar.backgroundView.style = .clear
           
           // 선택 / 안선택 색 + font size
           ctBar.buttons.customize { (button) in
               button.tintColor = .systemGray4
               button.selectedTintColor = .black
               button.font = UIFont.systemFont(ofSize: 16)
               button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
           }
           
           // 인디케이터 (영상에서 주황색 아래 바 부분)
           ctBar.indicator.weight = .custom(value: 2)
           ctBar.indicator.tintColor = .black
       }
    

   
    
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
   
        // MARK: -Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "병원 정보")
        case 1:
            return TMBarItem(title: "진료 정보")
        case 2:
            return TMBarItem(title: "의사 정보")
        case 3:
            return TMBarItem(title: "시설 정보")
        case 4:
            return TMBarItem(title: "근처 약국")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //위에서 선언한 vc array의 count를 반환합니다.
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

