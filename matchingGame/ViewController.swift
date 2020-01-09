//
//  ViewController.swift
//  matchingGame
//
//  Created by Cynthia on 30/12/2019.
//  Copyright © 2019 Cynthia. All rights reserved.
//

//TODO: add comment
//adjust: margin, record false matching, score
//another idea: not flipped, match corresponding pics(eg. pic name + "1"), record error




import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectView: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var model = cardModel()
    var cardArray = [card]()
    
    var firstFlippedCardIndex:IndexPath?
    //var secondFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 10 * 6000

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.delegate = self
        collectView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //call the method of cardModel
        cardArray=model.getCard()
        print(cardArray)
        
        //create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.timeElapsed), userInfo: nil, repeats: true)

        RunLoop.main.add(timer!, forMode: .common)
        
    }

    @objc func timeElapsed() {
        milliseconds-=1
        //convert to seconds
        let seconds = String(format:"%.2f",milliseconds/1000)

        //set label
        timeLabel.text = "Time remaining: \(seconds)"

        //when it reaches 0
        if milliseconds<=0 {
            //stop the game
            timer?.invalidate()
            timeLabel.textColor = UIColor.red
            
            //check if all cards r matched
            checkCardMatched()
        }

    }

    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get the cardcollectionviewcell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! cardCollectionViewCell
        
        //get the card that is trying to display
        let card = cardArray[indexPath.row]
        
        //set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if there r any time left
        if milliseconds <= 0 {
            return
        }
        
        
        //as keyword cast the result to that object, ! for we r sure abt the result
        let cell = collectionView.cellForItem(at: indexPath) as! cardCollectionViewCell
        
        //get the card
        let card = cardArray[indexPath.row]
        
        if card.flipped==false {
            cell.flip()
            card.flipped=true
            
            /*determine if it is first card or second card
             if it is first card, get the indexpath, else check if they r the same
            */
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                //check if it match
                checkMatch(indexPath)
                
            }
            
            
            
        }
        else {
            cell.flipback()
            card.flipped=false
        }
    }
    
    //check if they r match
    func checkMatch(_ secondFlippedCardIndex:IndexPath){
        
        //get the cell of two cards
        let cardOneCell = collectView.cellForItem(at: firstFlippedCardIndex!) as? cardCollectionViewCell
        
        
        let cardTwoCell = collectView.cellForItem(at: secondFlippedCardIndex) as? cardCollectionViewCell
        
        //get the card for the two cards
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            //they r a match and remove card
        
            cardOne.matched = true
            cardTwo.matched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkCardMatched()
            
        }
        else {
            //they r not a match, flip them back, set flipped to false
            
            cardOne.flipped=false
            cardTwo.flipped=false
            
            cardTwoCell?.flipback()
            cardOneCell?.flipback()
        }
        
        //reload the cell of first card if it is nil
        if cardOneCell == nil {
            collectView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        firstFlippedCardIndex = nil
        
    }
    
    //ending message
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //check if all the cards r matched
    func checkCardMatched(){
        
        var iswon = true
        
        //determine if there r any card unmatched
        for card in cardArray {
            if card.matched == false {
                iswon = false
                break
            }
        
        }
        
        var title = ""
        var message = ""
        
        
        //if not, the user won, stop the timer
        if iswon == true {
            if milliseconds > 0 {
                timer?.invalidate()
                title = "you are the winner"
                message = "you won"
                
            }
        
        }
        else {
            if milliseconds > 0 {
                return
                    
            }
            else {
                title = "game over"
                message = "you lost"

            }
        }
        showAlert(title, message)
        
    }
}

