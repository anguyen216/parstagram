//
//  cameraViewController.swift
//  parstagram
//
//  Created by Anh Nguyen on 3/19/21.
//

import UIKit
import AlamofireImage
import Parse

class cameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // customize commentField
        commentField.layer.borderWidth = 1
        commentField.layer.borderColor = UIColor.lightGray.cgColor
        commentField.layer.cornerRadius = 5
    }
    
    @IBAction func onSwipe(_ sender: Any) {
        commentField.endEditing(true)
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        // upon tap, open camera or show photo album
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            let alertController = UIAlertController(title: "Error", message: "Cannot open Camera App", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onLibraryButton(_ sender: Any) {
        // upon tap show photo album
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.sourceType = .photoLibrary
        } else {
            let alertController = UIAlertController(title: "Error", message: "Cannot open Photo Library", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
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
        // get/create object table
        // set values for each object
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        // get the image data
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        // submit the post
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                let alertController = UIAlertController(title: "Cannot Submit Post", message: "Error \(error?.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
                print("Error \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
