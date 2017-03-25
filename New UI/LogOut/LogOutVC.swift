//
//  LogOutVC.swift
//  Peeredge
//
//  Created by Karen Muradyan on 3/20/17.
//  Copyright © 2017 Peeredge. All rights reserved.
//

import UIKit

class LogOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        _=self.navigationController?.popToRootViewController(animated: false)
    }

}
