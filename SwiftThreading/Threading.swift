//
//  Threading.swift
//  SwiftThreading
//
//  Created by Joshua Smith on 7/5/14.
//  Copyright (c) 2014 iJoshSmith. Licensed under the MIT License.
//

//
// This code has been tested against Xcode 6 Beta 5.
//

import Foundation

infix operator ~> {}

/**
 Executes the lefthand closure on a background thread and,
 upon completion, the righthand closure on the main thread.
 Passes the background closure's output, if any, to the main closure.
*/
func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure:       (result: R) -> ())
{
    DispatchQueue.global().async {
        let result = backgroundClosure()
        DispatchQueue.main.async {
            mainClosure(result: result)
        }
    }
}

/** Serial dispatch queue used by the ~> operator. */
private let queue = DispatchQueue(label: "serial-worker")
