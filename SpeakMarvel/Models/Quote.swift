//  Quote.swift
//  SpeakMarvel
//
//  Created by Akshara Sundararajan on 2/17/18.
//  Copyright © 2018 meera. All rights reserved.
//
import Foundation
import SwiftyJSON

class Quote{
    var quote: String
    var difficulty: Float
    var character: String
    var imageURL: String
    
    init(quote: String, difficulty: Float, character: String, imageURL: String){
        self.character = character
        self.difficulty = difficulty
        self.quote = quote
        self.imageURL = imageURL
    }
    init()
    {
        quote = "With great power comes great responsibility"
        difficulty = 4
        character = "Uncle Ben"
        imageURL = "tinyurl.com/random"
    }
    enum Difficulty
    {
        case EASY, HARD
    }
    
    func checkIfWordIsCommon(word: String) -> Bool
    {
        //        if let path = Bundle.mainBundle.path(forResource: "data", ofType: "json") {
        //            if let data = NSData(contentsOfFile: "dalechellwordlist") {
        //                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.AllowFragments, error: nil)
        //
        //            }
        //        }
        //        let data = NSData(contentsOfFile: "dalechellwordlist.json")
        //        if let jsonData = data {
        //
        //        }
        if let path = Bundle.main.path(forResource: "dalechellwordlist", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                if(jsonObj[word].exists())
                {
                    return true
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return false;
    }
    
    func getDifficulty(word: String) -> Difficulty
    {
        let isWordCommon = checkIfWordIsCommon(word: word)
        
        if word.count < 5 || isWordCommon
        {
            return Difficulty.EASY
        }
        
        return Difficulty.HARD
    }
    //returns # of easy, then medium then hard
    func numberOfWordsInDifferentCategories(quote:String) -> [Float]
    {
        var numberOfWordsOfEachDifficulty = [Float] ()
        numberOfWordsOfEachDifficulty.append(0.0)
        numberOfWordsOfEachDifficulty.append(0.0)
        
        
        var newQuote = quote.replacingOccurrences(of: ",", with: " ")
        newQuote = newQuote.replacingOccurrences(of: ".", with: " ")
        newQuote = newQuote.replacingOccurrences(of: "!", with: " ")
        newQuote = newQuote.replacingOccurrences(of: ",", with: " ")
        newQuote = newQuote.replacingOccurrences(of: "/", with: " ")
        newQuote = newQuote.replacingOccurrences(of: "(", with: " ")
        newQuote = newQuote.replacingOccurrences(of: ")", with: " ")
        
        let wordsInQuote = quote.split(separator:" ")
        
        for thing in wordsInQuote
        {
            if(getDifficulty(word: thing.lowercased())==Difficulty.EASY) //easy
            {
                numberOfWordsOfEachDifficulty[0] = numberOfWordsOfEachDifficulty[0] + 1
                
            }
            else //hardSM
            {
                numberOfWordsOfEachDifficulty[1] = numberOfWordsOfEachDifficulty[1] + 1
            }
        }
        return numberOfWordsOfEachDifficulty
    }
    
    
    func calculateDifficulty(quote: String) -> Float
    {
        var rawScore: Float
        let difficultiesNumber = numberOfWordsInDifferentCategories(quote: quote)
        
        rawScore = 0.1579*(100*(difficultiesNumber[1]/(difficultiesNumber[1]+difficultiesNumber[0])))+0.0496*(difficultiesNumber[1]+difficultiesNumber[0])
        
        if difficultiesNumber[1]/(difficultiesNumber[1] + difficultiesNumber[0]) > 0.05
        {
            rawScore = rawScore + 3.6365
        }
        
        return rawScore
    }
    
    init(quote: String, character: String, imageURL: String){
        self.character = character
        self.difficulty = 0
        self.quote = quote
        self.imageURL = imageURL
        self.difficulty = calculateDifficulty(quote: quote)
        
    }
    
    func removePunctuation(word: String) -> String
    {
        var newWord = word.replacingOccurrences(of:".", with: "")
        newWord = newWord.replacingOccurrences(of:"?", with: "")
        newWord = newWord.replacingOccurrences(of:",", with: "")
        newWord = newWord.replacingOccurrences(of:"!", with: "")
        newWord = newWord.replacingOccurrences(of:"(", with: "")
        newWord = newWord.replacingOccurrences(of:")", with: "")
        
        return newWord
    }
    
    func checkQuoteSaidIsCorrect(spokenQuote: String) -> Bool
    {
        var normalizedSpokenQuote: String
        var normalizedQuote: String
        normalizedQuote = quote.lowercased()
        normalizedSpokenQuote = spokenQuote.lowercased()
        
        //need to remove punctuation from actual quote
        
        normalizedQuote = removePunctuation(word:normalizedQuote)
        normalizedSpokenQuote = removePunctuation(word:normalizedSpokenQuote)
        
        return normalizedSpokenQuote == normalizedQuote
        
    }
    
    
}
