//
//  ProgressbarView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import AVFoundation

protocol ProgressbarViewDelegate {
	func updateCurrentTime()
}

struct ProgressbarView: View {
	@ObservedObject var audioPlayer = AudioPlayer.shared

	let viewWidth: CGFloat
	let viewHeight: CGFloat
	
	@State var duration: TimeInterval = 1
	@State var dragLocation = CGPoint.zero

	func seek(value: DragGesture.Value, min:CGFloat, max:CGFloat){
		print("\(value.location.x)")
		audioPlayer.currentTimePerDuration = value.location.x

		if(audioPlayer.currentTimePerDuration < min){
			audioPlayer.currentTimePerDuration = min
		}
		if(audioPlayer.currentTimePerDuration > max){
			audioPlayer.currentTimePerDuration = max
		}

		audioPlayer.currentTimePerDuration /= max
	}
	
    var body: some View {
		
			ZStack{
				WaveformView(audioSamples: audioPlayer.audioSamples,
							 viewWidth: viewWidth,
							 viewHeight: viewHeight)

				.gesture(
					DragGesture(minimumDistance: 0)
						.onChanged({ value in
							self.audioPlayer.isSeeking = true
						self.seek(value: value, min: 0, max: self.viewWidth)
					}).onEnded({ value in
						self.seek(value: value, min: 0, max: self.viewWidth)
						self.audioPlayer.seek()
						self.audioPlayer.isSeeking = false
						})
				)

				Rectangle()
					.fill(Color.red)
					.frame(width: 5)
					.position(x: CGFloat(self.audioPlayer.currentTimePerDuration)*viewWidth, y: viewHeight/2)
			}.frame(width: viewWidth, height: viewHeight)
    }
}
