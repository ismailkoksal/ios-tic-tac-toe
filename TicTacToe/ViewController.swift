//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ismail Koksal on 09/12/2019.
//  Copyright © 2019 Ismail Koksal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bu1: UIButton!
    @IBOutlet weak var bu2: UIButton!
    @IBOutlet weak var bu3: UIButton!
    @IBOutlet weak var bu4: UIButton!
    @IBOutlet weak var bu5: UIButton!
    @IBOutlet weak var bu6: UIButton!
    @IBOutlet weak var bu7: UIButton!
    @IBOutlet weak var bu8: UIButton!
    @IBOutlet weak var bu9: UIButton!
    var buList = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buList.append(bu1)
        buList.append(bu2)
        buList.append(bu3)
        buList.append(bu4)
        buList.append(bu5)
        buList.append(bu6)
        buList.append(bu7)
        buList.append(bu8)
        buList.append(bu9)
    }

    @IBAction func buSelectEvent(_ sender: Any) {
        let buSelect = sender as! UIButton
        UIButton.animate(withDuration: 0.2, animations: {
            buSelect.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: { finish in
            UIButton.animate(withDuration: 0.2, animations: {
                buSelect.transform = CGAffineTransform.identity
            })
        })
        playGame(buSelect: buSelect)
    }
    
    var activePlayer = 1
    var player1 = [Int]()
    var player2 = [Int]()
    
    func playGame(buSelect: UIButton) {
        if (activePlayer == 1) {
            buSelect.setTitle("X", for: UIControl.State.normal)
            buSelect.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 21/255, alpha: 0.5)
            player1.append(buSelect.tag)
            activePlayer = 2
            autoPlay()
//            print(player1)
        } else {
            buSelect.setTitle("O", for: UIControl.State.normal)
            buSelect.backgroundColor = UIColor(red: 32/255, green: 250/255, blue: 21/255, alpha: 0.5)
            player2.append(buSelect.tag)
            activePlayer = 1
//            print(player2)
        }
        buSelect.isEnabled = false
        let winner = findWinner()
        viewWinner(winner: winner)
    }
    
    func findWinner() -> Int {
        var winner = -1
//        winner 1 : rows
        if (
            (player1.contains(1) && player1.contains(2) && player1.contains(3)) ||
            (player1.contains(4) && player1.contains(5) && player1.contains(6)) ||
            (player1.contains(7) && player1.contains(8) && player1.contains(9))
        ) { winner = 1 }
//        winner 1 : cols
        if (
            (player1.contains(1) && player1.contains(4) && player1.contains(7)) ||
            (player1.contains(2) && player1.contains(5) && player1.contains(8)) ||
            (player1.contains(3) && player1.contains(6) && player1.contains(9))
        ) { winner = 1 }
//        winner 1 : diagonales
        if (
            (player1.contains(1) && player1.contains(5) && player1.contains(9)) ||
            (player1.contains(3) && player1.contains(5) && player1.contains(7))
        ) { winner = 1 }
//        winner 2 : rows
        if (
            (player2.contains(1) && player2.contains(2) && player2.contains(3)) ||
            (player2.contains(4) && player2.contains(5) && player2.contains(6)) ||
            (player2.contains(7) && player2.contains(8) && player2.contains(9))
        ) { winner = 2 }
//        winner 2 : cols
        if (
            (player2.contains(1) && player2.contains(4) && player2.contains(7)) ||
            (player2.contains(2) && player2.contains(5) && player2.contains(8)) ||
            (player2.contains(3) && player2.contains(6) && player2.contains(9))
        ) { winner = 2 }
//        winner 2 : diagonales
        if (
            (player2.contains(1) && player2.contains(5) && player2.contains(9)) ||
            (player2.contains(3) && player2.contains(5) && player2.contains(7))
        ) { winner = 2 }
        return winner;
    }
    
    func viewWinner(winner: Int) {
        if (winner == 1 || winner == 2) {
            let msg = "Player \(winner) is the winner"
//            print(msg)
            let alert = UIAlertController(title: "TicTacToe", message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: {
                for bu in self.buList {
                    bu.isEnabled = false
                }
            })
        }
    }
    
    func autoPlay() {
        let winningCombinaisons = [
            // rows
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            // cols
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9],
            // diagonales
            [1, 5, 9],
            [3, 5, 7],
        ]
        var emptyCell = [Int]()
        for index in 1...9 {
            if ( !(player1.contains(index) || player2.contains(index))) {
                emptyCell.append(index)
            }
        }
        if (!emptyCell.isEmpty) {
            var count = 0
            var buToPlay = 0
            for comb in winningCombinaisons {
                count = 0
                for index in comb {
                    if player1.contains(index) {
                        count += 1
                    }
                    if count >= 2 {
                        buToPlay = index
                    }
                }
            }
            let index: Int
            if buToPlay != 0 {
                index = buToPlay
            } else {
                index = Int(arc4random_uniform(UInt32(emptyCell.count)))
            }
            let cellId = emptyCell[Int(index)]
            var buSelect: UIButton
            for bu in self.buList {
                if (bu.tag == cellId) {
                    buSelect = bu
                    playGame(buSelect: buSelect)
                }
            }
        }
    }
}
