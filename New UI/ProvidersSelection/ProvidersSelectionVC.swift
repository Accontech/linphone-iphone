//
//  ProvidersSelectionVC.swift
//  Peeredge
//
//  Created by Karen Muradyan on 3/20/17.
//  Copyright © 2017 Peeredge. All rights reserved.
//

import UIKit

class ProvidersSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var providersList = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI ()
        setupDelegateMethods ()
        setupDataSource ()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI () {
        setupNextButton ()
        enableNextButton(enable: false)
    }
    
    func setupDelegateMethods () {
        setupTableViewDelegateMethods ()
    }
    
    func setupTableViewDelegateMethods () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNextButton () {
        nextButton.layer.cornerRadius = nextButton.frame.width / 2
    }
    
    func enableNextButton (enable:Bool) {
        
        if enable {
            nextButton.isEnabled = enable
            nextButton.backgroundColor = UIColor.init(red: 56.0/255.0, green: 197.0/255.0, blue: 250.0/255.0, alpha: 1)
        } else {
            nextButton.isEnabled = enable
            nextButton.backgroundColor = UIColor.init(red: 208.0/255.0, green: 211.0/255.0, blue: 224.0/255.0, alpha: 1)
        }
    }
    
    // MARK: - Setup Data source 
    
    func setupDataSource () {
        // TODO: Make API call to get providers list, providers should be an objects
        providersList = ["Globalgig", "Telmex", "Brasilfone", "BrightLink", "TSI Corp"]
    }

    // MARK: - UITableView delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = providersList[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.init(red: 56.0/255.0, green: 197.0/255.0, blue: 250.0/255.0, alpha: 1)
        enableNextButton(enable: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        let loginVC = UIStoryboard(name: "Login", bundle:nil).instantiateViewController(withIdentifier: "LoginTV") as! LoginTV
        loginVC.providerName = "Telmex"
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}
