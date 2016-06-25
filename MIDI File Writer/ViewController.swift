//
//  ViewController.swift
//  MIDI File Writer
//
//  Created by Andrew Madsen on 6/25/16.
//  Copyright © 2016 Mixed In Key. All rights reserved.
//

import Cocoa
import MIKMIDI

class ViewController: NSViewController {
	
	
	@IBAction func writeMIDIFile(sender: AnyObject) {
		let savePanel = NSSavePanel()
		savePanel.allowedFileTypes = ["mid"]
		savePanel.beginSheetModalForWindow(view.window!) { (result) in
			guard let url = savePanel.URL where result == NSFileHandlingPanelOKButton else { return }
			
			let sequence = MIKMIDISequence()
			let track = try! sequence.addTrack()
			track.events = [MIKMIDINoteEvent(timeStamp: 0, note: 60, velocity: 127, duration: 0.5, channel: 0)!,
			                MIKMIDINoteEvent(timeStamp: 1, note: 61, velocity: 127, duration: 0.5, channel: 0)!,
			                MIKMIDINoteEvent(timeStamp: 2, note: 62, velocity: 127, duration: 0.5, channel: 0)!,
			                MIKMIDINoteEvent(timeStamp: 3, note: 63, velocity: 127, duration: 0.5, channel: 0)!]
			do {
				try sequence.writeToURL(url)
			} catch let error as NSError {
				print("Error writing MIDI sequence to file: \(error)")
				self.presentError(error)
			}
		}
	}
	
}

