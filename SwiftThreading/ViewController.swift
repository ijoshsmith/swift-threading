//
//  ViewController.swift
//  SwiftThreading
//
//  Created by Joshua Smith on 7/5/14.
//  Copyright (c) 2014 iJoshSmith. Licensed under the MIT License.
//

import UIKit

class ViewController: UIViewController
{
    @IBAction func handleButton(_ sender: AnyObject)
    {
        // NOTE: The semicolons prevent a compiler error as of Xcode 7.2
        
        { log("hello") } ~> { log("goodbye") };
        
        { addRange(0..<10_000) } ~> { log($0) };
    }
}

func addRange(_ range: Range<Int>) -> String
{
    log("adding...")
    return String("\([Int](range.lowerBound..<range.upperBound).reduce(0, +))")
}

func log(_ message: String)
{
    let main = Thread.current.isMainThread
    let name = main ? "[main]" : "[back]"
    print("\(name) \(message)")
}
