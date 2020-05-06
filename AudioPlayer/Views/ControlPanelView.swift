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
	
	
	var body: some View {
		GeometryReader{ geometry in
			
			VStack(spacing: 0){
				RepeatControlView(viewWidth: geometry.size.width)
					.border(Color.black)
					.frame(height: geometry.size.height*0.2)
				Spacer()
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
				Spacer()
			}
		}
	}
}



extension ControlPanelView{
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
		audioPlayer.currentTimePerDuration = audioPlayer.getPrevPos(from: audioPlayer.currentTimePerDuration)
		audioPlayer.seek()
	}
	
	private func onGoforwardButtonClicked(){
		audioPlayer.currentTimePerDuration = audioPlayer.getNextPos(from: audioPlayer.currentTimePerDuration)
		audioPlayer.seek()
	}
}
