//
//  RouterViewController.swift
//  Routable
//
//  Created by zkhCreator on 7/24/16.
//  Copyright © 2016 zkhCreator. All rights reserved.
//

import UIKit

class RouterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    required init(nibName:String?,bundle:NSBundle?,dic:Dictionary<String,Any>) {
        super.init(nibName: nibName, bundle: bundle)
        print("super class init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
