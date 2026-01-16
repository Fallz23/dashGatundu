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
    
    
    // gets called once as the scene loads
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        
        self.camera = cam
        
        physicsWorld.contactDelegate = self
    }
    
    
    // gets called every FPS
    override func update(_ currentTime: TimeInterval) {
        // makes camera follow the ball
        //cam.position = ball.position
        cam.position.x = ball.position.x + 500
        ball.physicsBody?.velocity.dx = 400
        cam.position.y = ball.position.y
        scoreLabel.position.x = ball.position.x
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
            
            contact.bodyA.node?.removeFromParent()
            score+=1
            scoreLabel.text = "\(score)"
        }
        if contact.bodyB.node?.name == "coin" && contact.bodyA.node?.name == "ball"{
          //  print("add 1 coin")
            contact.bodyB.node?.removeFromParent()
            score+=1
            scoreLabel.text = "\(score)"

        }
        
        
        
        func respawn(){
            let start = SKAction.move(to: CGPoint(x: -400, y: 0), duration: 0)
            ball.run(start)
        }
    }
    
    
  
}
