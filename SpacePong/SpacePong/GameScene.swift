//
//  GameScene.swift
//  SpacePong
//
//  Created by Andrés Pizá Bückmann on 16/03/2019.
//  Copyright © 2019 Andrés Pizá Bückmann. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var lastTouch: CGPoint?
    private lazy var leftBar: SKNode = {
        guard let bar = childNode(withName: "LeftBar") else {
            fatalError("Failed to get left bar node")
        }
        return bar
    }()
    private lazy var rightBar: SKNode = {
        guard let bar = childNode(withName: "RightBar") else {
            fatalError("Failed to get right bar node")
        }
        return bar
    }()
    private lazy var explosion: SKNode = {
        guard let sprite = childNode(withName: "Explosion") else {
            fatalError("Failed to get explosion")
        }
        return sprite
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouch = touches.first?.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouch = touches.first?.location(in: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouch = nil
    }

    var topLimit: CGFloat {
        return size.height / 2
    }

    var bottomLimit: CGFloat {
        return -topLimit
    }

    override func update(_ currentTime: TimeInterval) {
        if let location = self.lastTouch {
            guard let bar = chooseBar(touch: location) else { return }
            guard bar.futureTopPosition(newLocation: location) < topLimit,
                bar.futureBottomPosition(newLocation: location) > bottomLimit else { return }

            bar.run(SKAction.moveTo(y: location.y, duration: 0.1))

            let explosionOffset: CGFloat = 20

            if bar.futureTopPosition(newLocation: location) + 10 >= topLimit {
                explosion.position = CGPoint(x: bar.position.x, y: bar.futureTopPosition(newLocation: location) - explosionOffset)
            } else if bar.futureBottomPosition(newLocation: location) - 10 < bottomLimit {
                explosion.position = CGPoint(x: bar.position.x, y: bar.futureBottomPosition(newLocation: location) + explosionOffset)
            } else {
                explosion.position = .zero
            }
        }
    }

    private func chooseBar(touch location: CGPoint) -> SKNode? {
        if location.x < size.width / 2 {
            return leftBar
        } else {
            return rightBar
        }
    }
}

extension SKNode {
    var topPosition: CGFloat {
        return position.y + frame.size.height / 2
    }

    var bottomPosition: CGFloat {
        return position.y - frame.size.height / 2
    }

    func futureTopPosition(newLocation location: CGPoint) -> CGFloat {
        return location.y + frame.size.height / 2
    }

    func futureBottomPosition(newLocation location: CGPoint) -> CGFloat {
        return location.y - frame.size.height / 2
    }
}
