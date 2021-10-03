//
//  GameScene.swift
//  GyroGame
//
//  Created by Emilian Brenici on 02/10/2021.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    private var motionManager: CMMotionManager!
    private var playerNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        loadScene()
        startMotionManager()
    }
    
    private func loadScene() {
        physicsWorld.gravity = .zero
        addSceneBackground()
        createPlayer()
    }
    
    private func startMotionManager() {
        motionManager = CMMotionManager()
        guard motionManager.isAccelerometerAvailable else {
            return
        }
        motionManager.startAccelerometerUpdates()
    }
    
    private func createPlayer() {
        playerNode = SKSpriteNode(imageNamed: "ball")
        playerNode.position = CGPoint(x: 555, y: -372)
        playerNode.size = CGSize(width: 80, height: 80)
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.linearDamping = 0.4
        playerNode.physicsBody?.restitution = 0.2
        playerNode.physicsBody?.categoryBitMask = 1
        playerNode.physicsBody?.contactTestBitMask = 2 | 3 // holes and finish
        playerNode.physicsBody?.collisionBitMask = 2 // walls
        playerNode.zPosition = 1 // in front of bg and all holes
        addChild(playerNode)
    }
    
    private func addSceneBackground() {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.zPosition = -1
        addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
