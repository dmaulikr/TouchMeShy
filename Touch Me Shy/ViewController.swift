//
//  ViewController.swift
//  Touch Me Shy
//
//  Created by Md. Azizur Rahman on 4/20/17.
//  Copyright © 2017 RATouchSTUDIO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // all components.
    @IBOutlet weak var timeCountingLabel: UILabel!
    @IBOutlet weak var currentScoreCuntingLabel: UILabel!
    @IBOutlet weak var levelCountingLable: UILabel!
    
    
    @IBOutlet weak var animalOne: UIImageView!
    @IBOutlet weak var animalTwo: UIImageView!
    @IBOutlet weak var animalThree: UIImageView!
    @IBOutlet weak var animalFour: UIImageView!
    @IBOutlet weak var animalFive: UIImageView!
    @IBOutlet weak var animalSix: UIImageView!
    @IBOutlet weak var animalSeven: UIImageView!
    @IBOutlet weak var animalEight: UIImageView!
    @IBOutlet weak var animalNine: UIImageView!
    
    
    @IBOutlet weak var higestScoreLabel: UILabel!
    
    @IBOutlet weak var higestLevelLabel: UILabel!
    
    
    var scores = 0
    var levelName = ""
    var level = 1
    var highestLevel = 0
    var gameDuration = Timer()
    var timeCounter = 30
    var animals = [UIImageView]()
    var hideDuration = Timer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add all components.
        
        // check high score.
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        if highScore == nil {
            higestScoreLabel.text = "0"
        } else if let newHighScore = highScore as? Int {
            higestScoreLabel.text = "\(newHighScore)"
        }
        
        // check high level.
        let highLevel = UserDefaults.standard.object(forKey: "highLevel")
        if highLevel == nil {
            higestLevelLabel.text = "Easy"
        } else if let newHighLevel = highLevel as? Int {
            if newHighLevel == 1 {
                higestLevelLabel.text = "Easy"
            } else if newHighLevel == 2 {
                higestLevelLabel.text = "Medium"
            } else if newHighLevel == 3 {
                higestLevelLabel.text = "Hard"
            }
        }
        
        currentScoreCuntingLabel.text = "\(scores)"
        
        levelCountingLable.text = "Easy"
        
        // create gester recognizer to get image recognize.
        let recognizerOne = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerTwo = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerThree = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerFour = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerFive = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerSix = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerSeven = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerEight = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        let recognizerNine = UITapGestureRecognizer(target: self, action: #selector(ViewController.increseScore))
        
        // add gester recognizer to image.
        animalOne.addGestureRecognizer(recognizerOne)
        animalTwo.addGestureRecognizer(recognizerTwo)
        animalThree.addGestureRecognizer(recognizerThree)
        animalFour.addGestureRecognizer(recognizerFour)
        animalFive.addGestureRecognizer(recognizerFive)
        animalSix.addGestureRecognizer(recognizerSix)
        animalSeven.addGestureRecognizer(recognizerSeven)
        animalEight.addGestureRecognizer(recognizerEight)
        animalNine.addGestureRecognizer(recognizerNine)
        
        // add all image to an array.
        animals.append(animalOne)
        animals.append(animalTwo)
        animals.append(animalThree)
        animals.append(animalFour)
        animals.append(animalFive)
        animals.append(animalSix)
        animals.append(animalSeven)
        animals.append(animalEight)
        animals.append(animalNine)
        
    }
    
    
    // Create components.
    
    // increse score.
    func increseScore() {
        scores += 1
        currentScoreCuntingLabel.text = "\(scores)"
        
        
        if Int(currentScoreCuntingLabel.text!)! < 50 {
            level = 1
            highestLevel = 1
            levelName = "Easy"
            levelCountingLable.text = "\(levelName)"
        }
        
        if Int(currentScoreCuntingLabel.text!)! >= 50 {
            level = 2
            highestLevel = 2
            levelName = "Medium"
            levelCountingLable.text = "\(levelName)"
        }
        
        if Int(currentScoreCuntingLabel.text!)! >= 100 {
            level = 3
            highestLevel = 3
            levelName = "Hard"
            levelCountingLable.text = "\(levelName)"
        }
        
        // increase level.
        if self.scores > 50 {
            self.timeCounter = 20
            self.timeCountingLabel.text =  "\(self.timeCounter)"
            
            hideAnimal()
            self.hideDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.hideAnimal), userInfo: nil, repeats: true)
        }
        
        
        if self.scores >= 100 {
            self.timeCounter = 20
            self.timeCountingLabel.text = "\(self.timeCounter)"
            
            hideAnimal()
            self.hideDuration = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideAnimal), userInfo: nil, repeats: true)
        }
    }
    
    // decrese game duration
    func decreseGemeDuration() {
        timeCounter -= 1
        timeCountingLabel.text = "\(timeCounter)"
        
        // terminate duration.
        if timeCounter == 0 {
            gameDuration.invalidate()
            hideDuration.invalidate()
            
            // checking score.
            if self.scores > (Int(higestScoreLabel.text!))!  {
                UserDefaults.standard.set(scores, forKey: "highscore")
                higestScoreLabel.text = "\(scores)"
            }
            
            if self.level > highestLevel {
                UserDefaults.standard.set(level, forKey: "highLevel")
                higestLevelLabel.text = "\(levelName)"
            }
            
            
            // end message.
            let endMessage = UIAlertController(title: "Information", message: "Your time is up!", preferredStyle: UIAlertControllerStyle.alert)
            
            // Ok action.
            let endAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.animalOne.isUserInteractionEnabled = false
                self.animalTwo.isUserInteractionEnabled = false
                self.animalThree.isUserInteractionEnabled = false
                self.animalFour.isUserInteractionEnabled = false
                self.animalFive.isUserInteractionEnabled = false
                self.animalSix.isUserInteractionEnabled = false
                self.animalSeven.isUserInteractionEnabled = false
                self.animalEight.isUserInteractionEnabled = false
                self.animalNine.isUserInteractionEnabled = false
                
                self.gameDuration.invalidate()
                self.hideDuration.invalidate()
            })
            
            endMessage.addAction(endAction)
            
            // replay action.
            let replayAction = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.scores = 0
                self.currentScoreCuntingLabel.text = "\(self.scores)"
                
                self.timeCounter = 30
                self.timeCountingLabel.text = "\(self.timeCounter)"
                
                self.gameDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreseGemeDuration), userInfo: nil, repeats: true)
                
                
                self.hideDuration = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.hideAnimal), userInfo: nil, repeats: true)
            })
            
            endMessage.addAction(replayAction)
            self.present(endMessage, animated: true, completion: nil)
        }
    }
    
    // hide all animals before start game.
    func hideAnimal() {
        for animal in animals {
            animal.isHidden = true
        }
        
        // random animal visiable.
        let randomImage = Int(arc4random_uniform(UInt32(UInt64(Int(animals.count - 1)))))
        animals[randomImage].isHidden = false
    }

    
    @IBAction func gameStartButton(_ sender: Any) {
        self.scores = 0
        self.currentScoreCuntingLabel.text = "\(self.scores)"
        
        self.timeCounter = 30
        self.timeCountingLabel.text = "\(self.timeCounter)"
        
        // add time counter.
        self.timeCountingLabel.text = "\(timeCounter)"
        self.gameDuration = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreseGemeDuration), userInfo: nil, repeats: true)
        
        // hide all animals
        hideAnimal()
        self.hideDuration = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.hideAnimal), userInfo: nil, repeats: true)
        
        // gester recognizer enable to image.
        animalOne.isUserInteractionEnabled = true
        animalTwo.isUserInteractionEnabled = true
        animalThree.isUserInteractionEnabled = true
        animalFour.isUserInteractionEnabled = true
        animalFive.isUserInteractionEnabled = true
        animalSix.isUserInteractionEnabled = true
        animalSeven.isUserInteractionEnabled = true
        animalEight.isUserInteractionEnabled = true
        animalNine.isUserInteractionEnabled = true
        
    }
    

}

