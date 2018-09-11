//
//  WBVisitorView.swift
//  新浪微博
//
//  Created by ljw on 2018/9/11.
//  Copyright © 2018年 ljw. All rights reserved.
//

import UIKit

/// 访客视图
class WBVisitorView: UIView {

    /// 访客视图的信息字典 [imageNmae / mesage]
    /// 提示：如果是首页 imageName == ""
    var visitorInfo: [String: String]? {
        didSet {
            // 1> 获取字典信息
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            
            // 2> 设置消息
            tipLabel.text = message
            
            // 3> 设置图像，首页不需要设置
            if imageName == "" {
                startAnimation()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            //其他控制器不需要显示这两个图片
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //旋转图标动画（首页）
    private func startAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        
        //动画完成不删除，如果 iconView 被释放，动画会一起销毁
        //重要： 如果不设置点击别的页面再回来或者回到桌面再回来动画会停止
        anim.isRemovedOnCompletion = false
        
        iconView.layer.add(anim, forKey: nil)
    }
    
    // MARK: - 私有控件
    /// 图像视图
    private lazy var iconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_image_smallicon"))
   
    /// 灰色遮挡视图
    private lazy var maskIconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 小房子
    private lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
   
    /// 提示标签
    private lazy var tipLabel: UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    
    /// 注册按钮
    private lazy var registerButton: UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    private lazy var loginButton: UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
}

// MARK: - 设置界面
extension WBVisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.cz_color(withRed: 237, green: 237, blue: 237)
        
        //1.添加视图
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        tipLabel.textAlignment = .center
        //2.取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //3.自动布局
        let margin = CGFloat(20.0)
        // - 图像视图
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: -60))
        
        // - 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerY,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0))
        
        // - 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1.0,
            constant: 236))
        
        // - 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .left,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1.0,
            constant: 100))
        
        // - 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .right,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width,
            relatedBy: .equal,
            toItem: registerButton,
            attribute: .width,
            multiplier: 1.0,
            constant: 0))
        
        // - 灰色遮罩视图
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .bottom, relatedBy: .equal, toItem: registerButton, attribute: .top, multiplier: 1.0, constant: margin * 0.5))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
    }
}

