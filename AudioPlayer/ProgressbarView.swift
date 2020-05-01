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
	@State var currentTime: TimeInterval = 0
	
	init(player: AVPlayer, audioSamples: [Float], viewWidth: CGFloat, viewHeight: CGFloat) {
		self.player = player
		self.audioSamples = audioSamples
		self.viewWidth = viewWidth
		self.viewHeight = viewHeight
	}
	
	func observeTime(){
		player.addPeriodicTimeObserver(
			forInterval: CMTime(seconds: 0.01, preferredTimescale: 600),
			queue: nil) {
				time in
				self.currentTime = time.seconds
		}
	}
	
    var body: some View {
		
			ZStack{
				WaveformView(audioSamples: audioSamples,
							 viewWidth: viewWidth,
							 viewHeight: viewHeight)
				Rectangle()
					.foregroundColor(.red)
					.frame(width: 5)
					.position(x: CGFloat(self.currentTime)/CGFloat(self.duration)*viewWidth, y: viewHeight/2)
			}.frame(width: viewWidth, height: viewHeight)
		
		
    }
}

struct ProgressbarView_Previews: PreviewProvider {
    static var previews: some View {
		ProgressbarView(player: AVPlayer(),
						audioSamples: [0.1,0.3,0.4,0.2,0.5,1,0.5,0.9],
						viewWidth: 200,
						viewHeight: 200)
    }
}