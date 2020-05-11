//
//  SceneDelegate.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 05/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let router = NotesRouter()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: router.listView(context: context))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

