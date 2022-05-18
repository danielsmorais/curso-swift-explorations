//
//  ViewController.swift
//  mememaker
//
//  Created by Daniel Morais on 19/04/22.
//  Copyright © 2022 Daniel Morais. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    // inserir as frases e emojis
    
    let 👀 = CaptionOption(emoji: "👀", caption: "Tá vendo isso?")
    let 😳 = CaptionOption(emoji: "😳", caption: "Qual a necessidade disso?")
    let 🤭 = CaptionOption(emoji: "🤭", caption: "Não sou capaz de opinar")
    
    let 🥱 = CaptionOption(emoji: "🥱", caption: "Vou dormir.")
    let 😸 = CaptionOption(emoji: "😸", caption: "Miau miau.")
    let 👻 = CaptionOption(emoji: "👻", caption: "Perdi uma vida.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSegmentedControl.removeAllSegments()
        bottomSegmentedControl.removeAllSegments()
        
        topSegmentedControl.selectedSegmentIndex = 0
        bottomSegmentedControl.selectedSegmentIndex = 0
        
        let topChoices = [👀, 😳, 🤭]
        let bottomChoices = [🥱, 😸, 👻]
        
        insertSegments(choices: topChoices, control: topSegmentedControl)
        insertSegments(choices: bottomChoices, control:bottomSegmentedControl)
        
    }
    
    func insertSegments(choices: [CaptionOption], control: UISegmentedControl){
        for choice in choices{
            control.insertSegment(withTitle: choice.emoji, at: choices.count, animated: false)
        }
    }
    
    @IBAction func actionSegmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.titleForSegment(at: sender.selectedSegmentIndex) {
        case "👀":
            topCaptionLabel.text = 👀.caption
        case "😳":
            topCaptionLabel.text = 😳.caption
        case "🤭":
            topCaptionLabel.text = 🤭.caption
        case "🥱":
            bottomCaptionLabel.text = 🥱.caption
        case "😸":
            bottomCaptionLabel.text = 😸.caption
        case "👻":
            bottomCaptionLabel.text = 👻.caption
        default:
            fatalError()
        }
    }
    
    @IBAction func dragTopLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed{
            topCaptionLabel.center = sender.location(in: view)
        }
    }
    
    @IBAction func dragBottomLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed{
            bottomCaptionLabel.center = sender.location(in: view)
        }
    }
}

