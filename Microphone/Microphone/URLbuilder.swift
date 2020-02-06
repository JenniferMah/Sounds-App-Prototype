//
//  URLbuilder.swift
//  Microphone
//
//  Created by Jennifer Mah on 2/3/20.
//  Copyright © 2020 Jennifer Mah. All rights reserved.
//

import Foundation

func createURL(search:String, page:String) -> String {
    let url = "https://freesound.org/apiv2/search/text/?query=" + search + "&page=" + page + "&token=L4bKom5YT2k8DfabolQKJ3duTAkFDIzTuZWnUzpC"
    return url
}

