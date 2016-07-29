//
//  ViewController.swift
//  AVFoundationTakingPhotoDemo
//
//  Created by z on 16/7/29.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit
import AVFoundation
import CoreFoundation

class ViewController: UIViewController {

    @IBOutlet weak var captureImage: UIImageView!
    @IBOutlet weak var previewView: UIView!
    
    @IBOutlet weak var lineView: UIView!

    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewView.layer.addSublayer(previewLayer!)
                
                captureSession!.startRunning()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer!.frame = previewView.bounds
        addLine()
        
    }
    
    func addLine() {
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: (previewLayer?.frame.size.width)!/2.0, y: 0))
        path.addLine(to: CGPoint(x: (previewLayer?.frame.size.width)!/2.0, y: (previewLayer?.frame.size.height)!))
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = UIColor.white().cgColor
//        shapeLayer.fillColor = UIColor.orange().cgColor
        previewLayer?.addSublayer(shapeLayer)
//        lineView.layer.addSublayer(shapeLayer)
    
    }
    
    
    
    
    @IBAction func didPressTakePhoto(_ sender: AnyObject) {
        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo) {
            
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                if (sampleBuffer != nil) {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider(data: imageData!)
                    
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    self.captureImage.image = image
                }
            })
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
