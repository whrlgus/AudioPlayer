//
//  Utility.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/05/01.
//  Copyright © 2020 none. All rights reserved.
//

import AVFoundation

func readAudio(audioURL: URL, forChannel channelNumber: Int) -> [Float] {
	let file = try! AVAudioFile(forReading: audioURL)
	let lenOfFrame = 441//Int(audioFilePFormat.sampleRate/20)
	let lenOfSamples = Int(file.length)/lenOfFrame
	guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat,frameCapacity: AVAudioFrameCount(file.length)) else {
		fatalError("error")
	}

	var samples : [Float] = Array(repeating: 0, count: lenOfSamples)
	try! file.read(into: buffer)
	for i in 0..<lenOfSamples {
		let val = abs(buffer.floatChannelData![0][i * lenOfFrame])
		samples[i]=(val > 1e-8 ? (20 * log10(val) + 80)/80 : 0)
	}
	return samples
}
