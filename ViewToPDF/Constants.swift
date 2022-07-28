//
//  Constants.swift
//  ViewToPDF
//
//  Created by Shayne Torres on 7/27/22.
//

import Foundation
import UIKit

enum PageType {
    case a4
    
    var size: CGRect {
        switch self {
        case .a4:
            return .init(x: 0, y: 0, width: (8.5 * 72.0), height: (11 * 72.0))
        }
    }
    
    var margin: CGFloat {
        switch self {
        case .a4:
            return 40
        }
    }
    
    var marginedWidth: CGFloat {
        switch self {
        case .a4:
            return PageType.a4.size.width - (PageType.a4.margin * 2)
        }
    }
}
