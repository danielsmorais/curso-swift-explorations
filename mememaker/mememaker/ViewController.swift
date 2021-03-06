//
//  ViewController.swift
//  mememaker
//
//  Created by Daniel Morais on 19/04/22.
//  Copyright ยฉ 2022 Daniel Morais. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    // inserir as frases e emojis
    
    let ๐ = CaptionOption(emoji: "๐", caption: "Tรก vendo isso?")
    let ๐ณ = CaptionOption(emoji: "๐ณ", caption: "Qual a necessidade disso?")
    let ๐คญ = CaptionOption(emoji: "๐คญ", caption: "Nรฃo sou capaz de opinar")
    
    let ๐ฅฑ = CaptionOption(emoji: "๐ฅฑ", caption: "Vou dormir.")
    let ๐ธ = CaptionOption(emoji: "๐ธ", caption: "Miau miau.")
    let ๐ป = CaptionOption(emoji: "๐ป", caption: "Perdi uma vida.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSegmentedControl.removeAllSegments()
        bottomSegmentedControl.removeAllSegments()
        
        topSegmentedControl.selectedSegmentIndex = 0
        bottomSegmentedControl.selectedSegmentIndex = 0
        
        let topChoices = [๐, ๐ณ, ๐คญ]
        let bottomChoices = [๐ฅฑ, ๐ธ, ๐ป]
        
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
        case "๐":
            topCaptionLabel.text = ๐.caption
        case "๐ณ":
            topCaptionLabel.text = ๐ณ.caption
        case "๐คญ":
            topCaptionLabel.text = ๐คญ.caption
        case "๐ฅฑ":
            bottomCaptionLabel.text = ๐ฅฑ.caption
        case "๐ธ":
            bottomCaptionLabel.text = ๐ธ.caption
        case "๐ป":
            bottomCaptionLabel.text = ๐ป.caption
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

