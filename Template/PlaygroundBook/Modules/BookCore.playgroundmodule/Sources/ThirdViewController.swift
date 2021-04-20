//
//  ThirdViewController.swift
//  BookCore
//
//  Created by Albert Rayneer on 01/04/21.
//

import UIKit
import PlaygroundSupport

public class ThirdViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    public var canvas: Canvas?
    
    public var pencilColor: PencilColor = .red
    public var dottedLineLenght = 20
    public var dottedLineInterval = 14
    
    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ipadTable")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var ipadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(openIpad), for: .touchUpInside)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupIpadButton()
        setupBackground()
        MusicHelper.playBackgroundMusic()
    }
    
    public override func viewDidLayoutSubviews() {
        reset()
    }
    
    private func reset() {
        canvas = Canvas()
        canvas?.pencilColor = pencilColor
        canvas?.dottedLineLenght = dottedLineLenght
        canvas?.dottedLineInterval = dottedLineInterval
        view.addSubview(canvas!)
        canvas?.backgroundColor = .white
        canvas?.frame = view.frame
        canvas?.isHidden = true
        canvas?.drawDottedLine(start: view.center, end: view.layer.anchorPoint, view: view)
        ipadButton.isHidden = false
    }
    
    private func setupBackground() {
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupIpadButton() {
        view.addSubview(ipadButton)
        ipadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ipadButton.topAnchor.constraint(equalTo: view.centerYAnchor),
            ipadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ipadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ipadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func openIpad() {
        SoundHelper.instance.playSound(resource: "ipad")
        background.image = UIImage(named: "ipadOpen")
        canvas?.isHidden = false
        
        ipadButton.isHidden = true
    }

}
