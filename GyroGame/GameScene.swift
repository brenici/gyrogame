//
//  GameScene.swift
//  GyroGame
//
//  Created by Emilian Brenici on 02/10/2021.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        loadScene()
    }
    
    func loadScene() {
        addSceneBackground()
    }
    
    func addSceneBackground() {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.zPosition = -1
        addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
