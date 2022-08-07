////
////  NetworkingModel.swift
////  DdokDoc
////
////  Created by Rebecca Ha on 2022/08/03.
////
//
//import Foundation
//
//// MARK: - MedicalInstitInfo
//struct MedicalInstitInfo: Codable {
//    let header: Header
//    let item: [Item]
//    let numOfRows, pageNo, totalCount: Int
//}
//
//// MARK: - Header
//struct Header: Codable {
//    let code, message: String
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let institNm, institKind: String
//    let medicalInstitKind: MedicalInstitKind
//    let zipCode, streetNmAddr, tel, organLOC: String
//    let monday, tuesday, wednesday, thursday: String
//    let friday, saturday: String
//    let sunday, holiday: Day
//    let sundayOperWeek: SundayOperWeek
//    let examPart, registDt, updateDt, lng: String
//    let lat: String
//
//    enum CodingKeys: String, CodingKey {
//        case institNm = "instit_nm"
//        case institKind = "instit_kind"
//        case medicalInstitKind = "medical_instit_kind"
//        case zipCode = "zip_code"
//        case streetNmAddr = "street_nm_addr"
//        case tel
//        case organLOC = "organ_loc"
//        case monday = "Monday"
//        case tuesday = "Tuesday"
//        case wednesday = "Wednesday"
//        case thursday = "Thursday"
//        case friday = "Friday"
//        case saturday = "Saturday"
//        case sunday = "Sunday"
//        case holiday
//        case sundayOperWeek = "sunday_oper_week"
//        case examPart = "exam_part"
//        case registDt = "regist_dt"
//        case updateDt = "update_dt"
//        case lng, lat
//    }
//}
//
//enum Day: String, Codable {
//    case empty = "~"
//    case the10002100 = "10:00~21:00"
//}
//
//enum MedicalInstitKind: String, Codable {
//    case 응급의료기관이외 = "응급의료기관이외"
//}
//
//enum SundayOperWeek: String, Codable {
//    case empty = ""
//    case the12345 = "1 2 3 4 5"
//}
