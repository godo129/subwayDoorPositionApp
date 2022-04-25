//
//  TrainLaneInfoView.swift
//  subwayDoorPositionApp WatchKit Extension
//
//  Created by hong on 2022/04/18.
//

import UIKit
import WatchKit

let KEY_SELF_WIN_COUNT = "Self win count"
let KEY_PC_WIN_COUNT = "PC win count"

enum GameResult : Int {
    case notEnd, win, lose, end
}

class TrainLaneInfoView: WKInterfaceController {
    
    var _buttons = [WKInterfaceButton]()
    var _matrix : Array<Int> = [Int](repeating: 0, count: 9)
    var _shouldPcMove : Bool = false
    var aiTurn : Bool = false
    
    override init() {
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        _buttons = [_button0, _button1, _button2, _button3, _button4, _button5, _button6]
        
        
    }
    
    func restartGane() {
        
        for i in 0..<9 {
            _matrix[i] = 0
        }
        
        for button in _buttons {
            button!.setTitle("")
        }
        
        _shouldPcMove = (arc4random_uniform(2) != 0)
        
        if _shouldPcMove {
            aiTurn = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.pcMove()
        }
    }
    
    func pcMove() {
        
        var index = 0
        // Try ro win
        
        index = self.nextIndexToWin()
        
        // Try to Block
        if index < 0 {
            index = self.nextIndexToBlock()
        }
        
        // Random location
        if index < 0 {
            repeat {
                index = Int(arc4random_uniform(9))
            } while _matrix[index] != 0
            
        }
        
    }
    
    func checkGameResult() {
        
        let result: GameResult = self.calculateGameResult()
        if result == GameResult.notEnd {
            if _shouldPcMove {
                self.pcMove()
            }
            return
        } else if result == GameResult.win {
            
            let userDefaults = UserDefaults.standard
            var count = userDefaults.integer(forKey: KEY_SELF_WIN_COUNT)
            count += 1
            userDefaults.set(count, forKey: KEY_SELF_WIN_COUNT)
            userDefaults.synchronize()  // 키 동기화
        } else if result = GameResult.lose {
            // lose
            
            let userDefaults = UserDefaults.standard
            var count = userDefaults.integer(forKey: KEY_PC_WIN_COUNT)
            count += 1
            userDefaults.set(count, forKey: KEY_PC_WIN_COUNT)
            userDefaults.synchronize()
            
        }
        
        
        
    }
    
    func calculateGameResult() -> GameResult {
        
        if self.has3InLineInMatrix(1, matrix: _matrix) {
            return GameResult.win
        }
        
        if self.has3InLineInMatrix(2, matrix: _matrix) {
            return GameResult.lose
        }
        
        var total = 0
        for i in 0..<9 {
            if _matrix[i] != 0 {
                total += 1
            }
        }
        
        if total == 9 {
            return GameResult.end
        }
        
        return GameResult.notEnd
    }
    
    func has3InLineInMatrix(_ value: Int, matrix: [Int]) -> Bool {
        
        var condition =
        (matrix[0] == value && matrix[1] == value && matrix[2] == value) || (matrix[3] == value && matrix[4] == value && matrix[5] == value)
        
        condition = condition ||
        (matrix[6] == value && matrix[7] == value && matrix[8] == value) || (matrix[0] == value && matrix[3] == value && matrix[6] == value)

        condition = condition ||
        (matrix[1] == value && matrix[4] == value && matrix[7] == value) || (matrix[2] == value && matrix[5] == value && matrix[8] == value)
        
        condition = condition ||
        (matrix[0] == value && matrix[4] == value && matrix[8] == value) || (matrix[2] == value && matrix[4] == value && matrix[6] == value)

        
        return condition
        
    }
    
    func nextIndexToWin() -> Int {
        return nextIndexHave3InLine(1)
    }
    
    func nextIndexToBlock() -> Int {
        return nextIndexHave3InLine(1)
    }
    
    func nextIndexHave3InLine(_ value: Int) -> Int {
        
        var matrix = [Int](reapeating: 0, count: 9)
        
        for i in 0..<9 {
            
            if matrix[i] == 0 {
                matrix[i] = value
                if has3InLineInMatrix(value, matrix: matrix) {
                    return i
                }
                matrix[i] = 0
            }
        }
        
        return -1
        
    }
    
    override func willActivate() {
        super.willActivate()
    }

}
