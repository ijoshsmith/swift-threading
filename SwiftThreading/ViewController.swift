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
        
        // serial queue
        { fib(40); } ~> { log("40th fib=\($0)") };  // Return with Implicit Argument
        { fib(35); } ~> { result in log("35th fib=\(result)") }; // Return with Shorthand Argument
        
        // concurrent queue
        { fib(45); } ≠> { log("45th fib=\($0)") }; // this should finish last
        { fib(42); } ≠> { result in log("42th fib=\(result)") }; // this should finish first
        
    }
}

/// Exponential Time Fibonacci Sequence
func fib(_ n: Int) -> Int{

    if n <= 1 {
        return n
    } else {
        return fib(n - 1) + fib(n - 2)
    }
}

// note: currently not working on Linux because "isMainThread" is not implemented yet
func log(_ message: String)
{
    let main = Thread.current.isMainThread
    let name = main ? "[main]" : "[back]"
    print("\(name) \(message)")
}
