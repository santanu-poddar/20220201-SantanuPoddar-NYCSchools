//
//  NYCSchoolListResponseModel.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import Foundation

struct NYCSchoolListResponseModel: Codable {
    var schoolData: [NYCSchoolList]?
}

struct NYCSchoolList: Codable {
    var dbn: String?
    var school_name: String?
}

