//
//  AudioPickerController.swift
//  AudioPlayer
//
//  Created by 조기현 on 2020/04/29.
//  Copyright © 2020 none. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct AudioPickerView: UIViewControllerRepresentable {
	func makeCoordinator() -> Coordinator {
		Coordinator()
	}
	
	func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<AudioPickerView>) {
	}
	
	func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
		let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeAudio)], in: .open)
		picker.delegate = context.coordinator
		return picker
	}
	
	class Coordinator: NSObject, UIDocumentPickerDelegate {
		func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
			guard let url = urls.first else { return }
			AudioPlayer.shared.loadAudio(url: url)
		}
	}
}

