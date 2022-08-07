////
////  Networking.swift
////  DdokDoc
////
////  Created by Rebecca Ha on 2022/08/05.
////
//
//import Foundation
//import Alamofire
//
//
//class Networking {
//    static let shared = Networking()
//
//
//    func getAllHospitalInfo(delegate: SearchViewController) {
//
//        let params : [String:String] = [
//            "resultType" : "json"
//        ]
//
//
//        AF.request(Constant.BASE_URL, method: .get, parameters: params, headers: Keys.HEADERS)
//            .validate()
//            .responseJSON { response in
//                debugPrint(response)
//                switch response.result {
//                case .success(let response):
//                    debugPrint(response)
//                    print("성공이야 ㅠ!")
//                    delegate.didRetrieveLocal(response: response as! MedicalInstitInfo)
//                case .failure(let error):
//                    print(error)
//                delegate.failedToRequest(message: "서버와의 연결이 별로임.")
//                }
//            }
//}
//
//}
