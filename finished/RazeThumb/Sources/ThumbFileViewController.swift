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

class ThumbFileViewController: UIViewController {
  var titleLabel: UILabel?
  var imageView: UIImageView?

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
  }

  func loadThumbFileView(for thumbFile: ThumbFile) {
    addTitleToView(thumbFile.title)
    addThumbImageToView(thumbFile.uiImage)
  }

  func addTitleToView(_ title: String) {
    titleLabel = UILabel()
    guard let titleLabel = self.titleLabel else { return }
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    titleLabel.text = title
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
      titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
    ])
  }

  func addThumbImageToView(_ image: UIImage?) {
    imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    guard let imageView = imageView else { return }
    guard let titleLabel = titleLabel else { return }
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = image
    view.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50.0),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  static func generateThumbnail(for thumbFile: ThumbFile, size: CGSize) -> UIImage? {
    let thumbFileViewController = ThumbFileViewController()
    thumbFileViewController.view.frame = CGRect(origin: .zero, size: CGSize(width: 450, height: 450))
    thumbFileViewController.loadThumbFileView(for: thumbFile)
    thumbFileViewController.view.updateConstraintsIfNeeded()
    thumbFileViewController.view.layoutIfNeeded()

    return thumbFileViewController.snapshot(size: size)
  }

  func snapshot(size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(view.frame.size)
    guard let context = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return nil
    }

    view.layer.render(in: context)
    guard let snapshot = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      return nil
    }

    return scaleImage(snapshot, to: size)
  }

  func scaleImage(_ snapshot: UIImage, to size: CGSize) -> UIImage? {
    UIGraphicsEndImageContext()
    UIGraphicsBeginImageContext(size)
    snapshot.draw(in: CGRect(origin: .zero, size: size))
    let scaledSnapshot = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledSnapshot
  }
}
