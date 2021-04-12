//
//  AppDelegate.swift
//  CrypTouchBar
//
//  Created by İlayda Şimşek on 5.04.2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    let touchBarController = TouchBarController()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.styleMask.remove(.resizable)
        window.contentViewController = MainViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}

