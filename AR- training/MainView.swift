//
//  MainView.swift
//  AR- training
//
//  Created by Tom on 02/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import ARKit

class MainView: UIViewController {

    @IBOutlet weak var screenView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var iterator = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.screenView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.screenView.session.run(configuration)
        self.screenView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddButton(_ sender: Any) {
        let node = SCNNode()
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
        //cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        //let path = UIBezierPath()
       /* path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0.0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
         */
        //node.geometry = selectFromTable(i: iterator)
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        let randomPositonX = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let randomPositonY = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let randomPositonZ = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //node.position = SCNVector3(randomPositonX,randomPositonY,randomPositonZ)
        node.position = SCNVector3(0.2, 0.3, -0.2)
        node.eulerAngles = SCNVector3(CGFloat(-180.degreesToRadians),0,0)
        //cylinderNode.position = SCNVector3(-0.3, 0.2, -0.3)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.05001)
        
        self.screenView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
    }
    @IBAction func Reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.screenView.session.pause()
        self.screenView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        self.screenView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    

    
   /* func selectFromTable(i: Int){
        var ArrayOfNode = (SCNPyramid(width: 0.1, height: 0.1, length: 0.1),
                           SCNPlane(width: 0.2, height: 0.2),
                           SCNPlane(width: 0.2, height: 0.2),
                           SCNTorus(ringRadius: 0.1, pipeRadius: 0.1),
                           SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.1),
                           SCNSphere(radius: 0.3),
                           SCNCylinder(radius: 0.1, height: 0.01),
                           SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3),
                           SCNCapsule(capRadius: 0.1, height: 0.3),
                           SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        )
        
        return ArrayOfNode[i]
    }*/

}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180 }
    
}
