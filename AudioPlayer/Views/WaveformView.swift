//
//  WaveformView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI

struct WaveformView: View {
	let audioSamples: [Float]
	let viewHeight: CGFloat
	let barWidth: CGFloat?
	var ratio: Int = 1
	
	init(audioSamples: [Float], viewWidth: CGFloat, viewHeight: CGFloat) {
		self.audioSamples = audioSamples
		self.viewHeight = viewHeight
		self.ratio = audioSamples.count / 3000 + 1
		self.barWidth = CGFloat(self.ratio)*viewWidth/CGFloat(audioSamples.count)
	}
	
	var body: some View {
		Color.gray
			.overlay(
				HStack(spacing: 0) {
					ForEach(0..<self.audioSamples.count/self.ratio, id: \.self){ value in
						Rectangle()
							.frame(
								width: self.barWidth,
								height: CGFloat(self.audioSamples[value*self.ratio])*self.viewHeight
						)
						
					}
//					ForEach(self.audioSamples, id: \.self) { value in
//						Rectangle()
//							.frame(
//								width: self.barWidth,
//								height: CGFloat(value)*self.viewHeight
//						)
//					}
			})
	}
}
