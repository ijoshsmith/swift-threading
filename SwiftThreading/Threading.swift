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
#if os(Linux)
    import Dispatch
#endif

infix operator ~>   // serial queue operator
/**
 Executes the lefthand closure on a background thread and,
 upon completion, the righthand closure on the main thread.
 */
func ~> (
    backgroundClosure: @escaping () -> (),
    mainClosure:       @escaping () -> ())
{
    serial_queue.async {
        backgroundClosure()
        DispatchQueue.main.async(execute: mainClosure)
    }
}

/**
 Executes the lefthand closure on a background thread and,
 upon completion, the righthand closure on the main thread.
 Passes the background closure's output to the main closure.
 */
func ~> <R> (
    backgroundClosure:  @escaping () -> R,
    mainClosure:        @escaping (_ result: R) -> ())
{
    serial_queue.async {
        let result = backgroundClosure()
        DispatchQueue.main.async(execute: {
            mainClosure(result)
        })
    }
}
/** Serial dispatch queue used by the ~> operator. */
private let serial_queue = DispatchQueue(label: "serial-worker")

////////////////////////////////////////////////////////////////////////////////////////////////////

infix operator ≠>   // concurrent queue operator
func ≠> (
    backgroundClosure: @escaping () -> (),
    mainClosure:       @escaping () -> ())
{
    concurrent_queue.async {
        backgroundClosure()
        DispatchQueue.main.async(execute: mainClosure)
    }
}

/**
 Executes the lefthand closure on a background thread and,
 upon completion, the righthand closure on the main thread.
 Passes the background closure's output to the main closure.
 
 */
func ≠> <R> (
    backgroundClosure: @escaping () -> R,
    mainClosure:       @escaping (_ result: R) -> ())
{
    concurrent_queue.async {
        let result = backgroundClosure()
        DispatchQueue.main.async(execute: {
            mainClosure(result)
        })
    }
}

/** Concurrent dispatch queue used by the ≠> operator. */
private let concurrent_queue = DispatchQueue(label: "concurrent-worker", attributes: .concurrent)
