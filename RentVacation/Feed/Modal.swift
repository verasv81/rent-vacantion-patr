//
//  Modal.swift
//  RentVacation
//
//  Created by Vera Svet on 4/1/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import RxSwift

class ModalViewController: UIViewController {
    let titleTextField =  UITextField(frame: CGRect(x: 50, y: 100, width: 300, height: 40))
    let descriptionTextField =  UITextField(frame: CGRect(x: 50, y: 180, width: 300, height: 80))
    let imageUrlTextField =  UITextField(frame: CGRect(x: 50, y: 300, width: 300, height: 40))
    let cancelBtn = UIButton(frame: CGRect(x: 50, y:380, width: 80, height: 40))
    let saveBtn = UIButton(frame: CGRect(x: 150, y:380, width: 100, height: 40))
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.isOpaque = false
        
        titleTextField.placeholder = "Enter title here"
        titleTextField.font = UIFont.systemFont(ofSize: 15)
        titleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        titleTextField.autocorrectionType = UITextAutocorrectionType.no
        titleTextField.keyboardType = UIKeyboardType.default
        titleTextField.returnKeyType = UIReturnKeyType.done
        titleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        titleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        titleTextField.delegate = self
        self.view.addSubview(titleTextField)
        
        descriptionTextField.placeholder = "Enter description here"
        descriptionTextField.font = UIFont.systemFont(ofSize: 15)
        descriptionTextField.borderStyle = UITextField.BorderStyle.roundedRect
        descriptionTextField.autocorrectionType = UITextAutocorrectionType.no
        descriptionTextField.keyboardType = UIKeyboardType.default
        descriptionTextField.returnKeyType = UIReturnKeyType.done
        descriptionTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        descriptionTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        descriptionTextField.delegate = self
        self.view.addSubview(descriptionTextField)
        
        imageUrlTextField.placeholder = "Enter image url here"
        imageUrlTextField.font = UIFont.systemFont(ofSize: 15)
        imageUrlTextField.borderStyle = UITextField.BorderStyle.roundedRect
        imageUrlTextField.autocorrectionType = UITextAutocorrectionType.no
        imageUrlTextField.keyboardType = UIKeyboardType.default
        imageUrlTextField.returnKeyType = UIReturnKeyType.done
        imageUrlTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        imageUrlTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        imageUrlTextField.delegate = self
        self.view.addSubview(imageUrlTextField)
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.backgroundColor = UIColor.systemGray
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        self.view.addSubview(cancelBtn)
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.backgroundColor = UIColor.systemPink
        saveBtn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
        self.view.addSubview(saveBtn)
    }
    
    @objc func cancelBtnAction(sender: UIButton!) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func saveBtnAction(sender: UIButton!) {
        self.saveHome()
        self.dismiss(animated: false, completion: nil)
    }
    
    private func saveHome() {
        let request = RequestService()
        let home = Home(
            title: titleTextField.text!,
            description: descriptionTextField.text!,
            image: imageUrlTextField.text!)
        let subscription: Observable<Success> = request.post("http://localhost:4000/home", parameters: home).observeOn(MainScheduler.instance);
        let _ = subscription.subscribe {event in
            debugPrint(event)
        }

    }
}

extension ModalViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }

}
