//
//  TravelViewController.swift
//  TravelCollector
//
//  Created by Matt Walter on 9/30/16.
//  Copyright © 2016 Matt Walter. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var travelImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var travel : Travel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if travel != nil {
           travelImageView.image = UIImage(data: travel!.image as! Data)
            titleTextField.text = travel!.title
            
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        travelImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addTapped(_ sender: AnyObject) {
        
        if travel != nil {
            travel!.title = titleTextField.text
            travel!.image = UIImagePNGRepresentation(travelImageView.image!) as NSData?

        }else {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let travel = Travel(context: context)
                travel.title = titleTextField.text
                travel.image = UIImagePNGRepresentation(travelImageView.image!) as NSData?
            }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
context.delete(travel!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)

    }
}
