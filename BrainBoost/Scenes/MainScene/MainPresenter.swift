final class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?

    func presentGame(_ response: Game.Response) {
        let cardViewModels = response.cards.enumerated().map { rowIndex, row in
            row.enumerated().map { columIndex, card in
                Game.ViewModel.CardViewModel(
                    position: MainSceneModel.Position(
                        row: rowIndex,
                        column: columIndex
                    ),
                    value: card.isFlipped ? card.value : nil,
                    isEnabled: response.gameState == .inProgress && !card.isMatches,
                    isMatched: card.isMatches,
                    shouldAnimate: shouldAnimate(
                        card: card,
                        at: MainSceneModel.Position(
                            row: rowIndex,
                            column: columIndex
                        ),
                        lastSelected: response.lastSelectedPosition,
                        secondSelected: response.secondSelectedPosition
                    )
                )
            }
        }

        let viewModel = Game.ViewModel(
            gameState: response.gameState,
            cards: cardViewModels,
            score: String(response.score),
            progress: "Pairs: \(response.matchedPairs), \(response.totalPairs)"
        )

        viewController?.displayGame(viewModel)
    }

    private func shouldAnimate(
        card: MainSceneModel.Card,
        at position: MainSceneModel.Position,
        lastSelected: MainSceneModel.Position?,
        secondSelected: MainSceneModel.Position?
    ) -> Bool {
        if let lastSelected = lastSelected, position == lastSelected {
            return true
        }
        if let secondSelected = secondSelected, position == secondSelected {
            return true
        }
        return false
    }
}
