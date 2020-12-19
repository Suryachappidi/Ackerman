//
//  ViewController.swift
//  ARSiri
//
//  Created by Surya Chappidi on 10/12/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            configuration.trackingImages = imagesToTrack
            
            configuration.maximumNumberOfTrackedImages = 1
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        guard let imageName = imageAnchor.name else {
            return nil
        }
        
        if imageName == "paper" {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,height: imageAnchor.referenceImage.physicalSize.height)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            createHostingController(for: planeNode)
            
            node.addChildNode(planeNode)
        return node
        }else{
            return nil
        }
    }
    func createHostingController(for node: SCNNode) {
       
        let arVC = UIHostingController(rootView: MainView())
        
       
        DispatchQueue.main.async {
            arVC.willMove(toParent: self)
           
            self.addChild(arVC)
            
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        
            self.view.addSubview(arVC.view)
        
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<MainView>, on node: SCNNode) {
       
        let material = SCNMaterial()
        
        
        hostingVC.view.isOpaque = false
        
        material.diffuse.contents = hostingVC.view
    
        node.geometry?.materials = [material]
        
        hostingVC.view.backgroundColor = UIColor.clear
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
