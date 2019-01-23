//
//  ViewController.swift
//  PlanesDetection
//
//  Created by MacBook on 1/23/19.
//  Copyright © 2019 potato. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        sceneView.delegate = self
        sceneView.session.run(configuration, options: [])
    }
    
    func createPlane(planeAnchor: ARPlaneAnchor) -> SCNNode{
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "grid")
        
        plane.materials = [material]
        
        let planeNode = SCNNode(geometry: plane)
        //posicion del plano
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: planeAnchor.center.y, z: planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-(Float.pi/2), 1, 0, 0)
        
        return planeNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else{ return }
        
        let plane = createPlane(planeAnchor: planeAnchor)
        node.addChildNode(plane)
    }


}

