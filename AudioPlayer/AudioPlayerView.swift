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
	let player: AVPlayer=AVPlayer()
	@State var playerPaused = true
	
	@State var fileName: String = String()
	
    @State var showingPicker = false

	func loadAudio(url: URL){
		fileName=url.lastPathComponent
		player.replaceCurrentItem(with: AVPlayerItem(url: url))
	}
	
	var body: some View {
		VStack{
			Button(action: {
				self.showingPicker.toggle()
			}){
				Text("select file")
			}
			Text("\(fileName)")
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
				Image(systemName: playerPaused ? "play" : "pause")
			}
			
		}.sheet(isPresented: $showingPicker) {
			AudioPickerController(delegate: self)
		}
	}
}

struct AudioPlayerView_Previews: PreviewProvider {
	static var previews: some View {
		AudioPlayerView()
	}
}
