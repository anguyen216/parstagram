//
//  cameraViewController.swift
//  parstagram
//
//  Created by Anh Nguyen on 3/19/21.
//

import UIKit
import AlamofireImage

class cameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // customize commentField
        commentField.layer.borderWidth = 1
        commentField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        // upon tap, open camera or show photo album
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
