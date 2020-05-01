//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import AVFoundation


struct AudioPlayerView: View, AudioPickerViewDelegate {
	let player: AVPlayer = AVPlayer()
	@State var audioSamples: [Float] = []
	@State var isPlaying = false
	
	@State var fileName: String = String()
	@State var timeObservation: Any?
	
	@State var showingPicker = false
	@State var duration: TimeInterval = 1
	@State var currentTime: TimeInterval = 0
	
	func loadAudio(url: URL){
		fileName=url.lastPathComponent
		player.replaceCurrentItem(with: AVPlayerItem(url: url))
		duration=CMTimeGetSeconds((player.currentItem?.asset.duration)!)
		DispatchQueue.global(qos: .background).async {
			self.audioSamples=readAudio(audioURL: url, forChannel: 0)
		}
	}
	
	func playAudio(){
		print("play")
		self.player.play()
		self.timeObservation = self.player.addPeriodicTimeObserver(
			forInterval: CMTime(seconds: 0.01, preferredTimescale: 600),
			queue: nil) {
				time in
				guard self.isPlaying else { return }
				self.currentTime = time.seconds / self.duration
				print("\(self.currentTime)")
		}
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
					ProgressbarView(player: self.player,
									audioSamples: self.audioSamples,
									viewWidth: geometry.size.width,
									viewHeight: geometry.size.height*0.1,
									currentTime: self.$currentTime,
									isPlaying: self.$isPlaying)
					Spacer()
					Button(action: {
						if self.player.currentItem == nil{
							print("no audio")
							return
						}
						if self.isPlaying {
							print("pause")
							self.player.pause()
						}
						else {
							self.playAudio()
						}
						self.isPlaying.toggle()
					}) {
						Image(systemName: !self.isPlaying ? "play.circle" : "pause.circle").font(.system(size: 100))
					}
					Spacer()
				}.frame(height: geometry.size.height*0.4)
			}
		}
		.sheet(isPresented: self.$showingPicker) {
			AudioPickerView(delegate: self)
		}
	}
}

struct AudioPlayerView_Previews: PreviewProvider {
	static var previews: some View {
		AudioPlayerView()
	}
}
