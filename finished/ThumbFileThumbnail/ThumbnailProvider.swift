/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import QuickLookThumbnailing
import WebKit

class ThumbnailProvider: QLThumbnailProvider {
  enum ThumbFileThumbnailError: Error {
    case unableToOpenFile(atURL: URL)
    case unableToCreateThumbnail
  }

  //  let thumbnailGenerator = ThumbFileThumbnailGenerator()
  var handler: (QLThumbnailReply?, Error?) -> Void = { _, _ in }

  override func provideThumbnail(for request: QLFileThumbnailRequest, _ handler: @escaping (QLThumbnailReply?, Error?) -> Void) {
    let thumbFileURL = request.fileURL
    guard let thumbFile = ThumbFile(from: thumbFileURL) else {
      handler(nil, ThumbFileThumbnailError.unableToOpenFile(atURL: thumbFileURL))
      return
    }

    print("provide thumbnail for \(thumbFileURL)")
    DispatchQueue.main.async {
      print("reply on main thread \(Thread.isMainThread)")
      let thumbFileViewController = ThumbFileViewController()
      thumbFileViewController.view.frame = CGRect(origin: .zero, size: request.maximumSize)
      thumbFileViewController.loadThumbFileView(for: thumbFile)
      thumbFileViewController.view.layoutIfNeeded()
      thumbFileViewController.view.contentScaleFactor /= request.scale
      let reply = QLThumbnailReply(contextSize: request.maximumSize) { () -> Bool in
        print("current context drawing closure")
        thumbFileViewController.view.draw(thumbFileViewController.view.bounds)
        return true
      }
      self.handler(reply, nil)
      print("reply sent")

      //      if let snapshot = thumbFileViewController.view.snapshotView(afterScreenUpdates: true) {
      //        let reply = QLThumbnailReply(contextSize: request.maximumSize) {
      //          snapshot.draw(CGRect(origin: .zero, size: request.maximumSize))
      //          return true
      //        }
      //        self.handler(reply, nil)
      //      } else {
      //        self.handler(nil, ThumbFileThumbnailError.unableToCreateThumbnail)
      //      }
    }
    //
    //    let maximumSize = request.maximumSize
    //    let scale = request.scale
    //    let frame = CGRect(origin: .zero, size: maximumSize)
    //    self.handler = handler
    //
    //    thumbnailGenerator.provideSnapshotImage(for: thumbFile, scale: scale, frame: frame) { thumbnailImage in
    //      if let thumbnailImage = thumbnailImage {
    //        let reply = QLThumbnailReply(contextSize: maximumSize) {
    //          thumbnailImage.draw(at: .zero)
    //          return true
    //        }
    //        self.handler(reply, nil)
    //      } else {
    //        self.handler(nil, ThumbFileThumbnailError.unableToCreateThumbnail)
    //      }
    //    }
  }
}
