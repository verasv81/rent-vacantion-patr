//
//  Account.swift
//  RentVacation
//
//  Created by Vera Svet on 4/1/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import RxSwift


class AccountViewController: UIViewController {
    let request = RequestService()
    var isLogged = false;
    let nameTextField = UITextField(frame: CGRect(x: 50, y:100, width: 200, height:40))
    let passwordTextField = UITextField(frame: CGRect(x: 50, y:180, width: 200, height:40))
    let signUpBtn = UIButton(frame: CGRect(x: 50, y: 260, width: 90, height: 40))
    let loginBtn = UIButton(frame: CGRect(x: 180, y: 260, width: 90, height: 40))
    let avatar = UIImage(named: "account.png")
    let nameLabel = UILabel(frame: CGRect(x: 180, y: 310, width: 80, height: 40))
    
    
    override func viewDidLoad() {
        if isLogged {
            self.singUp()
        } else {
            self.getUser()
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
        let home = User(name: nameTextField.text!, password: passwordTextField.text!)
        let subscription1: Observable<User> = request.post("http://localhost:4000/user", parameters: home).observeOn(MainScheduler.instance);
        let _ = subscription1.subscribe {event in
            switch event {
            case .next(let value):
                self.getUser(id: value._id)
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                self.isLogged = true
                
            }
        }
    }
    
    private func getUser(id: String? = "5e84fa631c9d440000e0a2c8") {
        self.clean()
        let basePath = "http://localhost:4000/user/" + id!;
        let url = URL(string: basePath)
        let urlRequest = URLRequest(url: url!);
        let subscription2: Observable<User> = request.get(urlRequest).observeOn(MainScheduler.instance);
        
        let _ = subscription2.subscribe{ event in
            switch event {
            case .next(let value):
                self.nameLabel.text = value.name
                self.nameLabel.font = UIFont.systemFont(ofSize: 25)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
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
        }
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
        self.isLogged = true;
    }
    
    private func login() {
        let home = User(name: nameTextField.text!, password: passwordTextField.text!)
        let subscription1: Observable<User> = request.post("http://localhost:4000/user/login", parameters: home).observeOn(MainScheduler.instance);
        let _ = subscription1.subscribe {event in
            switch event {
            case .next(let value):
                self.getUser(id: value._id)
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                self.isLogged = true
            }
        }
    }
    
    private func clean() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
    }
}



extension AccountViewController: UITextFieldDelegate {

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
