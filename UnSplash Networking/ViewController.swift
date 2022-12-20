//
//  ViewController.swift
//  UnSplash Networking
//
//  Created by guhan-pt6208 on 15/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var generateButton: UIButton!
    
    let networkManager = NetworkNanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        networkManager.getMovie()
    }
    
    
    
    func configureButton() {
        self.generateButton.layer.cornerRadius = 4
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        displayImage()
        networkManager.uploadImage()
    }
    
    func displayImage() {
        networkManager.downlaodImage { [weak self] data, error in

            if let image = data {
                let downloadedImage = UIImage(data: image)
                self?.imageView.image = downloadedImage

                if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

                    let url = path.appendingPathComponent("another").appendingPathExtension("jpg")
                    do {
                        try downloadedImage?.pngData()?.write(to: url)
                        print("Image saved")
                    } catch {
                        print(error)
                    }
                }

            } else {
                print("Image not found")
            }
        }
    }
    
    
}
