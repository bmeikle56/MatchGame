//
//  CardModel.swift
//  Match Game
//
//  Created by Braeden Meikle on 5/22/20.
//  Copyright © 2020 Braeden Meikle. All rights reserved.
//

import Foundation

class CardModel
{
    func getCards() -> [Card]
    {
        /*
        declare an array to store the generated cards
        randomly generate pairs of cards
        randomize the array, return
        */
        
        var generatedCardsArray = [Card]()
        for _ in 1...8
        {
            // get a random number and create first card object, add
            let randomNumber = arc4random_uniform(13) + 1 // random number 0-12 + 1, not inclusive
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardOne)
            
            // second card
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardOne)
            
            
        }
        
        // TODO: Randomize the array
        
        return generatedCardsArray
    }
}
