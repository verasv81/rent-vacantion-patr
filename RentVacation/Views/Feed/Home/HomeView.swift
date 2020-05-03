//
//  Modal.swift
//  RentVacation
//
//  Created by Vera Svet on 4/1/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    private let homePresenter = HomePresenter(feedService: FeedService())
    
    let titleTextField =  UITextField(frame: CGRect(x: 50, y: 100, width: 300, height: 40))
    let descriptionTextField =  UITextField(frame: CGRect(x: 50, y: 180, width: 300, height: 80))
    let imageUrlTextField =  UITextField(frame: CGRect(x: 50, y: 300, width: 300, height: 40))
    let cancelBtn = UIButton(frame: CGRect(x: 50, y:380, width: 80, height: 40))
    let saveBtn = UIButton(frame: CGRect(x: 150, y:380, width: 100, height: 40))
    
    override func viewDidLoad() {
        self.homePresenter.setViewDelegate(homeViewDelegate: self)
        
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
    
    func saveHome() {
        self.homePresenter.addHome(title: titleTextField.text!, description: descriptionTextField.text!, imageUrl: imageUrlTextField.text!)
    }
}

extension HomeViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

}
