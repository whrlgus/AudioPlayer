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
					ControlPanelView()
					Spacer()
				}.frame(height: geometry.size.height*0.4)
			}
		}
		.sheet(isPresented: self.$showingPicker) {
			AudioPickerView()
		}
	}
}
