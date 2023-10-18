//
//  ViewController.swift
//  InlineVideoPlayer
//
//  Created by Yoshimasa Niwa on 10/18/23.
//

import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        var constraints = [NSLayoutConstraint]()
        defer {
            NSLayoutConstraint.activate(constraints)
        }

        let textContentStorage = NSTextContentStorage()
        let textLayoutManager = NSTextLayoutManager()
        textContentStorage.addTextLayoutManager(textLayoutManager)
        let textContainer = NSTextContainer()
        textLayoutManager.textContainer = textContainer
        let textView = TextView(frame: .zero, textContainer: textContainer)

        let attributes: [NSAttributedString.Key: AnyObject] = [
            .font: UIFont.systemFont(ofSize: 40.0)
        ]
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "I am a cat.", attributes: attributes))

        // Append inline video player attachment.
        let videoURL = Bundle.main.url(forResource: "cat", withExtension: "mp4")!
        attributedText.append(NSAttributedString(attachment: VideoPlayerAttachment(videoURL: videoURL)))

        attributedText.append(NSAttributedString(string: "I don't have name yet.", attributes: attributes))

        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isSelectable = false

        textView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: [
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        view.addSubview(textView)
    }
}
