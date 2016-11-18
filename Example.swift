//
//  Example.swift
//  videoRenderer
//
//  Created by Philip Bernstein on 11/17/16.
//  Copyright © 2016 Philip Bernstein. All rights reserved.
//

import Foundation
import UIKit
class Example : NSObject {
    var i = 1

    override init() {
        super.init()
        self.doSomethingCrazyAndUpdateUI()
    }
    func doSomethingCrazyAndUpdateUI() {
        {
            while(self.i < 10000) {
                self.i = self.i + 1
            }
        } ~> {
            let label: UILabel = UILabel()
            label.text = NSString.localizedStringWithFormat("%d", self.i) as String;
        }
    }
}
