//
//  cardModel.swift
//  matchingGame
//
//  Created by Cynthia on 30/12/2019.
//  Copyright © 2019 Cynthia. All rights reserved.
//

import Foundation

class cardModel {
    
    //return card object
    func getCard() -> [card] {
        
        //array to store generated card
        var generatedCardArray=[card]()
        
        //get random pairs of cards

        var numarray = [Int]()
        while numarray.count < 8 {
            
            //get random number
            let randomNum = Int.random(in: 1...13)

            if !numarray.contains(randomNum) {
                print(randomNum)

                
                //create first card object
                let cardOne = card()
                cardOne.imageName = "card\(randomNum)"
                generatedCardArray.append(cardOne)
                
                let cardTwo = card()
                cardTwo.imageName = "card\(randomNum)"
                generatedCardArray.append(cardTwo)
                
                numarray.append(randomNum)
            }
            let c = numarray.count
            //print("#\(c)")
        }

        //randomlize array
        //generatedCardArray.shuffle()
        
        //return array
        return generatedCardArray
        
        
    }
}
