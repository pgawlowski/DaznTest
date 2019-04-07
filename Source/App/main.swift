//
//  main.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 07/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import SwiftyBeaver
import UIKit

#if Debug
let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? NSStringFromClass(TestingAppDelegate.self) : NSStringFromClass(AppDelegate.self)
let app = isRunningTests ? nil : NSStringFromClass(App.self)
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc))
UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    app,
    appDelegateClass
)
#else
UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(AppDelegate.self)
)
#endif
