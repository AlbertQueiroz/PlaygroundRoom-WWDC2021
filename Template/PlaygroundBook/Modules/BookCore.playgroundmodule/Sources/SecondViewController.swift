//
//  SecondViewController.swift
//  BookCore
//
//  Created by Albert Rayneer on 01/04/21.
//

import UIKit
import PlaygroundSupport

public class SecondViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {

    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bedroomBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var bed: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bed0\(bedColor.rawValue)")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var directionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow0")
        return imageView
    }()
    var bedState = 0
    var directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .down]
    var didWin: Bool = false {
        didSet {
            displayWin()
        }
    }
    public var bedColor: BedColor = .yellow
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        setupBackground()
        setupBed()
        setupDirectionImage()
        setupGestureRecognizer()
        MusicHelper.playBackgroundMusic()
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
    
    private func setupBed() {
        view.addSubview(bed)
        bed.image = UIImage(named: "bed0\(bedColor.rawValue)")
        bed.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bed.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bed.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bed.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.46),
            bed.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.46)
        ])
    }

    private func setupDirectionImage() {
        view.addSubview(directionImage)
        directionImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            directionImage.topAnchor.constraint(equalTo: bed.bottomAnchor, constant: 32),
            directionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            directionImage.heightAnchor.constraint(equalToConstant: 80),
            directionImage.widthAnchor.constraint(equalTo: directionImage.heightAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(organizeBed))
        gestureRecognizer.direction = .up
        bed.addGestureRecognizer(gestureRecognizer)
    }
    
    func displayWin() {
        SoundHelper.instance.playSound(resource: "won0")
        PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations! You got it. Your bed looks great. [Next Page](@next)")
    }
    
    @objc func organizeBed() {
        if let recognizer = bed.gestureRecognizers?.first as? UISwipeGestureRecognizer,
           bedState < 4 {
            let image = UIImage(named: "bed\(self.bedState + 1)\(bedColor.rawValue)")
            self.bed.setImage(image)
            SoundHelper.instance.playSound(resource: "bed")
            if bedState < 3 {
                recognizer.direction = directions[bedState]
                directionImage.image = UIImage(named: "arrow\(bedState + 1)")
            }
            if bedState == 3 {
                didWin = true
            }
            bedState += 1
        } else {
            bed.isUserInteractionEnabled = false
        }
    }
    
}
