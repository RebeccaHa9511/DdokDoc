//
//  KakaoLocalDataManger.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/05.
//

import Foundation
import Alamofire

class KakaoLocalDataManager {
    
    func fetchCurrentLocation(x: String, y: String, completion: @escaping (String) -> Void) {
        let parameters: [String: [String]] = [
            "x": ["\(x)"],
            "y": ["\(y)"]
        ]
        
        AF.request(Constant.KAKAO_GEO_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Keys.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoGeoResponse.self) { response in
                switch response.result {
                case .success:
                    print("위치정보 받아오기 성공")
                    
                    if let locationString = response.value?.documents[0].region_2depth_name {
                        completion(locationString)
                    } else {
                        completion("현재 지역 정보 불러오기 실패")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

    }
}
