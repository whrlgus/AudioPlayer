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

struct AudioPickerController: UIViewControllerRepresentable {
	var delegate: AudioPlayerView
	
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<AudioPickerController>) {
	}
	
	func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
		let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAudio)], in: .open)
		picker.delegate = context.coordinator
		return picker
	}
	
	class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate {
		var parent: AudioPickerController
		
		init(_ parent: AudioPickerController) {
			self.parent = parent
		}
		
		func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
			guard let url = urls.first else { return }
			parent.delegate.loadAudio(url: url)
		}
	}
}

