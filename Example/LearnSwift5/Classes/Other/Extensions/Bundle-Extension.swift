//
//  Bundle-Extension.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import Foundation

extension Bundle {
    public var namespace: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
}

