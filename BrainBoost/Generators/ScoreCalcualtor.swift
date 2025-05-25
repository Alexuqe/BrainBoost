import Foundation

final class ScoreCalcualtor: ScoreCalculatorProtocol {
    func calculateScore(mathedPairs: Int, time: TimeInterval) -> Int {
        let baseScore = mathedPairs * 100
        let timeBonus = max(0, 100 - Int(time) * 10)

        return baseScore + timeBonus
    }
}
