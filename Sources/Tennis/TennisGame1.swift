import Foundation

// switch cases
// long method
// duplication
// primitive obsession (player, score)
// shotgun surgery

// 1- make change easy for player

class Player {
    var name: String
    var score: Int = 0

    init(name: String) {
        self.name = name
    }
}

class TennisGame1: TennisGame {
    private let player1: Player
    private let player2: Player

    required init(player1: String, player2: String) {
        self.player1 = Player(name: player1)
        self.player2 = Player(name: player2)
    }

    func wonPoint(_ playerName: String) {
        if playerName == "player1" {
            player1.score += 1
        } else {
            player2.score += 1
        }
    }

    var score: String? {
        let isDraw = player1.score == player2.score
        let scoreIsEqualToOrMoreThanFour: Bool = player1.score >= 4 || player2.score >= 4

        if isDraw {
            return getScoreIfDraw(player1.score, player2.score)
        }

        if scoreIsEqualToOrMoreThanFour {
            return getScoreIfEqualOrMoreThanFour(player1.score, player2.score)
        }

        return getScore(player1.score, player2.score)
    }

    func getScore(_ score1: Int, _ score2: Int) -> String {
        var tempScore = 0
        var score = ""

        for i in 1 ..< 3 {
            if i == 1 {
                tempScore = score1
            } else {
                score = score + "-"
                tempScore = score2
            }

            switch tempScore {
            case 0:
                score = "\(score)Love"

            case 1:
                score = "\(score)Fifteen"

            case 2:
                score = "\(score)Thirty"

            case 3:
                score = "\(score)Forty"

            default:
                break
            }
        }

        return score
    }

    func getScoreIfEqualOrMoreThanFour(_ score1: Int, _ score2: Int) -> String {
        let minusResult = score1 - score2

        if minusResult == 1 {
            return "Advantage " + player1.name
        } else if minusResult == -1 {
            return "Advantage " + player2.name
        } else if minusResult >= 2 {
            return "Win for " + player1.name
        } else {
            return "Win for " + player2.name
        }
    }

    func getScoreIfDraw(_ score1: Int, _ score2: Int) -> String {
        switch score1 {
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
