//
//  GameViewController.swift
//  GyroGame
//
//  Created by Emilian Brenici on 02/10/2021.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    // prevent screen rotation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    // hide home indicator
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit // fit the screen
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // ensure home indicator is auto hidden
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
    
}
