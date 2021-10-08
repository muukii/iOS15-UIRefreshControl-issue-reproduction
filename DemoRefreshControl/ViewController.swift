//
//  ViewController.swift
//  DemoRefreshControl
//
//  Created by Muukii on 2021/10/08.
//

import MondrianLayout
import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    let contentView = UIView()
    contentView.backgroundColor = .systemOrange

    let scrollView = UIScrollView()

    scrollView.addSubview(contentView)
    scrollView.alwaysBounceVertical = true
    contentView.mondrian.layout
      .height(.exact(300))
      .top(.to(scrollView.contentLayoutGuide))
      .horizontal(.to(scrollView.frameLayoutGuide))
      .activate()

    let refreshControl = UIRefreshControl()

    scrollView.addSubview(refreshControl)

    view.mondrian.buildSubviews {
      ZStackBlock(alignment: .attach(.all)) {
        scrollView
      }
    }

    refreshControl.addAction(
      .init(handler: { [unowned refreshControl] action in

        if refreshControl.isRefreshing {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            refreshControl.endRefreshing()
          }
        }
      }),
      for: .valueChanged
    )

  }

}
