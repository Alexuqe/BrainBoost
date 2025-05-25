final class CardGenerator: CardGeneratorProtocol {

    func generateCards() -> [[MainSceneModel.Card]] {
        let pairs = (1...8).flatMap { number in
            [number, number]
        }

        let shuflePairs = pairs.shuffled()
        var cards: [[MainSceneModel.Card]] = []
        var index = 0

        for row in 0..<4 {
            var rowCards: [MainSceneModel.Card] = []
            for colum in 0..<4 {
                let card = MainSceneModel.Card(
                    id: row * 4 + colum,
                    value: shuflePairs[index],
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
