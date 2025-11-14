//
//  MemoryGame.swift
//  pairProgramming3
//
//  Created by Alejandro Avina on 11/9/25.
//
import Foundation

struct MemoryGame {
    
    private(set) var cards: Array <Card>
    private(set) var numberOfPairs: Int
    private var firstFlipIndex : Int?
    
    
    struct Card: Identifiable {
        var content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id:Int
    }
    
    var completedAmount : Double {
     let totalCards = Double(cards.count)
        let finishedCards = Double(cards.filter{element in element.isMatched}.count)
        return finishedCards / totalCards * 100
     }
    
    
    mutating func chooseCard(card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            let chosenCard = cards[index]
            
           
            if chosenCard.isFaceUp || chosenCard.isMatched {
                return
            }
            
          
            if let matchIndex = firstFlipIndex {
           
                if cards[matchIndex].content == chosenCard.content {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                firstFlipIndex = nil
            } else {
              
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                cards[index].isFaceUp = true
                firstFlipIndex = index
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int, contentFactory: (Int)-> String) {
        cards = []
        numberOfPairs = numberOfPairsOfCards
        
        for index in 0..<numberOfPairsOfCards{
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        cards.shuffle()
    }
    
}
