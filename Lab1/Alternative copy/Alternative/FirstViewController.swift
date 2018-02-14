//
//  FirstViewController.swift
//  Alternative
//
//  Created by Sheila Doherty on 2/2/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    let artistComponent = 0
    let songComponent = 1
    
    var artistSongs = [String: [String]]()
    var artists = [String]()
    var songs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pathURL = Bundle.main.url(forResource: "artistsongs", withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                artistSongs = try plistdecoder.decode([String:[String]].self, from: data)
                artists = Array(artistSongs.keys)
                songs = artistSongs[artists[0]]! as [String]
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent{
            return artists.count
        }else{
            return songs.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == artistComponent{
            let selectedArtist = artists[row]
            songs = artistSongs[selectedArtist]!
            musicPicker.reloadComponent(songComponent)
            musicPicker.selectRow(0, inComponent: songComponent, animated: true)
        }
        let artistrow = pickerView.selectedRow(inComponent: artistComponent)
        let songrow = pickerView.selectedRow(inComponent: songComponent)
        choiceLabel.text = "You like \(songs[songrow]) by \(artists[artistrow])"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent{
            return artists[row]
        }else{
            return songs[row]
        }
    }

}

