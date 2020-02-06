//
//  soundTableViewController.swift
//  Microphone
//
//  Created by Jennifer Mah on 2/3/20.
//  Copyright © 2020 Jennifer Mah. All rights reserved.
//

import UIKit
import Networking

class soundTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MakeApiCall()
    }

    func MakeApiCall(){
        var start = 0
        while (start<20){
            let network = Networking(baseURL: createURL(search: "dogs", page: "1"))
            network.get(""){
                result in switch (result){
                case.success(let data):
                    let dict = data.dictionaryBody
                    print(dict)
                case.failure(_):
                    print("Error")
                }
                
            }
            start = start+1
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
