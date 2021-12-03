//
//  CardCollectionViewCell.swift
//  Match Game
//
//  Created by Braeden Meikle on 5/26/20.
//  Copyright © 2020 Braeden Meikle. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: CardCollectionViewCell!
    
    var card:Card?
    
    func setCard(_ card:Card)
    {
        // self = this
        // keep track of the card passed in
        self.card = card
        
        if card.isMatched == true
        {
            // if the card has been matched make the image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            // exit the method
            return
        }
        else
        {
            // if the card hasn't been matched make the image views visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        // set front image view
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true
        {
            // frontimageview should be on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else
        {
            // backimageview should be on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip()
    {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack()
    {
        // add delay
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5)
        {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove()
    {
        // removes both images
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
