//
//  FullSizeImageViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

class FullSizeImageViewController: UIViewController {
    
    var fullSizeImage: String?
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationButtons()
        loadImage()
    }
    
    private func setUpNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save image", style: .done, target: self, action: #selector(saveImageAction))
    }
    
    private func loadImage() {
        if let image = fullSizeImage, let url = URL(string: image) {
            imageView.load(url: url)
        }
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveImageAction() {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            dismissAction()
        }
        
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Unable to save image with error: \(error.localizedDescription)")
        }
        dismissAction()
    }
}
