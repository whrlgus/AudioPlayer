//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import AVFoundation

protocol AudioPlayerDelegate {
	func loadAudio(url: URL)
}

struct AudioPlayerView: View, AudioPlayerDelegate {
	let player: AVPlayer = AVPlayer()
	var audioSamples: [Float] = []
	@State var playerPaused = true
	
	@State var fileName: String = String()
	
	@State var showingPicker = false
	
	func loadAudio(url: URL){
		fileName=url.lastPathComponent
		player.replaceCurrentItem(with: AVPlayerItem(url: url))
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack(spacing: 0){
				HStack{
					Text("\(self.fileName)")
					Spacer()
					Button(action: {
						self.showingPicker.toggle()
					}){
						Image(systemName: "music.note.list").font(.system(size: 30))
					}
				}.padding().frame(height: geometry.size.height*0.1)
				Rectangle().frame(height: geometry.size.height*0.5)
				VStack{
					ProgressbarView(audioSamples: self.audioSamples,
									viewWidth: geometry.size.width,
									viewHeight: geometry.size.height*0.1)
					Spacer()
					Button(action: {
						if self.player.currentItem == nil{
							print("no audio")
							return
						}
						if self.playerPaused {
							print("play")
							self.player.play()
						}
						else {
							print("pause")
							self.player.pause()
						}
						self.playerPaused.toggle()
					}) {
						Image(systemName: self.playerPaused ? "play.circle" : "pause.circle").font(.system(size: 100))
					}
					Spacer()
				}.frame(height: geometry.size.height*0.4)
			}
		}
		.sheet(isPresented: self.$showingPicker) {
			AudioPickerController(delegate: self)
		}
	}
}

struct AudioPlayerView_Previews: PreviewProvider {
	static var previews: some View {
		AudioPlayerView()
	}
}
