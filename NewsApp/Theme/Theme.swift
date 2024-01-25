//
//  Theme.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/22/24.
//

import Foundation
import UIKit
struct Theme {
    enum Font {
        static let headerFont = UIFont.systemFont(ofSize: 58, weight: .bold)
        static let subHeaderFont = UIFont.systemFont(ofSize: 32, weight: .thin)
        static let titleFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        static let subtitleFont = UIFont.systemFont(ofSize: 14, weight: .thin)
    }
    enum Size: CGFloat{
        case topOffset = 15
        case leadingOffset = 20
        case trailingOffset = -20
        case cornerRadiusSize = 30
    }
    enum Texts: String {
        case appName = "News App"
        case welcomeMessage = "Good Afternoon"
        //dummy
        case titleMessage = "Friday 19 Jan"
    }
    enum Identifier: String {
        case topHeadlinesCell = "TopHeadLines"
    }
    struct Color {
        static let appBackgroundColor = UIColor.systemGray4
        static let subtitleColor = UIColor.systemGray
        static let titleColor = UIColor.label
    }
}

