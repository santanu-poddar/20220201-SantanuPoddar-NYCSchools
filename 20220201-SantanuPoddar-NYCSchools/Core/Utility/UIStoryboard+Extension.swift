//
//  UIStoryboard+Extension.swift
//  20220201-SantanuPoddar-NYCSchools
//
//  Created by Santanu Poddar on 2/1/22.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

enum ViewControllerIdentifier: String {
    case nycSchoolDetailViewController = "NYCSchoolDetailViewController"
}

extension UIStoryboard {
    static func loadViewController(fromStoryboard storyboard: Storyboard, viewControllerIdentifier:  ViewControllerIdentifier) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier.rawValue)
    }
}
