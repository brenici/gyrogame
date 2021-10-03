//
//  GyroGameTests.swift
//  GyroGameTests
//
//  Created by Emilian Brenici on 02/10/2021.
//

import XCTest
@testable import GyroGame

class GyroGameTests: XCTestCase {

    var gameScene: GameScene!
    
    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        gameScene = GameScene()
    }

    override func tearDownWithError() throws {
        // This method is called after the invocation of each test method in the class.
        gameScene.removeFromParent()
    }

    func test_playerNode_is_nil() throws {
        // This is an example of a functional test case.
        let playerNode = gameScene.playerNode
        XCTAssertNil(playerNode)
    }
    
    func test_playerNode_is_not_nil() throws {
        // This is an example of a functional test case.
        let playerNode = gameScene.playerNode
        XCTAssertNotNil(playerNode)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
