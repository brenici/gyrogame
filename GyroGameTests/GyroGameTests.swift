//
//  GyroGameTests.swift
//  GyroGameTests
//
//  Created by Emilian Brenici on 02/10/2021.
//

import XCTest
import SpriteKit
@testable import GyroGame

class GyroGameTests: XCTestCase {

    var gameScene: GameScene!
    
    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        gameScene = GameScene()
        let testNode = SKSpriteNode(imageNamed: "ball")
        testNode.position = CGPoint(x: 455, y: -372)
        testNode.size = CGSize(width: 80, height: 80)
        gameScene.playerNode = testNode
    }

    override func tearDownWithError() throws {
        // This method is called after the invocation of each test method in the class.
        gameScene.removeFromParent()
    }

    func test_playerNode_is_nil() throws {
        let playerNode = gameScene.playerNode
        XCTAssertNil(playerNode)
    }
    
    func test_playerNode_is_not_nil() throws {
        let playerNode = gameScene.playerNode
        XCTAssertNotNil(playerNode)
    }
    
    func test_playerNode_position() throws {
        let playerNode = gameScene.playerNode
        XCTAssertEqual(455, playerNode?.position.x)
    }
    
    func test_playerNode_width() throws {
        let playerNode = gameScene.playerNode
        XCTAssertEqual(100, playerNode?.size.width)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
