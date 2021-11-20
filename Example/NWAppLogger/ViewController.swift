//
//  ViewController.swift
//  NWAppLogger
//
//  Created by hlkim on 11/20/2021.
//  Copyright (c) 2021 hlkim. All rights reserved.
//

import UIKit
import NWAppLogger

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NWAppLogger.shared.initLogger(self, url: "https://log.vitality.aia.co.kr/depapi/AppLogRequest", isLog: false, userInfo: ["xtUid":"11111","ssId":"22222"] as Dictionary<String,AnyObject>)
        NWAppLogger.shared.start(self)
        let parmas = NWAppLogger.shared.sendLog(self, paramMap: ["ecId":333333] as Dictionary<String, AnyObject>)
        textView.text = parmas
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NWAppLogger.shared.resume(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

