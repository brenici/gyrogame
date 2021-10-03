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
    var playerNode: SKSpriteNode!
    private var isGameOver = false
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .light)
    private let hapticNotification = UINotificationFeedbackGenerator()
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        loadScene()
        startMotionManager()
    }
    
    private func loadScene() {
        addSceneBackground()
        createPlayer()
        setupHolesRadius()
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
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: playerNode.size.width / 2)
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.density = 7.0               // real steel ball density
        playerNode.physicsBody?.linearDamping = 0.5         // increased friction
        playerNode.physicsBody?.restitution = 0.3           // increased restitution
        playerNode.physicsBody?.categoryBitMask = 1
        playerNode.physicsBody?.contactTestBitMask = 2 | 3  // holes and finish
        playerNode.physicsBody?.collisionBitMask = 2        // walls
        playerNode.zPosition = 1                            // in front of all nodes
        addChild(playerNode)
    }
    
    private func setupHolesRadius() { // make hole 2x smaller
        for node in self.children {
            if node.name == "holeNode" {
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.frame.size.width / 4)
                node.physicsBody?.isDynamic = false // default true
            }
        }
    }
    
    private func addSceneBackground() {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.zPosition = -1
        addChild(background)
    }
    
    private func endingGame() {
        self.playerNode.physicsBody?.isDynamic = false
        isGameOver = true
    }
    
    private func restartGame() {
        createPlayer()
        isGameOver = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        // the speed is proportional to the degree the device is turned
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -60, dy: accelerometerData.acceleration.x * 60)
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == playerNode {
            if let nodeB = contact.bodyB.node {
                playerContacted(with: nodeB)
            }
        } else if contact.bodyB.node == playerNode {
            if let nodeA = contact.bodyA.node {
                playerContacted(with: nodeA)
            }
        }
    }
    
    private func playerContacted(with node: SKNode) {
        if node.name == "holeNode" {
            holeContacted(position: node.position)
        } else if node.name == "finishNode" {
            finishContacted(position: node.position)
        } else { // wall contacted
            hapticFeedback.impactOccurred()
        }
    }
    
    private func holeContacted(position: CGPoint) {
        hapticNotification.notificationOccurred(.error)
        endingGame()
        // animating and removing falling ball (playerNode)
        playerNode.run(ballActionSequence(to: position)) { [unowned self] in
            restartGame()
        }
    }
    
    private func finishContacted(position: CGPoint) {
        hapticNotification.notificationOccurred(.error)
        endingGame()
        // animating and removing falling ball (playerNode)
        playerNode.run(ballActionSequence(to: position)) { [unowned self] in
            restartGame()
        }
    }
    
    private func ballActionSequence(to position: CGPoint) -> SKAction {
        let move = SKAction.move(to: position, duration: 0.2)
        let scale = SKAction.scale(to: 0.0001, duration: 0.24)
        let remove = SKAction.removeFromParent()
        return SKAction.sequence([move, scale, remove])
    }

}
