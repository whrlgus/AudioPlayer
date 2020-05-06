//
//  RepeatControlView.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/05/06.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI

struct RepeatControlView: View {
	@ObservedObject var audioPlayer = AudioPlayer.shared
	let viewWidth: CGFloat
	
	var body: some View {
		Color.black
			.overlay(
				HStack(spacing: 1) {
					ButtonView(basePos: $audioPlayer.repeatStartPoint, content: AnyView(Text("A")))
					repeatButton.frame(width: viewWidth/4)
					ButtonView(basePos: $audioPlayer.repeatEndPoint, content: AnyView(Text("B")))
			})
	}
	
	var repeatButton: some View {
		let content = Image(systemName: "repeat")
		return (audioPlayer.isRepeatPlaying ?
			Color.blue.overlay(content.foregroundColor(.white)) :
			Color.white.overlay(content.foregroundColor(.blue)))
			.gesture(TapGesture().onEnded{self.repeatPlay()})
	}
}


private struct ButtonView: View {
	@ObservedObject var audioPlayer = AudioPlayer.shared
	@Binding var basePos: CGFloat
	var content: AnyView
	
	var body: some View {
		Color.white.overlay(
			HStack{
				Spacer()
				Image(systemName: "chevron.left.2").gesture(TapGesture().onEnded{self.moveLeft()})
				Spacer()
				content
				Spacer()
				Image(systemName: "chevron.right.2").gesture(TapGesture().onEnded{self.moveRight()})
				Spacer()
			}
		).foregroundColor(audioPlayer.isRepeatPlaying ? .blue : .gray)
		
	}
	
	func moveLeft(){
		let tmpPos = basePos
		basePos = audioPlayer.getPrevPos(from: basePos)
		if audioPlayer.repeatStartPoint >= audioPlayer.repeatEndPoint{
			basePos = tmpPos
		}
		
	}
	func moveRight(){
		let tmpPos = basePos
		basePos = audioPlayer.getNextPos(from: basePos)
		if audioPlayer.repeatStartPoint >= audioPlayer.repeatEndPoint{
			basePos = tmpPos
		}
	}
}

extension RepeatControlView{
	func repeatPlay(){
		print("repeatPlay")
		audioPlayer.isRepeatPlaying.toggle()
		
		audioPlayer.repeatStartPoint = audioPlayer.getPrevPos(from: audioPlayer.currentTimePerDuration)
		audioPlayer.repeatEndPoint = audioPlayer.getNextPos(from: audioPlayer.currentTimePerDuration)
	}
}
