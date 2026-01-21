//
//  GameScene.swift
//  gameNotes26New
//
//  Created by JOSHUA GATUNDU on 1/7/26.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var vc: GameViewController!
    var canJump = true
    var score = 0
    var ball: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    let cam = SKCameraNode()
    var coins = true
    var coin: SKSpriteNode!
    var winScreen: SKLabelNode!
    
    // gets called once as the scene loads
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        coin = self.childNode(withName: "coin") as? SKSpriteNode
        winScreen = self.childNode(withName: "endLabel") as? SKLabelNode
        
        self.camera = cam
        
        physicsWorld.contactDelegate = self
    }
    
    
    // gets called every FPS
    override func update(_ currentTime: TimeInterval) {
        // makes camera follow the ball
        cam.position.x = ball.position.x + 500
        ball.physicsBody?.velocity.dx = 400
        cam.position.y = ball.position.y + 100
        scoreLabel.position.x = ball.position.x + 300
        scoreLabel.position.y = ball.position.y + 300
        cam.setScale(1.5)
        
        if ball.position.y < -450{
            ball.position.y = 0
            ball.position.x = -400
            score = 0
            scoreLabel.text = "\(score)"
            coins = true
            coin.isHidden = false
        }
        
        if ball.position.x > 6400{
            winScreen.text = "You Win!"
        }
        
        print("\(ball.position.y)")
    }
    
    // gets clled when it hears a collision
    func didBegin(_ contact: SKPhysicsContact) {
        print("hit")
        if contact.bodyA.node?.name == "spike" && contact.bodyB.node?.name == "ball"{
         //   print("add 1 coin")
            respawn()
           // contact.bodyA.node?.removeFromParent()
          //  score+=1
          //  scoreLabel.text = "\(score)"
        }
        if contact.bodyB.node?.name == "spike" && contact.bodyA.node?.name == "ball"{
          //  print("add 1 coin")
            respawn()
           // contact.bodyB.node?.removeFromParent()
          //  score+=1
           // scoreLabel.text = "\(score)"

        }
        
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "ball"{
         //   print("add 1 coin")
            canJump = true
           // contact.bodyA.node?.removeFromParent()
          //  score+=1
          //  scoreLabel.text = "\(score)"
        }
        if contact.bodyB.node?.name == "ground" && contact.bodyA.node?.name == "ball"{
          //  print("add 1 coin")
            canJump = true
           // contact.bodyB.node?.removeFromParent()
          //  score+=1
           // scoreLabel.text = "\(score)"

        }
        
        if contact.bodyA.node?.name == "coin" && contact.bodyB.node?.name == "ball"{
         //   print("add 1 coin")
            coins = false
           // contact.bodyA.node?.removeFromParent()
            score+=1
            scoreLabel.text = "\(score)"
        }
        if contact.bodyB.node?.name == "coin" && contact.bodyA.node?.name == "ball"{
          //  print("add 1 coin")
            coins = false
           // contact.bodyB.node?.removeFromParent()
            score+=1
            scoreLabel.text = "\(score)"

        }
        if coins == false{
            coin.alpha = 0.0
            coin.isHidden = true
            coin.physicsBody?.categoryBitMask = 0
            coin.physicsBody?.contactTestBitMask = 0
            coin.physicsBody?.collisionBitMask = 0
            coin.physicsBody?.fieldBitMask = 0
        }
        if coins == true {
            coin.alpha = 1
            coin.physicsBody?.categoryBitMask = 1
            coin.physicsBody?.contactTestBitMask = 1
            coin.physicsBody?.collisionBitMask = 4294967295
            coin.physicsBody?.fieldBitMask = 4294967295

        }
        
       
        
        
        
        func respawn(){
            let start = SKAction.move(to: CGPoint(x: -400, y: 0), duration: 0)
            ball.run(start)
            score = 0
            scoreLabel.text = "\(score)"
            coins = true
            coin.isHidden = false
        }
    }
    
    
  
}
