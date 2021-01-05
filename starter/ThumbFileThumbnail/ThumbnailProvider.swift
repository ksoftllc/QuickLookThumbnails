/// Copyright (c) 2021 Razeware LLC
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

class ThumbnailProvider: QLThumbnailProvider {
  enum ThumbFileThumbnailError: Error {
    case unableToOpenFile(atURL: URL)
    case unableToCreateThumbnail
  }

  override func provideThumbnail(for request: QLFileThumbnailRequest, _ handler: @escaping (QLThumbnailReply?, Error?) -> Void) {
    let thumbFileURL = request.fileURL
    guard let thumbFile = ThumbFile(from: thumbFileURL) else {
      handler(nil, ThumbFileThumbnailError.unableToOpenFile(atURL: thumbFileURL))
      return
    }

    DispatchQueue.main.async {
      //1
      guard
        let image = ThumbFileViewController.generateThumbnail(
          for: thumbFile,
          size: request.maximumSize)
      else {
        handler(nil, ThumbFileThumbnailError.unableToCreateThumbnail)
        return
      }

      //2
      let reply = QLThumbnailReply(contextSize: request.maximumSize) {
        image.draw(in: CGRect(origin: .zero, size: request.maximumSize))
        return true
      }
      handler(reply, nil)
    }
  }
}
