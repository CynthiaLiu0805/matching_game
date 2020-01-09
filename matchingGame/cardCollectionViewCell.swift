//
//  cardCollectionViewCell.swift
//  matchingGame
//
//  Created by Cynthia on 4/1/2020.
//  Copyright © 2020 Cynthia. All rights reserved.
//

import UIKit

class cardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    

    
    var card:card?
    
    func setCard(_ card:card) {
        
        //keep track of the card passed in
        self.card = card
        
        //if the card has been matched, the imageview invisible
        if card.matched == true {
            frontImageView.alpha = 0
            backImageView.alpha = 0
            
            return
        }
        else {
            frontImageView.alpha = 1
            backImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //determine if the card is in flipped up state or down state
        if card.flipped==true {
            //front image view is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }
        else {
            //back image view is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
                   
        }
        
    }
    
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipback(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
        
    }
    
    func remove(){
        
        backImageView.alpha=0

        
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha=0

        }, completion: nil)
        
    }
    
}
