//
//  VideoPlayerAttachment.swift
//  InlineVideoPlayer
//
//  Created by Yoshimasa Niwa on 10/18/23.
//

import UIKit

final class VideoPlayerAttachmentProvider: NSTextAttachmentViewProvider {
    override func loadView() {
        view = VideoPlayerView()
    }

    override func attachmentBounds(
        for attributes: [NSAttributedString.Key : Any],
        location: NSTextLocation,
        textContainer: NSTextContainer?,
        proposedLineFragment: CGRect,
        position: CGPoint
    ) -> CGRect {
        CGRect(x: 0.0, y: 0.0, width: proposedLineFragment.width, height: 100.0)
    }

    var videoURL: URL? {
        didSet {
            guard oldValue != videoURL else {
                return
            }
            guard let videoPlayerView = view as? VideoPlayerView else {
                return
            }
            videoPlayerView.videoURL = videoURL
        }
    }
}

final class VideoPlayerAttachment: NSTextAttachment {
    let videoURL: URL

    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(data: nil, ofType: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewProvider(
        for parentView: UIView?,
        location: NSTextLocation,
        textContainer: NSTextContainer?
    ) -> NSTextAttachmentViewProvider? {
        let viewProvider = VideoPlayerAttachmentProvider(
            textAttachment: self,
            parentView: parentView,
            textLayoutManager: textContainer?.textLayoutManager,
            location: location
        )
        viewProvider.tracksTextAttachmentViewBounds = true
        viewProvider.videoURL = videoURL
        return viewProvider
    }
}
