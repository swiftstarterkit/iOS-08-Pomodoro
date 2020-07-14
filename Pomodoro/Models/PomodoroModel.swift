//
//  PomodoroModel.swift
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
        resetTime()
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
        // "withTimeInterval" parameter can be changed to "60.0" to convert timer to minutes instead of seconds.
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
    
    func resetTime() {
        timeStart = 0
        timeRemaining = 0
    }
}

