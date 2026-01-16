//
//  GameViewController.swift
//  gameNotes26New
//
//  Created by JOSHUA GATUNDU on 1/7/26.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene2: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        // forcing landscape mode
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene2 = scene as? GameScene
                scene2.vc = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    @IBAction func jump(_ sender: Any)
    {
    print("jump")
        if scene2.canJump == true {
            scene2.ball.physicsBody?.velocity.dy = 1000
            scene2.canJump = false
        }
    }
}
