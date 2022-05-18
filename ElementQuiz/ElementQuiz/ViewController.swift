//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Aluno02 on 28/04/22.
//  Copyright © 2022 Daniel Morais. All rights reserved.
//

import UIKit

enum State {
    case question
    case answer
    case score
}

enum Mode {
    case flashCard
    case quiz
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    // Estado específico de teste
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    let elementList = ["Carbono", "Ouro", "Cloro", "Sódio"]
    
    var state: State = .question
    var mode: Mode = .flashCard {
        didSet {
            updateUI()
        }
    }
    
    var currentElementIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    // Executa após o usuário pressionar a tecla Retrun no teclado
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        // Pega o texto do campo de texto
        let textFieldContents = textField.text!
        
        // Determinse se o usuário respondeu corretamente e atualiza o estado de teste.
        if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // O aplicativo agora deve mostrar a resposta ao usuário
        
        state = .answer
        
        updateUI()
        
        return true
    }
    
    
    // Atualiza a UI do app no modo ficha de estudo.
    func updateFlashCardUI(elementName: String){
        modeSelector.isHidden = false
        textField.isHidden = true
        textField.resignFirstResponder()
        
        if state == .answer {
            answerLabel.text = elementName
        } else {
            answerLabel.text = "?"
        }
    }
    
    // Atualiza a UI do app no modo teste.
    func updateQuizUI(elementName: String){
        modeSelector.selectedSegmentIndex = 1
        textField.isHidden = false
        
        switch state {
        case .question:
            answerLabel.text = ""
            textField.becomeFirstResponder()
            
        case .answer:
            textField.resignFirstResponder()
            if answerIsCorrect {
                answerLabel.text = "Correto!"
            } else {
                answerLabel.text = "❌"
            }
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
            answerLabel.text = ""
            displayScoreAlert()
        }
    }
    
    // Atualiza a UI do app com base no seu modo e estado.
    func updateUI(){
        let elementName = elementList[currentElementIndex]
        let image = UIImage(named: elementName)
        imageView.image = image
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(elementName: elementName)
        case .quiz:
            updateQuizUI(elementName: elementName)
        }
    }
    
    // Mostra um alerta no ios com a pontuação do usuario
    func displayScoreAlert(){
        let  alert = UIAlertController(title: "Quiz score", message: "Sua pontuação é \(correctAnswerCount) de \(elementList.count).", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    func scoreAlertDismissed(_ action: UIAlertAction){
        mode = .flashCard
    }
    
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count {
            currentElementIndex = 0
            if mode == .quiz{
                state = .score
                updateUI()
                return
            }
        }
        state = .question
        updateUI()
    }
    
}

