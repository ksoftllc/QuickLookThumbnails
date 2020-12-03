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

import UIKit.UIScreen
import QuickLookThumbnailing

struct Document: Hashable {
  let url: URL

  init(url: URL) {
    self.url = url
  }

  var fullName: String {
    url.lastPathComponent
  }
}

// MARK: - Static helper methods
extension Document {
  static let files = [
    Bundle.main.url(forResource: "zombiethumb", withExtension: "png"),
    Bundle.main.url(forResource: "thumbsup", withExtension: "txt"),
    Bundle.main.url(forResource: "humanthumb", withExtension: "pdf"),
    Bundle.main.url(forResource: "thumbsdown", withExtension: "html"),
    Bundle.main.url(forResource: "thumbsdown", withExtension: "md")
  ]
  .compactMap { $0 }

  static var documents: [Document] {
    let urls: [URL]
    do {
      urls = try FileManager.default.contentsOfDirectory(at: temporaryDirectoryURL, includingPropertiesForKeys: nil)
    } catch {
      fatalError("Couldn't load files from documents directory")
    }

    return urls.map { Document(url: $0) }
  }

  static var temporaryDirectoryURL: URL {
    URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
  }

  static func copyResourcesToTemporaryDirectory() {
    files.forEach { resourceFileURL in
      let filename = resourceFileURL.lastPathComponent
      let destinationURL = temporaryDirectoryURL.appendingPathComponent(filename)

      if FileManager.default.fileExists(atPath: destinationURL.path) {
        do {
          try FileManager.default.removeItem(at: destinationURL)
        } catch {
          print("error deleting \(destinationURL) - \(error.localizedDescription)")
        }
      }

      do {
        try FileManager.default.copyItem(at: resourceFileURL, to: destinationURL)
      } catch {
        print("error copying file \(destinationURL) to temporary directory - \(error.localizedDescription)")
      }
    }
  }
}

// MARK: - QLThumbnailGenerator
extension Document {
  func generateThumbnail(completion: @escaping (UIImage) -> Void) {
    let size = CGSize(width: 150, height: 150)
    let scale = UIScreen.main.scale

    let request = QLThumbnailGenerator.Request(
      fileAt: url,
      size: size,
      scale: scale,
      representationTypes: .all)

    let generator = QLThumbnailGenerator.shared
    generator.generateRepresentations(for: request) { thumbnail, _, error in
      if let thumbnail = thumbnail {
        completion(thumbnail.uiImage)
      } else if let error = error {
        print("thumbnail error for \(fullName) - \(error)")
      }
    }
  }
}
