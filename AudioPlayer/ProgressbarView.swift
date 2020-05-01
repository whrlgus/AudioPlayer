//
//  ProgressbarView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ProgressbarView: View {
	let player: AVPlayer
	let audioSamples: [Float]
	let viewWidth: CGFloat
	let viewHeight: CGFloat
	
	
	@State var duration: TimeInterval = 1
	@Binding var currentTime: TimeInterval

	@Binding var isPlaying: Bool
	
	@State var dragLocation = CGPoint.zero
	
	init(player: AVPlayer, audioSamples: [Float], viewWidth: CGFloat, viewHeight: CGFloat, currentTime: Binding<TimeInterval>, isPlaying: Binding<Bool>) {
		self.player = player
		self.audioSamples = audioSamples
		self.viewWidth = viewWidth
		self.viewHeight = viewHeight
		self._currentTime = currentTime
		self._isPlaying = isPlaying
	}
	
	
//	func foo(value: DragGesture.Value, min:CGFloat, max:CGFloat){
//		print("\(value.location.x)")
//		self.currentTime=TimeInterval(value.location.x)
//
//		if(self.currentTime < min){
//			self.currentTime=TimeInterval(min)
//		}
//		if(self.currentTime > max){
//			self.currentTime=TimeInterval(max)
//		}
//
//
//	}
	
    var body: some View {
		
			ZStack{
				WaveformView(audioSamples: audioSamples,
							 viewWidth: viewWidth,
							 viewHeight: viewHeight)
				
//				.gesture(
//					DragGesture(minimumDistance: 0).onChanged({ value in
//						self.foo(value: value, min: 0, max: self.viewWidth)
//					}).onEnded({ value in
//						self.foo(value: value, min: 0, max: self.viewWidth)
//					})
//				)
				
				Rectangle()
					.fill(Color.red)
					.frame(width: 5)
					.position(x: CGFloat(self.currentTime)/CGFloat(self.duration)*viewWidth, y: viewHeight/2)
			}.frame(width: viewWidth, height: viewHeight)
    }
}
