//
//  ViewController.swift
//  War
//
//  Created by Ole Engstrøm on 15/10/15.
//  Copyright © 2015 Ole Engstroem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var secondCardImageView: UIImageView!
    @IBOutlet weak var playRoundButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    var playerOneScore:Int = 0
    
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    var playerTwoScore:Int = 0
        
    var cardNamesArray:[String] = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "queen", "queen", "king", "ace"]
    
    @IBOutlet weak var countDownLabel: UILabel!
    var timer:NSTimer!
    
    var countDown:Int = 60
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerUpdate", userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // End the game when the time is up
    func timerUpdate() {
        
        // Decrement the counter
        countDown--
        
        // Update the countdown label
        self.countDownLabel.text = String(countDown)
        
        // Check if the time is up
        if countDown == 0 {
            
            var endGameMessage:String = ""
            
            // Stop the timer
            self.timer.invalidate()
            
            // Check if player 1 won
            if playerOneScore > playerTwoScore {
                
                endGameMessage = "Player 1 Wins!"
            
            // Check if player 2 won
            } else if playerOneScore < playerTwoScore {
                
                endGameMessage = "Player 2 Wins!"
                
            // If there is no winner
            } else {
                
                endGameMessage = "Draw!"
                
            }
            
            
            // Display the winner
            let alert:UIAlertController = UIAlertController(title: "Game Over!", message: endGameMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            // Restart the game when button is tapped
            let restartAction = UIAlertAction(title: "Restart!", style: UIAlertActionStyle.Cancel, handler: {
                
                UIAlertAction in
                
                NSLog("Restart! Pressed")
                
                // Reset player one score
                self.playerOneScore = 0
                
                // Update player one score label
                self.playerOneScoreLabel.text = String(self.playerOneScore)
                
                // Reset player player two score
                self.playerTwoScore = 0
                
                // Reset player two score label
                self.playerTwoScoreLabel.text = String(self.playerTwoScore)
                
                // Restart the countdown
                self.countDown = 60
                
                // Update the countdown label
                self.countDownLabel.text = String(self.countDown)
                
                // Revalidate the timer
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerUpdate", userInfo: nil, repeats: true)
                
            })
            
            // Add the actions
            alert.addAction(restartAction)
            
            // Present the controller
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func playRoundTapped(sender: UIButton) {
        
        
        // Randomize a number for the first imageview
        let firstRandomNumber:Int = Int(arc4random_uniform(13))
        
        // Construct a string with the first random number
        let firstCardString:String = self.cardNamesArray [firstRandomNumber]
        
        // Set the first card image view to the asset corresponding to randomized number
        self.firstCardImageView.image = UIImage(named: firstCardString)
        
        // Randomize a number for the second imageview
        let secondRandomNumber:Int = Int(arc4random_uniform(13))
        
        // Construct a string with the second random number
        let secondCardString:String = self.cardNamesArray [secondRandomNumber]
        
        // Set the second card image view to the asset corresponding to the randomized number
        self.secondCardImageView.image = UIImage(named: secondCardString)
        
        // Determine the higher card
        if firstRandomNumber > secondRandomNumber {
            
            // TODO: first card is larger
            self.playerOneScore += 1
            self.playerOneScoreLabel.text = String(self.playerOneScore)
        
        }
        else if firstRandomNumber == secondRandomNumber {
                
                //TODO: numbers are equal
        }
        else {
            
            // TODO: Second card is larger
            self.playerTwoScore += 1
            self.playerTwoScoreLabel.text = String(self.playerTwoScore)
        }
        
            
    }

}

