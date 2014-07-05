//
//  Threading.swift
//  SwiftThreading
//
//  Created by Joshua Smith on 7/5/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import Foundation

operator infix ~> {}

/** 
Executes the lefthand closure on a background thread and, 
upon completion, the righthand closure on the main thread. 
*/
@infix func ~> (
    backgroundClosure: () -> (),
    mainClosure:       () -> ())
{
    dispatch_async(_queue) {
        backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), mainClosure)
    }
}

/**
Executes the lefthand closure on a background thread and,
upon completion, the righthand closure on the main thread.
Passes the background closure's output to the main closure.
*/
@infix func ~> <R> (
    backgroundClosure: () -> R?,
    mainClosure:       (result: R?) -> ())
{
    dispatch_async(_queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), {
            mainClosure(result: result)
        })
    }
}

/** Serial dispatch queue used by the ~> operator. */
let _queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)
