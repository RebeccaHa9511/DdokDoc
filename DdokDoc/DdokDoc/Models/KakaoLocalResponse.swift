//
//  KakaoLocalResponse.swift
//  DdokDoc
//
//  Created by Rebecca Ha on 2022/08/05.
//

import Foundation

struct KakaoLocalResponse: Decodable {
    let documents: [Hospitals]
    let meta: MetaContainer
    struct MetaContainer: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let same_name: RegionInfo
        
        struct RegionInfo: Decodable { //same_name
            let keyword: String //질의어에서 지역 정보를 제외한 키워드
            let region: [String] //질의어에서 인식된 지역의 리스트
            let selected_region: String //인식된 지역 리스트 중, 현재 검색어에 사용된 지역 정보
        }
        let total_count: Int //검색어에 검색된 문서 수
    }
}

struct KakaoGeoResponse: Decodable {
    let meta: Meta
    struct Meta: Decodable {
        let total_count: Int //검색어에 검색된 문서 수
    }
    let documents: [GeoData]
}

struct GeoData: Decodable {
        let region_type: String
        let address_name: String
        let region_1depth_name: String
        let region_2depth_name: String
        let region_3depth_name: String
        let region_4depth_name: String
        let code: String
        let x: Double
        let y: Double
}


struct Hospitals: Decodable {
    let address_name: String
    let category_group_code: String
    let category_group_name: String
    let category_name: String
    let distance: String
    let id: String
    let phone: String
    let place_name: String
    let place_url: String
    let road_address_name: String
    let x: String
    let y: String
}
