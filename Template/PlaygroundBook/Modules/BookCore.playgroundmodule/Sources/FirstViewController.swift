//
//  FirstViewController.swift
//  BookCore
//
//  Created by Albert Rayneer on 01/04/21.
//

import UIKit
import PlaygroundSupport

public class FirstViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    public var difficulty: Int = 0
    public var toys = [UIImageView]()
    private var draggingToy: UIImageView? = nil
    private var setToysPosition = false
    private var isDragging: Bool {
        draggingToy != nil
    }
    private var chest: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "chest")
        return view
    }()
    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "roomBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 42, weight: .bold)
        label.textColor = .white
        return label
    }()
    var time = 0
    var storedToys = 0
    var storeToy = false
    var didWin = false {
        didSet {
            displayWin()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        setupBackground()
        setupChest()
        setupTimer()
        setupToys(with: difficulty)
        startTimerIfNeeded()
        self.storedToys = 0
        MusicHelper.playBackgroundMusic()
    }
    
    public override func viewDidLayoutSubviews() {
        setupToysPositionIfNeeded()
    }
    
    private func setupBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupChest() {
        chest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chest)
        NSLayoutConstraint.activate([
            chest.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width * 0.08),
            chest.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.frame.width * 0.08)),
            chest.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24),
            chest.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupTimer() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            timeLabel.trailingAnchor.constraint(equalTo: chest.trailingAnchor),
        ])
    }

    private func startTimerIfNeeded() {
        guard difficulty != 0 else { return }
        time = 100/difficulty
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        guard !didWin, time > 0 else { return }
        time -= 1
        timeLabel.text = time > 9 ? "00:\(time)" : "00:0\(time)"
        verifyWin()
    }
    
    public func setupToys(with quantity: Int) {
        guard quantity > 0 else { return }
        var views = [UIImageView]()
        for i in 0...quantity {
            let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            view.image = UIImage(named: "toy\(i)")
            view.contentMode = .scaleAspectFit
            view.isUserInteractionEnabled = true
            self.view.addSubview(view)
            views.append(view)
        }
        self.toys = views
    }
    
    private func setupToysPositionIfNeeded() {
        guard !setToysPosition else { return }
        toys.forEach { (toy) in
            toy.center = CGPoint(x: CGFloat.random(in: toy.frame.width/2...(self.view.frame.width - toy.frame.width/2)),
                                 y: CGFloat.random(in: self.view.frame.height/1.5...self.view.frame.height - 120))
        }
        setToysPosition = true
    }
    
    private func verifyWin() {
        if storedToys >= difficulty {
            didWin = true
        } else if time <= 0 {
            view.isUserInteractionEnabled = false
            PlaygroundPage.current.assessmentStatus = .fail(hints: ["Not this time! Try to put the toys faster next time"], solution: nil)
        }
    }
    
    @objc func displayWin() {
        guard !toys.isEmpty else { return }
        if didWin {
            SoundHelper.instance.playSound(resource: "won0")
            PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulations! You got it. Now your room is organized. [Next Page](@next)")
        }
    }
}

// MARK: Drag and Drop
extension FirstViewController {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDragging, let touch = touches.first else { return }
        for toy in toys {
            let location = touch.location(in: toy)
            if toy.bounds.contains(location) {
                self.draggingToy = toy
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let toy = draggingToy, let touch = touches.first else { return }
        let location = touch.location(in: view)
        toy.center = CGPoint(x: location.x, y: location.y)
        
        if chest.frame.contains(toy.frame) {
            SoundHelper.instance.playSound(resource: "toys")
            storeToy = true
            UIView.animate(withDuration: 0.2) {
                toy.alpha = 0
            } completion: { status in
                self.draggingToy = nil
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if storeToy {
            self.storedToys += 1
        }
        storeToy = false
        draggingToy = nil
        verifyWin()
    }
}
