//
//  GameViewController.swift
//  GyroGame
//
//  Created by Emilian Brenici on 02/10/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

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
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    // prevent screen rotation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight //
    }

    // show game board only
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
