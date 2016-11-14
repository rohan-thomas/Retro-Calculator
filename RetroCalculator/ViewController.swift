//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Rohan Thomas on 2016-10-16.
//  Copyright © 2016 Rohan Thomas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outletLbl: UILabel! //label for the the calculator's output screen
    
    var btnSound: AVAudioPlayer! //variable to store the button sound
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") //command to set the path of the btn.wav file
        let soundURL = URL(fileURLWithPath: path!) //sets the soundURL
        
        do { //setter and getter
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outletLbl.text = "0" //initializes the calculator to output zero
    }
    @IBAction func numPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)" //the running is concatenated with when sequential number buttons are pressed before an operator button is pressed
        outletLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }

    @IBAction func onClearPressed(sender: AnyObject){ //function to clear the screen
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        
        outletLbl.text = "0"
    }
    
    
    
    
    func playSound() {//function to play the sound when a button is clicked
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {//to make sure that there is a current operation
            if runningNumber != "" {//to make sure that the running number is not empty
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
            
                leftValStr = result //to ensure that consecutive operations after an equal operation are allowed
                outletLbl.text = result
            }
            
            currentOperation = operation
            
        }else
        {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        

    }
    


}

