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
	
	init(audioSamples: [Float], viewWidth: CGFloat, viewHeight: CGFloat) {
		self.audioSamples = audioSamples
		self.viewHeight = viewHeight
		self.barWidth = viewWidth/CGFloat(audioSamples.count)
	}
	
	var body: some View {
		Color.gray
			.overlay(
				HStack(spacing: 0) {
					ForEach(self.audioSamples, id: \.self) { value in
						Rectangle()
							.frame(
								width: self.barWidth,
								height: CGFloat(value)*self.viewHeight
						)
					}
			})
	}
}

struct WaveformView_Previews: PreviewProvider {
	static var previews: some View {
		WaveformView(audioSamples: [0.1,0.3,0.4,0.2,0.5,1,0.5,0.9],
					 viewWidth: 200,
					 viewHeight: 200)
	}
}
