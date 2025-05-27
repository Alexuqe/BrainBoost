final class CardGenerator: CardGeneratorProtocol {

    func generateCards() -> [[MainSceneModel.Card]] {
        let pairs = (1...8).flatMap { [$0, $0] }
        
        let shufflePairs = pairs.shuffled()

        var cards: [[MainSceneModel.Card]] = []
        var index = 0

        for row in 0..<4 {
            var rowCards: [MainSceneModel.Card] = []
            for colum in 0..<4 {
                let card = MainSceneModel.Card(
                    id: row * 4 + colum,
                    value: shufflePairs[index],
                    isFlipped: false,
                    isMatches: false
                )

                rowCards.append(card)
                index += 1
            }
            cards.append(rowCards)
        }
        return cards
    }
}
