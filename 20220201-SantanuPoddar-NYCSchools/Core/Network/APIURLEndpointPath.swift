//
//  APIURLEndpointPath.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import UIKit

struct APIURLEndpointPath {
    /// Base URL for  NYC High Schools
    static let baseURL = "https://data.cityofnewyork.us/resource"
    /// path for NYC School List
    static let schoolList = "/s3k6-pzi2.json"
    /// path for SAT scores
    static let schoolDetail = "/f9bf-2cp4.json"
}
