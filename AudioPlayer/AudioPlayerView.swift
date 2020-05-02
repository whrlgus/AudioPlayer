//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
	@ObservedObject var audioPlayer = AudioPlayer.shared
	@State var showingPicker = false
	
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
	
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0){
				HStack{
					Text("\(self.audioPlayer.fileName)")
					Spacer()
					Button(action: {
						self.showingPicker.toggle()
					}){
						Image(systemName: "music.note.list").font(.system(size: 30))
					}
				}.padding().frame(height: geometry.size.height*0.1)
				Rectangle().frame(height: geometry.size.height*0.5)
				VStack{
					ProgressbarView(viewWidth: geometry.size.width,
									viewHeight: geometry.size.height*0.1)
					Spacer()
					Button(action: self.onPlayButtonClicked) {
						Image(systemName: !self.audioPlayer.isPlaying
							? "play.circle" : "pause.circle")
							.font(.system(size: 100))
					}
					Spacer()
				}.frame(height: geometry.size.height*0.4)
			}
		}
		.sheet(isPresented: self.$showingPicker) {
			AudioPickerView()
		}
	}
}
