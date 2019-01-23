//
//  ViewController.swift
//  MyFirstARapp
//
//  Created by MacBook on 1/18/19.
//  Copyright © 2019 potato. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.debugOptions = .showWorldOrigin
        sceneView.session.run(configuration, options: [])
        
        //let mySphere = createSphere(radius: 0.35)
        //mySphere.position = SCNVector3(x: 0, y: 0, z: -0.4)
        
        //MARK: Creamos los planetas
        let sun = createPlanet(radius: 1.50, texture: "sol")
        let mercury = createPlanet(radius: 0.05, texture: "mercurio")
        let venus = createPlanet(radius: 0.10, texture: "venus")
        let earth = createPlanet(radius: 0.15, texture: "tierra2")
        let mars = createPlanet(radius: 0.09, texture: "marte")
        let jupiter = createPlanet(radius: 0.50, texture: "jupiter")
        let saturn = createPlanet(radius: 0.45, texture: "saturno")
        let saturnRings = createSaturnRing(radiusExt: 0.80, radiusInt: 0.46, texture: "saturnmap")
        let uranus = createPlanet(radius: 0.40, texture: "urano")
        let neptune = createPlanet(radius: 0.38, texture: "neptuno")
       
        //MARK: Colocamos su posicion y los agregamos a la escena
        sun.position = SCNVector3(x: 0, y: 0, z: -7)
        sceneView.scene.rootNode.addChildNode(sun)
        
        mercury.position = SCNVector3(x: 0, y: 0, z: -4)
        sceneView.scene.rootNode.addChildNode(mercury)
        
        venus.position = SCNVector3(x: 0, y: 0, z: -2)
        sceneView.scene.rootNode.addChildNode(venus)
        
        earth.position = SCNVector3(x: 0, y: 0, z: 0)
        sceneView.scene.rootNode.addChildNode(earth)
        
        mars.position = SCNVector3(x: 0, y: 0, z: 1)
        sceneView.scene.rootNode.addChildNode(mars)
        
        jupiter.position = SCNVector3(x: 0, y: 0, z: 2)
        sceneView.scene.rootNode.addChildNode(jupiter)
        
        saturn.position = SCNVector3(x: 0, y: 0, z: 3.5)
        sceneView.scene.rootNode.addChildNode(saturn)
        saturnRings.position = SCNVector3(x: 0, y: 0, z: 3.5)
        sceneView.scene.rootNode.addChildNode(saturnRings)
        
        uranus.position = SCNVector3(x: 0, y: 0, z: 4.5)
        sceneView.scene.rootNode.addChildNode(uranus)
        
        neptune.position = SCNVector3(x: 0, y: 0, z: 5.6)
        sceneView.scene.rootNode.addChildNode(neptune)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(tapGesture)
       
        /* let text = createARText(text: "ARKit en el lab iOS")
        text.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(text)*/
    }
    
    @objc func tapped (recognizer: UIGestureRecognizer){
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: nil)
        
        if let hitResult = hitResults.first{
            let node = hitResult.node
            if node.name == "planet"{
                node.geometry?.material(named: "planetTexture")?.diffuse.contents = UIImage(named: "sol")
                node.physicsBody?.applyForce(SCNVector3(x: 0, y: -1, z: 0), asImpulse: true)
            }
        }
    }

    //MARK: Funcion para crear los planetas
    func createPlanet(radius: CGFloat, texture: String) -> SCNNode{
        let sphere = SCNSphere(radius: radius)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: texture)
        material.name = "planetTexture"
        sphere.materials = [material]
        
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.name = "planet"
        sphereNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: sphere, options: nil))
        
        sphereNode.physicsBody?.isAffectedByGravity = false
        
        return sphereNode
    }
    
    func createSaturnRing(radiusExt: CGFloat, radiusInt:CGFloat, texture: String) -> SCNNode{
        let ring = SCNTube(innerRadius: radiusInt, outerRadius: radiusExt, height: 0.01)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: texture)
        ring.materials = [material]
        
        let ringNode = SCNNode(geometry: ring)
        
        return ringNode
    }
    
    func createARText(text: String) -> SCNNode{
        let text = SCNText(string: text, extrusionDepth: 1.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.0)
        
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        
        return textNode
    }
    

}

