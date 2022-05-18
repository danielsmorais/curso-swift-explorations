//
//  ViewController.swift
//  SistemaEscola
//
//  Created by Renan Trévia on 2/11/22.
//  Copyright © 2022 Eldorado. All rights reserved.
//

import UIKit

// Sugiro que utilizem esse Enum pois eu já deixei preparado para os botões, mas sintam-se à vontade para alterar para uma estrutura melhor caso sintam essa necessidade.
enum Cargo {
    case monitor, professor, coordenador, diretor, assistente
}
struct Colaborador{
    let nome: String
    let salario: Float
    let matricula: Int
    let cargo: Cargo
    
    func apresentacao()->String{
        return "Olá, meu nome é \(nome), minha matrícula é \(matricula) e meu cargo é \(cargo)."
    }
    func apresentacaoResumida() -> String {
        var abreviacao = ""
        switch cargo {

        case .monitor:
            abreviacao = "Mntr."
        case .professor:
            abreviacao = "Prof."
        case .coordenador:
            abreviacao = "Coord."
        case .diretor:
            abreviacao = "Dir."
        case .assistente:
            abreviacao = "Asst."
        }
        
        return "Olá, eu sou o \(abreviacao) \(nome)"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outputMessage: UILabel!
    
    @IBOutlet weak var matriculaTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var salarioTextField: UITextField!
    
    @IBOutlet weak var monitorButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    @IBOutlet weak var coordenadorButton: UIButton!
    @IBOutlet weak var diretorButton: UIButton!
    @IBOutlet weak var assistenteButton: UIButton!
    
    @IBOutlet weak var removeMatriculaTextField: UITextField!
    
    var cargoSelecionado: Cargo = .monitor
    var colaboradores = [Colaborador]()
    
    @IBAction func selecionaMonitor(_ sender: UIButton) {
        cargoSelecionado = .monitor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaProfessor(_ sender: UIButton) {
        cargoSelecionado = .professor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaCoordenador(_ sender: UIButton) {
        cargoSelecionado = .coordenador
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaDiretor(_ sender: UIButton) {
        cargoSelecionado = .diretor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaAssistente(_ sender: UIButton) {
        cargoSelecionado = .assistente
        selecionaBotao(botao: sender)
    }
    
    @IBAction func cadastrarColaborador(_ sender: UIButton) {
        var novoNome = ""
        var novaMatricula = 0
        var novoSalario: Float = 0.00
        var nomes = [String]()
        var matriculas = [Int]()
        
        if nomeTextField.text != "" {
            novoNome = nomeTextField.text ?? ""
        }
        if matriculaTextField.text != "" {
            let matricula = (matriculaTextField.text ?? "") as String
            novaMatricula = Int(matricula) ?? 0
        }
        if salarioTextField.text != "" {
            let salario = (salarioTextField.text ?? "") as String
            novoSalario = Float(salario) ?? 0.00
        }
        
        if novaMatricula == 0 || novoSalario == 0.00 || novoNome == "" {
            let alerta = UIAlertController(title: "Erro", message: "O cadastro do salário, matrícula ou nome está incompleto. Tente novamente.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        else {
            // Verificações dos desafios
            
            var hasMatricula: Bool = false
            var hasDiretor: Bool = false
            var hasSalario: Bool = false
            var hasCoordenador: Bool = false
            var nCoordenador = 0
            var nProfessor = 0
            
            var mensagem: String = ""
        
            for colaborador in colaboradores{
                if colaborador.matricula == Int(novaMatricula) {
                    hasMatricula = true
                    mensagem += "Esta matrícula já existe. "
                    break
                }
            }
            
            for colaborador in colaboradores{
                if colaborador.cargo == Cargo.diretor {
                    if novoSalario >= colaborador.salario {
                        hasSalario = true
                        mensagem += "Salário inválido. "
                    }
                    if cargoSelecionado == Cargo.diretor {
                        hasDiretor = true
                        mensagem += "A escola já possui diretor. "
                    }
                    break
                }
            }
            
            for colaborador in colaboradores{
                if colaborador.cargo == Cargo.coordenador {
                    nCoordenador += 1
                }else if colaborador.cargo == Cargo.professor {
                    nProfessor += 1
                }
            }
            
            if cargoSelecionado == Cargo.coordenador {
                if (nCoordenador + 1) > nProfessor {
                    hasCoordenador = true
                    mensagem += "A escola não pode ter mais coordenadores. "
                }
            }

            
            if hasMatricula || hasSalario || hasDiretor || hasCoordenador {
                let alerta = UIAlertController(title: "Erro", message: mensagem, preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                
            }else{
                let novoColaborador = Colaborador(nome: novoNome, salario: novoSalario, matricula: novaMatricula, cargo: cargoSelecionado)
                colaboradores.append(novoColaborador)
            }
        }
        
        for posicao in 0..<colaboradores.count{
            nomes.append(colaboradores[posicao].nome)
            matriculas.append(colaboradores[posicao].matricula)
        }
        
        outputMessage.text = ""
        
        for posicao in 0..<nomes.count{
            outputMessage.text! += "\(matriculas[posicao]): \(nomes[posicao])\n"
        }

        resetaCadastraColaborador()
    }
    
    @IBAction func removerColaborador(_ sender: UIButton) {
        let matricula = removeMatriculaTextField.text
        var novaMatricula = 0
        var nomes = [String]()
        var matriculas = [Int]()
        var posicaoRemovida = 0
        
        if matricula != ""{
            let matriculaConvertida = (matricula ?? "") as String
            novaMatricula = Int(matriculaConvertida) ?? 0
        }else{
            let alerta = UIAlertController(title: "Erro", message: "O número da matrícula é inválido. Tente novamente.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        
        for posicao in 0..<colaboradores.count{
            let colaboradorselecionado = colaboradores[posicao]
            if colaboradorselecionado.matricula == novaMatricula{
                posicaoRemovida = posicao
            }
        }
        
        colaboradores.remove(at: posicaoRemovida)
        
        for posicao in 0..<colaboradores.count{
            nomes.append(colaboradores[posicao].nome)
            matriculas.append(colaboradores[posicao].matricula)
        }
        
        outputMessage.text = ""
        
        for posicao in 0..<nomes.count{
            outputMessage.text! += "\(matriculas[posicao]): \(nomes[posicao])\n"
        }
        
        resetaRemoveColaborador()
    }
    
    @IBAction func listarGastosMensaisComTodosColaboradores(_ sender: UIButton) {
        var gastosMensais: Float = 0.00
        for posicao in 0..<colaboradores.count{
            gastosMensais += colaboradores[posicao].salario
        }
        
        outputMessage.text = "Os gastos mensais da empresa com todos os colaboradores foi de : R$ \(gastosMensais)"
    }
    
    @IBAction func listarGastosMensaisPorCargo(_ sender: UIButton) {
        var gastosDiretor: Float = 0.00
        var gastosMonitor: Float = 0.00
        var gastosProfessor: Float = 0.00
        var gastosAssistente: Float = 0.00
        var gastosCoordenador: Float = 0.00
        
        for posicao in 0..<colaboradores.count{
            let colaboradorDaVez = colaboradores[posicao]
            switch colaboradorDaVez.cargo {

            case .monitor:
                gastosMonitor += colaboradorDaVez.salario
            case .professor:
                gastosProfessor += colaboradorDaVez.salario
            case .coordenador:
                gastosCoordenador += colaboradorDaVez.salario
            case .diretor:
                gastosDiretor += colaboradorDaVez.salario
            case .assistente:
                gastosAssistente += colaboradorDaVez.salario
            }
        }
        
        let gastosTotais = [gastosDiretor, gastosCoordenador, gastosProfessor, gastosAssistente, gastosMonitor]
        let printCargos = ["Diretor: R$", "Coordenador: R$", "Professor: R$", "Assistente: R$", "Monitor: R$"]
        
        outputMessage.text = ""
        
        for posicao in 0..<gastosTotais.count{
            outputMessage.text! += "\(printCargos[posicao])\(gastosTotais[posicao])\n"
        }
    }
    
    @IBAction func listarQuantasPessoasExistemPorCargo(_ sender: UIButton) {
        var diretores = 0
        var monitores = 0
        var professores = 0
        var assistentes = 0
        var coordenadores = 0
        
        for posicao in 0..<colaboradores.count{
            let colaboradorDaVez = colaboradores[posicao]
            switch colaboradorDaVez.cargo {

            case .monitor:
                monitores += 1
            case .professor:
                professores += 1
            case .coordenador:
                coordenadores += 1
            case .diretor:
                diretores += 1
            case .assistente:
                assistentes += 1
            }
        }
        
        let equipe = [diretores, coordenadores, professores, assistentes, monitores]
        let printCargos = ["Diretor: ", "Coordenador: ", "Professor: ", "Assistente: ", "Monitor: "]
        
        outputMessage.text = ""
        
        for posicao in 0..<equipe.count{
            outputMessage.text! += "\(printCargos[posicao])\(equipe[posicao])\n"
        }
    }
    
    @IBAction func listarNomesColaboradoresOrdemAlfabetica(_ sender: UIButton) {
        var nomes = [String]()
        
        for posicao in 0..<colaboradores.count{
            nomes.append(colaboradores[posicao].nome)
        }
        
        nomes.sort()
        
        outputMessage.text = ""
        
        for posicao in 0..<nomes.count{
            outputMessage.text! += "\(nomes[posicao])\n"
        }
    }
    
    // -> A MATRICULA é uma propriedade única (ID), ou seja, não se repete (como um CPF).
    // -> O SALARIO pode conter qualquer valor (crise pra quem?), mas o maior salário deve ser sempre o do DIRETOR.
    // -> A ESCOLA não pode ter mais do que um DIRETOR.
    // -> A ESCOLA não pode ter mais COORDENADORES do que PROFESSORES.
    
}

