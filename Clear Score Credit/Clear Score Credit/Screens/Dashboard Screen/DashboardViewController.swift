//
//  DashboardViewController.swift
//  Clear Score Credit
//
//  Created by Haresh Ghatala on 9/2/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var scoreContainerView: UIView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var scoreInfoContainerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    let viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bindDataToController = {
            self.dataBindingHandler()
        }
        viewModel.serviceFailur = {
            // Handle UI change if any for service faliur
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    func setupView() {
        scoreContainerView.layer.cornerRadius = scoreContainerView.frame.width / 2
        scoreContainerView.layer.borderWidth = 2
        scoreContainerView.layer.borderColor = UIColor.black.cgColor
        
        circularProgressView.layer.cornerRadius = circularProgressView.frame.width / 2
        circularProgressView.fillColor = .systemYellow
        
        scoreInfoContainerView.layer.cornerRadius = scoreInfoContainerView.frame.width / 2
    }
    
    func dataBindingHandler() {
        scoreLabel.text = "\(viewModel.getCreditScore())"
        maxScoreLabel.text = "out of \(viewModel.getMaxCreditScore())"
        circularProgressView.progress = viewModel.getScorePercentage()
    }
}
