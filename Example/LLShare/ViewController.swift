//
//  ViewController.swift
//  LLShare
//
//  Created by Ruris on 08/29/2023.
//  Copyright (c) 2023 Ruris. All rights reserved.
//

import UIKit
import LLShare

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        Task {
            do {
                let success = try await LLShare.share(self, fileName: "abc", extenName: "txt", text: "666")
                print(success)
            } catch {
                print(error)
            }
        }
    }
}

