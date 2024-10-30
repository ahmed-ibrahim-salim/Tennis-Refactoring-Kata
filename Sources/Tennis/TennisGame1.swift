import Foundation

// switch cases
// long method
// duplication
// primitive obsession (player, score)
// shotgun surgery

// 1- make change easy for player

class TennisGame1: TennisGame {
    private let player1: Player
    private let player2: Player
    private let normalScore = NormalScore()
    private let scoreIfEqualOrMoreThanFour = ScoreIfEqualOrMoreThanFour()
    private let draw = Draw()

    required init(player1: String, player2: String) {
        self.player1 = Player(name: player1)
        self.player2 = Player(name: player2)
    }

    func wonPoint(_ playerName: String) {
        if playerName == player1.name {
            player1.score += 1
        } else {
            player2.score += 1
        }
    }

    var score: String? {
        let isDraw = player1.score == player2.score
        let scoreIsEqualToOrMoreThanFour: Bool = player1.score >= 4 || player2.score >= 4

        if isDraw {
            return draw.getScore(player1, player2)
        }

        if scoreIsEqualToOrMoreThanFour {
            return scoreIfEqualOrMoreThanFour.getScore(player1, player2)
        }

        return normalScore.getScore(player1, player2)
    }
}

// MARK: Models

class Player {
    var name: String
    var score: Int = 0

    init(name: String) {
        self.name = name
    }
}

protocol ScoreCalculator {
    func getScore(_ player1: Player, _ player2: Player) -> String
}

class NormalScore: ScoreCalculator {
    func getScore(_ player1: Player, _ player2: Player) -> String {
        var tempScore = 0
        var score = ""

        func getScore(_ tempScore: Int, _ score: String) -> String {
            switch tempScore {
            case 0:
                return "\(score)Love"

            case 1:
                return "\(score)Fifteen"

            case 2:
                return "\(score)Thirty"

            case 3:
                return "\(score)Forty"

            default:
                return score
            }
        }

        for i in 1 ..< 3 {
            if i == 1 {
                tempScore = player1.score
            } else {
                score = score + "-"
                tempScore = player2.score
            }

            score = getScore(tempScore, score)
        }
        return score
    }
}

class ScoreIfEqualOrMoreThanFour: ScoreCalculator {
    func getScore(_ player1: Player, _ player2: Player) -> String {
        let minusResult = player1.score - player2.score

        if minusResult == 1 {
            return "Advantage " + player1.name
        }

        if minusResult == -1 {
            return "Advantage " + player2.name
        }

        if minusResult >= 2 {
            return "Win for " + player1.name
        }

        return "Win for " + player2.name
    }
}

class Draw: ScoreCalculator {
    func getScore(_ player1: Player, _ player2: Player) -> String {
        switch player1.score {
        case 0:
            return "Love-All"

        case 1:
            return "Fifteen-All"

        case 2:
            return "Thirty-All"

        default:
            return "Deuce"
        }
    }
}
