//
//  ViewController.swift
//  Catch Angel
//
//  Created by Yusif Huseynov on 12/29/18.
//  Copyright © 2018 Yusif Huseynov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var melek1: UIImageView!
    @IBOutlet weak var melek2: UIImageView!
    @IBOutlet weak var melek3: UIImageView!
    @IBOutlet weak var melek4: UIImageView!
    @IBOutlet weak var melek5: UIImageView!
    @IBOutlet weak var melek6: UIImageView!
    @IBOutlet weak var melek7: UIImageView!
    @IBOutlet weak var melek8: UIImageView!
    @IBOutlet weak var melek9: UIImageView!
    @IBOutlet weak var highScorelabel: UILabel!
    
    var score = 0
    var timer = Timer()
    @objc var hidetimer = Timer()
    
    var counter = 30
    var melekArray = [UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        
        if highScore == nil {
            highScorelabel.text="0"
        }
        
        if let newScore = highScore as? Int{
            highScorelabel.text=String(newScore)
        }
        
        scoreLabel.text = "Score: \(score)"
        
        // Gesture Recognizer
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.IncreaseScore))
        
        
        melek1.isUserInteractionEnabled=true
        melek2.isUserInteractionEnabled=true
        melek3.isUserInteractionEnabled=true
        melek4.isUserInteractionEnabled=true
        melek5.isUserInteractionEnabled=true
        melek6.isUserInteractionEnabled=true
        melek7.isUserInteractionEnabled=true
        melek8.isUserInteractionEnabled=true
        melek9.isUserInteractionEnabled=true
        
        melek1.addGestureRecognizer(recognizer1)
        melek2.addGestureRecognizer(recognizer2)
        melek3.addGestureRecognizer(recognizer3)
        melek4.addGestureRecognizer(recognizer4)
        melek5.addGestureRecognizer(recognizer5)
        melek6.addGestureRecognizer(recognizer6)
        melek7.addGestureRecognizer(recognizer7)
        melek8.addGestureRecognizer(recognizer8)
        melek9.addGestureRecognizer(recognizer9)
        
        //timers
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMelek), userInfo: nil, repeats: true)
        
        
        //Arrays
        
        melekArray.append(melek1)
        melekArray.append(melek2)
        melekArray.append(melek3)
        melekArray.append(melek4)
        melekArray.append(melek5)
        melekArray.append(melek6)
        melekArray.append(melek7)
        melekArray.append(melek8)
        melekArray.append(melek9)
        
        hideMelek()
        
    }
    
    
    
    
    
    @objc func hideMelek(){
        
        for melek in melekArray{
            
            melek.isHidden = true
        
        }
        let random = Int(arc4random_uniform(8))
        
        melekArray[random].isHidden = false
        
    }
    
    
    @objc func IncreaseScore(){
        
        score+=1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    @objc func countDown(){
        
        counter-=1
        timeLabel.text=String(counter)
        
        if self.score>Int(highScorelabel.text!)!{
            
            UserDefaults.standard.set(self.score, forKey: "highScore")
            highScorelabel.text = String(self.score)
            
            
            
        }
        
        
        if counter == 0 {
            
            hidetimer.invalidate()
            timer.invalidate()
            
            for melek in melekArray{
                
                melek.isHidden = true
                
            }
            
            let alert = UIAlertController(title: "Game Over", message: "Time is up!", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
            self.hidetimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideMelek), userInfo: nil, repeats: true)
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }

    
    
    
    
    

}

