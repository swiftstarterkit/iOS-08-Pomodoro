//
//  TimeRobot.swift
//  Pomodoro
//
//  Created by Pao Yu on 2020-07-14.
//

import SwiftUI

class PomodoroModel: ObservableObject {
    
    @Published var timeStart: Float = 0
    @Published var timeRemaining: Float = 0
    @Published var progressBarHeight: CGFloat = 350
    @Published var timerActive: Bool = false
    
    var timer: Timer?
    
    func runFocusTimer(time: Float) {
        fillProgressBar()
        invalidateTimer()
        initializeTimer(time: time)
    }
    
    func resetFocusTimer() {
        fillProgressBar()
        invalidateTimer()
    }
}

// MARK: - TimeRobot Functions

extension PomodoroModel {
    
    func initializeTimer(time: Float) {
        timerActive = true
        timeStart = time
        timeRemaining = time
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in self.runTimerActions() }
    }
    
    func invalidateTimer() {
        timerActive = false
        timer?.invalidate()
    }
    
    func runTimerActions() {
        if timeRemaining > 0  {
            reduceTime()
            resizeProgressBar()
        } else {
            invalidateTimer()
        }
    }
    
    func reduceTime() {
        timeRemaining = timeRemaining - 1
    }
    
    func resizeProgressBar() {
        progressBarHeight = CGFloat(timeRemaining / timeStart) * 350
    }
    
    func fillProgressBar() {
        progressBarHeight = 350
    }
}

