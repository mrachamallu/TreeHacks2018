//  Player.swift
//  SpeakMarvel
//
//  Created by Admin on 2/16/18.
//  Copyright © 2018 meera. All rights reserved.
//
import Foundation

class Player{
    var Score: Int
    var difficultyRange: Int
    var runningCorrect: Int
    var currentQuote: Quote
    
    init(Score:Int, difficultyRange:Int, runningCorrect: Int, currentQuote: Quote)
    {
        self.difficultyRange=difficultyRange
        self.Score=Score
        self.runningCorrect=runningCorrect
        self.currentQuote = currentQuote
    }
    
    init (currentQuote: Quote)
    {
        self.currentQuote=currentQuote
        difficultyRange = 5
        Score = 0
        runningCorrect = 0
    }
    
    func updateQuote(quote: Quote)
    {
        currentQuote = quote
    }
    
    func updateDifficulty()
    {
        if runningCorrect > 4
        {
            if difficultyRange <= 10
            {
                difficultyRange =  difficultyRange+1
            }
            
            runningCorrect = 0
        }
        else if runningCorrect < -4
        {
            difficultyRange = difficultyRange - 1
            runningCorrect = 0
        }
        
    }
    
    func updateScore(spokenSentence: String)
    {
        if(currentQuote.checkQuoteSaidIsCorrect(spokenQuote: spokenSentence))
        {
            runningCorrect = runningCorrect+1
            Score = Score + Int(currentQuote.difficulty*10)
        }
        else
        {
            runningCorrect = runningCorrect - 1
        }
    }
    
}
