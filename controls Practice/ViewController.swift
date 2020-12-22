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
    
    //var number: UInt8 = 128{ //U - беззнаковое число
    var number = 128{ // изменинли тип на обычный Int, т.к. теперь значение от 0 до 255 регулируется условиями в didSet
        //после установки значения
        willSet{
            
        }
        //до установки значения
        didSet{
//            if number < 0 {
//                number = 255
//            }else if 255 < number {
//                number = 0
//            }
            // if выше заменим таким выражением 
            number = (number + 256) % 256
            
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        rotateSwitches()
    }

    /// Updates all outlets to number
    func updateUI(){
        button.setTitle("\(number)", for: []) // [] - для всех состояний
        
        updateSwitches()
        slider.value = Float(number)
        textField.text = "\(number)"
    }
    
    func rotateSwitches(){
        for `switch` in switches { // `switch` - так как слово  switch занято средой
            `switch`.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1) // тут все в радианах .pi / 2 - поворот на 90 грудусов, если в ругую сторону крутить, то нужно через минус
        }
    }
    
    /// Update number from switches
    func updateNumberFromSwitches(){
        var number = 0
        for `switch` in switches{
            number += `switch`.isOn ? `switch`.tag : 0
        }
        //self.number = UInt8(number % 256) //  256 - это контроль от изменения тэгов таким образом, что сумма получится больше 256
        // изменили, т.к. number теперь Int  и преобразование не нужно
        self.number = number
    }
    
    /// Update  switches from number
    func updateSwitches(){
        for `switch` in switches{
            `switch`.isOn = Int(number) & `switch`.tag != 0 // & логическое И для побитового сложения. 50 урок
        }
    }
    
    @IBAction func buttonPressed() {
        //print(#line, #function)
        //number = UInt8((Int(number) + 1) % 256) // берем по модулю 256, что бы не выйти за границы типа Int8
        // теперь провреку перенесем в didSet переменной
        number += 1
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
//        print(#line, #function, sender.tag)
        updateNumberFromSwitches()
    }
    
    @IBAction func sliderMoved() {
        //print(#line, #function)
        number = Int(slider.value)
    }
    
    @IBAction func textFieldEdited() {
        //print(#line, #function)
        number = Int(textField.text ?? "") ?? 128 // text тут опциональное  ?? показывает,что если оно nil, то вернуть пустую строку
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        //print(#line, #function, sender.location(in: view))
        if location.x < view.bounds.midX{ //x меньше середины экрана
            number -= 1
        } else{
            number += 1
        }
    }
}

