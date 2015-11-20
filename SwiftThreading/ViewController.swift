//
//  ViewController.swift
//  SwiftThreading
//
//  Created by Joshua Smith on 7/5/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    @IBAction func handleButton(sender: AnyObject)
    {
        // NOTE: The semicolons prevent a compiler error
        // as of Xcode 6 Beta 3.
        
        { log("hello") } ~> { log("goodbye") };
        
        { addRange(0..<10_000) } ~> { log("sum = \($0)") };
    }
}

func addRange(range: Range<Int>) -> Int
{
    log("adding...")
    return range.reduce(0, combine: +)
}

func log(message: String)
{
    let main = NSThread.currentThread().isMainThread
    let name = main ? "[main]" : "[back]"
    print("\(name) \(message)")
}
