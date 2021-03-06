//
//  AppDelegate.swift
//  ComponentStudio
//
//  Created by Devin Abbott on 5/7/17.
//  Copyright © 2017 Devin Abbott. All rights reserved.
//

import Cocoa
import LetsMove
import MASPreferences

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationWillFinishLaunching(_ notification: Notification) {
#if DEBUG
#else
    PFMoveToApplicationsFolderIfNecessary()
#endif
    }

    var preferencesWindow: MASPreferencesWindowController?

    @IBAction func showPreferences(_ sender: AnyObject) {
        if preferencesWindow == nil {
            let workspace = WorkspacePreferencesViewController()
            workspace.viewDidLoad()

            preferencesWindow = MASPreferencesWindowController(viewControllers: [workspace], title: "Preferences")
        }

        preferencesWindow?.showWindow(sender)
    }

    var colorBrowserWindow: NSWindow?

    @IBAction func showColorBrowser(_ sender: AnyObject) {
        if colorBrowserWindow == nil {
            let initialRect = NSRect(x: 0, y: 0, width: 1280, height: 720)
            let window = NSWindow(contentRect: initialRect, styleMask: [.closable, .titled, .resizable], backing: .retained, defer: false)
            window.center()
            window.title = "Color Browser"
            window.isReleasedWhenClosed = false
            window.minSize = NSSize(width: 784, height: 300)

            let view = NSBox()
            view.boxType = .custom
            view.borderType = .noBorder
            view.contentViewMargins = .zero
            view.translatesAutoresizingMaskIntoConstraints = false

            window.contentView = view

            // Set up color browser

            let colorBrowser = ColorBrowser(colors: CSColors.colors)

            view.addSubview(colorBrowser)

            colorBrowser.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            colorBrowser.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            colorBrowser.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

            colorBrowserWindow = window
        }

        // TODO: Set colors every time we show the browser in case they've changed.
        // Also consider hooking into "Refresh" 

        colorBrowserWindow?.makeKeyAndOrderFront(nil)
    }
}
