//
//  ViewController.swift
//  FoodTracker
//
//  Created by NeppsStaff on 2021/05/08.
//  Copyright © 2021 NeppsStaff. All rights reserved.
//

import UIKit
import os.log

class MealDetailViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    //@IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    var meal: Meal?
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var RatingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        updateSaveButtonState()
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            RatingControl.rating = meal.rating
            
            updateSaveButtonState()
        }
    }
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        print("キャンセルボタンは押せてるよー")
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owingNavigationController = navigationController { owingNavigationController.popViewController(animated: true)
        } else {
            fatalError("キャンセルの処理に問題あり！")
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === SaveButton
        else {
            os_log("セーブボタンが押されませんでした。キャンセルします。", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = RatingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    /*   @IBAction func setDefaultLabelText(_ sender: Any) {
     mealNameLabel.text = "Default"
     }*/
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: UITextFieldDelete
    extension MealDetailViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
            
        }
        override func viewDidAppear(_ animated: Bool) {
            updateSaveButtonState()
        }
        
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            updateSaveButtonState()
            navigationItem.title = textField.text
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            SaveButton.isEnabled = false
        }
        
        private func updateSaveButtonState(){
            let text =  nameTextField.text ?? ""
            SaveButton.isEnabled = !text.isEmpty
            
        }
        
        
        //MARK: UITextFieldDelegate
        extension MealTableViewController: UITextFieldDelegate {
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                textField.resignFirstResponder()
                return true
            }
        }
        
        extension MealDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                dismiss(animated: true, completion: nil)
            }
            
            
            func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
                guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                    fatalError("fatalError: 画像を反映するときにエラー\(info)")
                }
                
                photoImageView.image = selectedImage
                
                dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    
}
