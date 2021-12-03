//
//  ViewController.swift
//  Match Game
//
//  Created by Braeden Meikle on 5/22/20.
//  Copyright © 2020 Braeden Meikle. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    var milliseconds:Float = 10 * 1000
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // call the getCards method of the card model
        cardArray = model.getCards()
        
        // create timer
        timer = Timer.init(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }
    
    // MARK: - Timer Methods
    
    @objc func timerElapsed()
    {
        milliseconds -= 1
        
        // convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        // set label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // when the timer reaches 0 stop it
        if milliseconds <= 0
        {
            timer?.invalidate()
        }
    }

    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // casted, similar to (int)double
        // get the CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // set that card for the cell 
        cell.setCard(card)
        
        return cell
    }
    
    // user selects a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // get the card that the user selected
        let card = cardArray[indexPath.row]
        
        // flip the card
        cell.flip()
        
        if card.isFlipped == false && card.isMatched == false
        {
            // flip the card since it hasn't been flipped yet
            cell.flip()
            card.isFlipped = true;
            
            if firstFlippedCardIndex == nil
            {
                // the first card being flipped
                firstFlippedCardIndex = indexPath
            }
            else
            {
                // second flipped card
                // perform the matching logic
                checkForMatches(indexPath)
            }
        }
        else
        {
            // flip back
            cell.flipBack()
            card.isFlipped = false
        }
    }
    
    func checkForMatches(_ secondFlippedCardIndex: IndexPath)
    {
        // get the cells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        // get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // compare the cards
        if cardOne.imageName == cardTwo.imageName
        {
            // match
            // set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            // remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
        }
        else
        {
            // not a match
            // set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            // flip cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        // tell the collectionview to reload the cell of the first card if
        // it is nil
        if cardOneCell == nil
        {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // reset the property
        firstFlippedCardIndex = nil
    }
}

