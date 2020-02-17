//
//  soundTableViewController.swift
//  Microphone
//
//  Created by Jennifer Mah on 2/3/20.
//  Copyright © 2020 Jennifer Mah. All rights reserved.
//

import UIKit
import Networking
import AVFoundation
import AVKit


class soundTableViewController: UIViewController {
    var player: AVPlayer!
    var SoundNamesArray = [String]()
    var SoundURLArray = [String]()
    let sampleTextField =  UITextField(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    let SubmitButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
    let PlayButton = UIButton(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
    let PauseButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 50))

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        sampleTextField.placeholder = "Enter Sound"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(sampleTextField)
        
        //Submit button
        SubmitButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        SubmitButton.setTitle("Submit", for: .normal)
        SubmitButton.addTarget(self, action: #selector(Submit), for: .touchUpInside)
        self.view.addSubview(SubmitButton)

        //Play sounds
        PlayButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        PlayButton.setTitle("Play", for: .normal)
        PlayButton.addTarget(self, action: #selector(playSounds), for: .touchUpInside)
        self.view.addSubview(PlayButton)
        
        //pause sounds
        PauseButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        PauseButton.setTitle("Pause Audio", for: .normal)
        PauseButton.addTarget(self, action: #selector(pauseSound), for: .touchUpInside)
        self.view.addSubview(PauseButton)
    }
    
    @objc func Submit(){
        let search = sampleTextField.text!
        MakeApiCall(SearchItem: search)
        SubmitButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        SubmitButton.setTitle("Submitted", for: .normal)
        PlayButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        PlayButton.setTitle("Play", for: .normal)
        PauseButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
               PauseButton.setTitle("Pause Audio", for: .normal)

    }

    func CreateSounds(SoundURL:String){
        let url = URL.init(string:SoundURL)
        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
    }
    
    @objc func playSounds(){
        SubmitButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        SubmitButton.setTitle("Submit", for: .normal)
        self.CreateSounds(SoundURL: self.SoundURLArray[1]) // takes some time to make whole API call
        print(self.SoundURLArray[0])
        PlayButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        PlayButton.setTitle("Playing Sound", for: .normal)
        player.play()
    }
    
    @objc func pauseSound(){
        PlayButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        PlayButton.setTitle("Play", for: .normal)
        PauseButton.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        PauseButton.setTitle("Pausing Audio", for: .normal)
        
        player.pause()
    }
    
//   MARK: cannot search anything with spaces in the search string
    func MakeApiCall(SearchItem:String){
        self.SoundURLArray.removeAll()
        let network = Networking(baseURL: createURL(search: SearchItem, page: "1"))
        network.headerFields = ["Authorization": "Token L4bKom5YT2k8DfabolQKJ3duTAkFDIzTuZWnUzpC"]
        network.get(""){
            result in switch (result){
            case.success(let data):
                let json = data.dictionaryBody
                let results = json["results"] as! NSArray
                //traversing results
                for i in results{
                    let SoundData = i as! NSDictionary //dictionary for all of our sounds in API call
                    let SoundsName = SoundData.value(forKey: "name") as! String // name of sound
                    self.SoundNamesArray.append(SoundsName)
                    let previews = SoundData.value(forKey: "previews") as! NSDictionary //dictionary of previews
                    let MP3url = previews.value(forKey: "preview-lq-mp3") as! String // get the preview low quality
                    self.SoundURLArray.append(MP3url)
                   
                }
            case.failure(_):
                print("Error")
            }
            
        }
        
    }

}
