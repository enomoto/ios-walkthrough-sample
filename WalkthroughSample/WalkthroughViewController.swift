//
//  WalkthroughViewController.swift
//  WalkthroughSample
//
//  Created by kenta.enomoto on 2018/08/28.
//

import UIKit

final class WalkthroughViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()

        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .red
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeObservers()
        super.viewWillDisappear(animated)
    }

    // MARK: - KVO

    private var keyValueObservations = [NSKeyValueObservation]()

    private func addObservers() {
        let kvo = scrollView.observe(\.contentOffset, options: [.new]) { _, change  in
            guard let newValue = change.newValue?.x else {
                return
            }

            let width = self.view.frame.width
            if newValue.truncatingRemainder(dividingBy: width) == 0 {
                self.pageControl.currentPage = Int(newValue / width)
            }
        }
        keyValueObservations.append(kvo)
    }

    private func removeObservers() {
        for kvo in keyValueObservations {
            kvo.invalidate()
        }
        keyValueObservations.removeAll()
    }
}
