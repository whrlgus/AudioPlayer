//
//  ControlPanelView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/05/03.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI

struct ControlPanelView: View {
	@ObservedObject var audioPlayer = AudioPlayer.shared
	
	private func onPlayButtonClicked(){
		if self.audioPlayer.player.currentItem == nil{
			print("no audio")
			return
		}
		if self.audioPlayer.isPlaying {
			self.audioPlayer.player.pause()
		}
		else {
			self.audioPlayer.player.play()
		}
		self.audioPlayer.isPlaying.toggle()
	}
	
	private func onGobackwardButtonClicked(){
		let curr = audioPlayer.currentTimePerDuration
		var i = audioPlayer.mark.count - 1
		while i>0 && audioPlayer.mark[i] >= Double(curr) {
			i-=1
		}
		audioPlayer.currentTimePerDuration = CGFloat(audioPlayer.mark[i])
		print("\(audioPlayer.mark[i])")
		audioPlayer.seek()
	}
	
	private func onGoforwardButtonClicked(){
		let curr = audioPlayer.currentTimePerDuration
		var i = 0
		while i < audioPlayer.mark.count - 1 && audioPlayer.mark[i] <= Double(curr) {
			i+=1
		}
		audioPlayer.currentTimePerDuration = CGFloat(audioPlayer.mark[i])
		print("\(audioPlayer.mark[i])")
		audioPlayer.seek()
	}
	
	
    var body: some View {
		HStack {
			Spacer()
			Button(action: self.onGobackwardButtonClicked) {
				Image(systemName: "gobackward")
					.font(.system(size: 40))
			}
			Spacer()
			Button(action: self.onPlayButtonClicked) {
				Image(systemName: !self.audioPlayer.isPlaying
					? "play.circle" : "pause.circle")
					.font(.system(size: 80))
			}
			Spacer()
			Button(action: self.onGoforwardButtonClicked) {
				Image(systemName: "goforward")
					.font(.system(size: 40))
			}
			Spacer()
		}
    }
}
