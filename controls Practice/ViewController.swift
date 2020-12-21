//
//  ViewController.swift
//  controls Practice
//
//  Created by Stas Borovtsov on 21.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    var number: UInt8 = 128{ //U - беззнаковое число
        didSet{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    /// Updates all outlets to number
    func updateUI(){
        button.setTitle("\(number)", for: []) // [] - для всех состояний
        
        // TODO: set switches to number
        slider.value = Float(number)
        textField.text = "\(number)"
    }
    
    @IBAction func buttonPressed() {
        //print(#line, #function)
        number = UInt8((Int(number) + 1) % 256) // берем по модулю 256б что бы не выйти за границы типа Int8
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        //print(#line, #function, sender.tag)
    }
    
    @IBAction func sliderMoved() {
        //print(#line, #function)
        number = UInt8(slider.value)
    }
    
    @IBAction func textFieldEdited() {
        //print(#line, #function)
        number = UInt8(textField.text ?? "") ?? 128 // text тут опциональное  ?? показывает,что если оно nil, то вернуть пустую строку
    }
}

