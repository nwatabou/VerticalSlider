//
//  ViewController.swift
//  VerticalSliderbar
//
//  Created by nancy on 2019/07/15.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// スライダーの可動域
    @IBOutlet weak var baseView: UIView!
    /// スライダーのつまみ部分
    @IBOutlet weak var sliderView: UIView!
    /// スライダー可動域の上限値
    private var baseViewMaxY: CGFloat!
    /// スライダー可動域の下限値
    private var baseViewMinY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
    }
    
    /// スライダーのつまみをドラッグしたのを検知
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
            let movedView = touch.view else {
                return
        }
        // ドラッグした view がつまみ（sliderView）ではなければ何もしない
        guard movedView == sliderView else {
            return
        }
        moveSliderView(to: touch.location(in: view))
    }
    
    /// スライダーの描画設定
    private func setupSlider() {
        let baseViewHalfWidth = baseView.frame.width / 2.0
        let sliderViewHalfWidth = sliderView.frame.width / 2.0
        /*
         上限値を baseView.frame.maxY or minY で取得しており、
         sliderView を動かす際は sliderView.center の値を変更して動かしているため、
         可動域ぴったりに収まるよう調節
         */
        baseViewMaxY = baseView.frame.maxY - baseViewHalfWidth
        baseViewMinY = baseView.frame.minY + sliderViewHalfWidth
        baseView.layer.cornerRadius = baseViewHalfWidth
        sliderView.layer.cornerRadius = sliderViewHalfWidth
    }
    
    /// つまみを移動させる処理
    private func moveSliderView(to point: CGPoint) {
        var movePoint = CGPoint(x: sliderView.center.x,
                                y: point.y)
        if movePoint.y > baseViewMaxY {
            movePoint.y = baseViewMaxY
        }
        
        if movePoint.y < baseViewMinY {
            movePoint.y = baseViewMinY
        }
        sliderView.center = movePoint
    }
}
