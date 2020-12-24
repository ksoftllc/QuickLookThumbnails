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

import Foundation
import WebKit

/// Helper class to generate a snapshot of a WKWebView containing the HTML that represents a ThumbFile
class ThumbFileThumbnailGenerator: NSObject {
  let webViewLoadingSemaphore = DispatchSemaphore(value: 1)

  func provideSnapshotImage(for thumbFile: ThumbFile, scale: CGFloat, frame: CGRect, completion: @escaping (UIImage?) -> Void) {
//    //set up to block until view completes loading
//    self.webViewLoadingSemaphore.wait()
//
//    var thumbFileView: WKWebView?
//    DispatchQueue.main.async {
//      thumbFileView = self.loadThumbFileView(for: thumbFile, in: frame, scale: scale)
//    }
//
//    //wait until loading completes but not on main thread
//    self.webViewLoadingSemaphore.wait()
//
//    DispatchQueue.main.async {
//      //clear the first wait
//      self.webViewLoadingSemaphore.signal()
//
//      thumbFileView?.takeSnapshot(with: nil) { snapshot, _ in
//        guard var snapshot = snapshot else {
//          completion(nil)
//          return
//        }
//
//        if snapshot.scale != scale, let cgImage = snapshot.cgImage {
//          snapshot = UIImage(cgImage: cgImage, scale: scale, orientation: .up)
//        }
//
//        completion(snapshot)
//      }
//    }
  }

//  func loadThumbFileView(for thumbFile: ThumbFile, in frame: CGRect, scale: CGFloat) -> WKWebView {
//    let thumbFileView = WKWebView(frame: frame)
//    thumbFileView.navigationDelegate = self
//    thumbFileView.pageZoom = scale
//    thumbFileView.layoutIfNeeded()
//    thumbFileView.loadHTMLString(thumbFile.asHtml, baseURL: nil)
//    return thumbFileView
//  }
}

// MARK: - WKNavigationDelegate
//extension ThumbFileThumbnailGenerator: WKNavigationDelegate {
//  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
//    //signal that loading is complete
//    webViewLoadingSemaphore.signal()
//  }
//}
