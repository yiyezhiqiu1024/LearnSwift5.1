//
//  ViewModelProtocol.swift
//  LearnSwift5
//
//  Created by CoderSLZeng on 2019/6/28.
//  Copyright © 2019 CoderSLZeng. All rights reserved.
//

import UIKit

@objc public protocol ViewModelProtocol {
    
    @objc optional func bindViewModel(_ bindView: UIView)

}
