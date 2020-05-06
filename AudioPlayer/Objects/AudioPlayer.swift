//
//  AudioPlayer.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/05/02.
//  Copyright © 2020 none. All rights reserved.
//
import SwiftUI
import AVFoundation

class AudioPlayer: ObservableObject{
	static let shared = AudioPlayer()
	private init(){}
	
	let player: AVPlayer = AVPlayer()
	var duration: TimeInterval = 1
	var isSeeking = false
	var timeObservation: Any?
	var mark: [Double] = [0]
	
	@Published var isPlaying = false
	@Published var audioSamples: [Float] = []
	@Published var fileName: String = String()
	@Published var currentTimePerDuration: CGFloat = 0
	
	@Published var repeatStartPoint: CGFloat = -1
	@Published var repeatEndPoint: CGFloat = -1
	@Published var isRepeatPlaying: Bool = false
	
	
	func initVariables(){
		player.pause()
		currentTimePerDuration = 0
		isPlaying = false
		isRepeatPlaying = false
		if let observer = timeObservation {
			player.removeTimeObserver(observer)
		}
	}
	
	func loadAudio(url: URL){
		initVariables()
		player.replaceCurrentItem(with: AVPlayerItem(url: url))
		duration=CMTimeGetSeconds((player.currentItem?.asset.duration)!)
		fileName=url.lastPathComponent
		
		//DispatchQueue.main.async {
		readAudio(audioURL: url, forChannel: 0)
		//}
		
		timeObservation = player.addPeriodicTimeObserver(
			forInterval: CMTime(seconds: 0.01, preferredTimescale: 600),
			queue: nil) {
				time in
				guard self.isPlaying && !self.isSeeking else { return }
				self.currentTimePerDuration = CGFloat(time.seconds / self.duration)
				if self.isRepeatPlaying {
					if self.currentTimePerDuration < self.repeatStartPoint - 0.01 || self.currentTimePerDuration > self.repeatEndPoint{
						self.currentTimePerDuration = self.repeatStartPoint
						self.seek()
					}
				}
				print("\(self.currentTimePerDuration)")
		}
	}
	
	func readAudio(audioURL: URL, forChannel channelNumber: Int){
		let file = try! AVAudioFile(forReading: audioURL)
		let lenOfFrame = 441//Int(audioFilePFormat.sampleRate/20)
		let lenOfSamples = Int(file.length)/lenOfFrame
		guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat,
											frameCapacity: AVAudioFrameCount(file.length))
			else {
			fatalError("error")
		}
		
		audioSamples = Array(repeating: 0, count: lenOfSamples)
		mark = [0]
		try! file.read(into: buffer)
		for i in 0..<lenOfSamples {
			let val = abs(buffer.floatChannelData![0][i * lenOfFrame])
			audioSamples[i]=(val > 1e-8 ? (20 * log10(val) + 80)/80 : 0)
//			print("\(audioSamples[i])")
			
			if audioSamples[i] > 0.1 {
				var cnt = 20
				var j = i - 1
				
				while j>=0 && audioSamples[j] < 0.1 && cnt > 0 {
					j-=1
					cnt-=1
				}
				if j == 0 || cnt == 0 {
					mark.append(Double(i)/Double(lenOfSamples))
					print("\(mark[mark.count-1])")
				}
			}
		}
		mark.append(1)
		
	}
	
	func seek(){
		let time: CMTime = CMTime(seconds: Double(currentTimePerDuration)*duration, preferredTimescale: 600)
		player.seek(to: time)
	}
	
	func seek(to time: CMTime){
		player.seek(to: time)
	}
	
	
	func getPrevPos(from :CGFloat) -> CGFloat{
		var i = mark.count - 1
		while i>0 && mark[i] >= Double(from) {
			i-=1
		}
		return CGFloat(mark[i])
	}

	func getNextPos(from :CGFloat) -> CGFloat{
		var i = 0
		while i < mark.count - 1 && mark[i] <= Double(from) {
			i+=1
		}
		return CGFloat(mark[i])
	}
}
