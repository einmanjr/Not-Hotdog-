//
//  ViewController.swift
//  SeeFood
//
//  Created by Michael Einman on 5/5/21.
//

import UIKit
import CoreML
import Vision
import AVFAudio
import SideMenu

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    var sideMenu: SideMenuNavigationController?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var centerLabel: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera //photoLibrary
        imagePicker.allowsEditing = true // true later
        topLabel.isHidden = true
        sideMenu = SideMenuNavigationController(rootViewController: LeftSideMenuController()) //Make Controller Class for MENULISTCONTROLLER
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not convert to CIImage")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage)  {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading coreML model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Could not process Image")
            }
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Congratulations! You have a Hotdog"
                    self.topLabel.isHidden = false
                    self.topLabel.text = "Hotdog"
                    self.centerLabel.isHidden = true
                    
                    
                    // SOUND
                    let pathToSound = Bundle.main.path(forResource: "Hotdog real", ofType: "m4a")!
                    let url = URL(fileURLWithPath: pathToSound)
                    
                    do{
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.audioPlayer?.play()
                    } catch {
                        print("Sound didn't work")
                    }
                    
                    
                } else {
                    self.navigationItem.title = "Sorry, You do not have a Hotdog"
                    self.topLabel.isHidden = false
                    self.topLabel.text = "Not Hotdog"
                    self.centerLabel.isHidden = true
                    
                    // SOUND
                    let pathToSound = Bundle.main.path(forResource: "Real Not Hotdog", ofType: "m4a")!
                    let url = URL(fileURLWithPath: pathToSound)
                    
                    do{
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        self.audioPlayer?.play()
                    } catch {
                        print("Sound didn't work")
                    }
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    

    //MARK: - SideMenu
    
    
    @IBAction func sideMenuTapped(_ sender: UIBarButtonItem) {
        present(sideMenu!, animated: true)
    }
    
    
    
    
    
}

