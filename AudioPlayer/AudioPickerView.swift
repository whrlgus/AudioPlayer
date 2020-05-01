//
//  AudioPickerController.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import SwiftUI
import MobileCoreServices

protocol AudioPickerViewDelegate {
	func loadAudio(url: URL)
}

struct AudioPickerView: UIViewControllerRepresentable {
	var delegate: AudioPlayerView
	
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<AudioPickerView>) {
	}
	
	func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
		let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAudio)], in: .open)
		picker.delegate = context.coordinator
		return picker
	}
	
	class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {
		var parent: AudioPickerView
		
		init(_ parent: AudioPickerView) {
			self.parent = parent
		}
		
		func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
			guard let url = urls.first else { return }
			parent.delegate.loadAudio(url: url)
		}
	}
}

