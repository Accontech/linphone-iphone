//
//  LoginTV.swift
//  Peeredge
//
//  Created by Karen Muradyan on 3/20/17.
//  Copyright © 2017 Globalgig. All rights reserved.
//

import UIKit

class LoginTV: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var providerImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveCredentialsSwitch: UISwitch!
    fileprivate var nexTag = 0
    
    var providerName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        emailTextField.text = "7005"
        passwordTextField.text = "46Labs4321"
    }
    
    func setupUI () {
        setGuestures ()
        addDelegateMethods ()
        setupSwitchUI ()
    }
    
    func setGuestures () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector (dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addDelegateMethods () {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setupSwitchUI () {
        let onColor  = UIColor.init(red: 56.0/255.0, green: 197.0/255.0, blue: 250.0/255.0, alpha: 1)
        let offColor = UIColor.init(red: 150.0/255.0, green: 161.0/255.0, blue: 173.0/255.0, alpha: 1)
        saveCredentialsSwitch.onTintColor = onColor
        saveCredentialsSwitch.tintColor = offColor
        saveCredentialsSwitch.layer.cornerRadius = 16
        saveCredentialsSwitch.backgroundColor = offColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    @IBAction func backButtonAction(_ sender: Any) {
        _=self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        
//        RegisterService *registerService = [RegisterService getInstance];
//        registerService.loginModel = loginModel;
        
        let userModel = UserModel.init(dictionary: ["first_name" : emailTextField.text!,
                                                    "provider_name" : providerName,
                                                    "login_password" : passwordTextField.text!] )
        let registerService = RegisterService.getInstance()
        registerService?.userModel = userModel
        
        Thread.detachNewThreadSelector(#selector(RegisterService.registerToSipServerAndDoAgentLogin), toTarget: registerService, with: nil)
        
        let logOutVC = UIStoryboard(name: "LogOut", bundle:nil).instantiateViewController(withIdentifier: "LogOutVC") as! LogOutVC
        self.navigationController?.pushViewController(logOutVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nexTag = textField.tag + 1
        if nexTag > 114 {
            textField.resignFirstResponder()
        } else {
            (self.view.viewWithTag(nexTag) as! UITextField).becomeFirstResponder()
        }
        
        return false
    }

}
