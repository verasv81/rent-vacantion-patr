//
//  Account.swift
//  RentVacation
//
//  Created by Vera Svet on 4/1/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import RxSwift


class AccountViewController: UIViewController, AccountViewDelegate {
    private let accountPresenter = AccountPresenter(userService: UserService())
    
    var isLogged = false;
    let nameTextField = UITextField(frame: CGRect(x: 50, y:100, width: 200, height:40))
    let passwordTextField = UITextField(frame: CGRect(x: 50, y:180, width: 200, height:40))
    let signUpBtn = UIButton(frame: CGRect(x: 50, y: 260, width: 90, height: 40))
    let loginBtn = UIButton(frame: CGRect(x: 180, y: 260, width: 90, height: 40))
    let avatar = UIImage(named: "account.png")
    let nameLabel = UILabel(frame: CGRect(x: 180, y: 310, width: 80, height: 40))
    
    
    override func viewDidLoad() {
        self.accountPresenter.setViewDelegate(accountViewDelegate: self)
        
        if isLogged {
            self.singUp()
        } else {
            self.login()
        }
    }
    
    private func singUp() {
        nameTextField.placeholder = "Enter name here"
        nameTextField.font = UIFont.systemFont(ofSize: 15)
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)
        
        passwordTextField.placeholder = "Enter password here"
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        
        signUpBtn.setTitle("Register", for: .normal)
        signUpBtn.backgroundColor = UIColor.systemGray
        signUpBtn.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        self.view.addSubview(signUpBtn)
        
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = UIColor.systemPink
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginBtn)
    }
    
    @objc func signUpAction(sender: UIButton!){
        self.clean()
        self.accountPresenter.signup(name: nameTextField.text!, password: passwordTextField.text!)
    }
    
    func displayUser(name: (String)) {
        self.clean()
        self.nameLabel.text = name
        self.nameLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.nameLabel)
        let avatarImage = UIImageView(frame: CGRect(x: 110, y: 100, width: 200, height: 200))
        avatarImage.image = self.avatar
        self.view.addSubview(avatarImage)
        let welcomeMessage = UILabel(frame: CGRect(x: 40, y: 380, width: 300, height: 200))
        welcomeMessage.numberOfLines = 10
        welcomeMessage.text = "Welcome to our awsome app, this app will help you to rent home, blablabla"
        self.view.addSubview(welcomeMessage)
        let logOutBtn = UIButton(frame: CGRect(x: 130, y:520, width: 90, height: 40))
        logOutBtn.setTitle("Logout", for: .normal)
        logOutBtn.backgroundColor = UIColor.systemGray
        logOutBtn.addTarget(self, action: #selector(self.logOutAction), for: .touchUpInside)
        self.view.addSubview(logOutBtn)
    }
    
    @objc func logOutAction(sender: UIButton!) {
        self.clean()
        self.singUp()
        self.nameTextField.text = ""
        self.passwordTextField.text = ""
        self.isLogged = false;
    }
    
    @objc func loginAction(sender: UIButton!) {
        self.clean()
        self.login()
        self.isLogged = true
    }
    
    private func login() {
        self.clean()
        self.accountPresenter.login(name: nameTextField.text!, password: passwordTextField.text!)
        self.isLogged = true
    }
    
    private func clean() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
    }
}



extension AccountViewController: UITextFieldDelegate {
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
